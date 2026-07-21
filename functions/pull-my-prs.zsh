# Fetch & pull all my branches with open PRs (including drafts), rebasing main-based
# PRs onto main and force-pushing; clean up merged/closed branches and their worktrees
pullmy() {
  local original_branch
  original_branch=$(git symbolic-ref --short HEAD)

  # Remove the worktree checked out on a given branch, if one exists
  _pullmy_remove_worktree() {
    local target="$1" path="" line
    while IFS= read -r line; do
      case "$line" in
        worktree\ *) path="${line#worktree }" ;;
        branch\ refs/heads/*)
          if [[ "${line#branch refs/heads/}" == "$target" ]]; then
            echo "Removing worktree for $target: $path"
            git worktree remove --force "$path"
          fi
          ;;
      esac
    done < <(git worktree list --porcelain)
  }

  # Fetch to get up-to-date remote refs
  git fetch --prune --quiet

  # Drop stale worktree registrations (e.g. a worktree dir that was deleted),
  # so their branches aren't reported as "used by worktree" and can be cleaned up
  git worktree prune

  # Clean up local branches (and worktrees) whose PRs have been merged
  local merged
  merged=$(gh pr list --author @me --state merged --json headRefName --jq '.[].headRefName')
  if [[ -n "$merged" ]]; then
    while IFS= read -r branch; do
      _pullmy_remove_worktree "$branch"
      if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "Deleting merged branch: $branch"
        git branch -D "$branch"
      fi
    done <<< "$merged"
  fi

  # Clean up local branches (and worktrees) whose PRs have been closed without merge
  local closed
  closed=$(gh pr list --author @me --state closed --json headRefName --jq '.[].headRefName')
  if [[ -n "$closed" ]]; then
    while IFS= read -r branch; do
      _pullmy_remove_worktree "$branch"
      if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "Deleting closed branch: $branch"
        git branch -D "$branch"
      fi
    done <<< "$closed"
  fi

  # Pull branches with open PRs (includes drafts and ready-for-review)
  local branches
  branches=$(gh pr list --author @me --state open --json headRefName,baseRefName \
             --jq '.[] | "\(.headRefName)\t\(.baseRefName)"')
  if [[ -z "$branches" ]]; then
    echo "No open PRs found."
    git worktree prune
    return 0
  fi

  git stash --quiet 2>/dev/null
  local stashed=$?
  while IFS=$'\t' read -r branch base; do
    echo "--- $branch ---"
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      git checkout "$branch"
    else
      git checkout -b "$branch" "origin/$branch" 2>/dev/null || {
        echo "  Could not check out origin/$branch, skipping"
        continue
      }
    fi

    # Sync branch with its own remote first
    git pull --ff-only 2>/dev/null

    # Only rebase branches based directly on main; leave stacked PRs alone
    if [[ "$base" == "main" ]]; then
      if git rebase origin/main; then
        git push --force-with-lease
      else
        echo "  Rebase conflict on $branch — aborting, resolve manually"
        git rebase --abort
      fi
    else
      echo "  Base is '$base', not main — skipping rebase"
    fi
  done <<< "$branches"
  git checkout "$original_branch"
  [[ $stashed -eq 0 ]] && git stash pop --quiet

  git worktree prune
}
