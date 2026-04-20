# Fetch & pull all my branches with open PRs (including drafts), clean up merged ones
pullmy() {
  local original_branch
  original_branch=$(git symbolic-ref --short HEAD)

  # Fetch to get up-to-date remote refs
  git fetch --prune --quiet

  # Clean up local branches whose PRs have been merged
  local merged
  merged=$(gh pr list --author @me --state merged --json headRefName --jq '.[].headRefName')
  if [[ -n "$merged" ]]; then
    while IFS= read -r branch; do
      if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "Deleting merged branch: $branch"
        git branch -D "$branch"
      fi
    done <<< "$merged"
  fi

  # Clean up local branches whose PRs have been closed without merge
  local closed
  closed=$(gh pr list --author @me --state closed --json headRefName --jq '.[].headRefName')
  if [[ -n "$closed" ]]; then
    while IFS= read -r branch; do
      if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "Deleting closed branch: $branch"
        git branch -D "$branch"
      fi
    done <<< "$closed"
  fi

  # Pull branches with open PRs (includes drafts and ready-for-review)
  local branches
  branches=$(gh pr list --author @me --state open --json headRefName --jq '.[].headRefName')
  if [[ -z "$branches" ]]; then
    echo "No open PRs found."
    return 0
  fi

  git stash --quiet 2>/dev/null
  local stashed=$?
  while IFS= read -r branch; do
    echo "--- $branch ---"
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      git checkout "$branch"
    else
      git checkout -b "$branch" "origin/$branch" 2>/dev/null || {
        echo "  Could not check out origin/$branch, skipping"
        continue
      }
    fi
    git pull --ff-only || git pull --rebase
  done <<< "$branches"
  git checkout "$original_branch"
  [[ $stashed -eq 0 ]] && git stash pop --quiet
}
