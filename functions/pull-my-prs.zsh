# Fetch & pull all my branches with open PRs, clean up merged ones
pull-my-prs() {
  local original_branch
  original_branch=$(git symbolic-ref --short HEAD)

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

  # Fetch & pull branches with open PRs
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
    git checkout "$branch" 2>/dev/null || git checkout -b "$branch" "origin/$branch" 2>/dev/null
    git pull
  done <<< "$branches"
  git checkout "$original_branch"
  [[ $stashed -eq 0 ]] && git stash pop --quiet
}
