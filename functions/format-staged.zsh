# Prettier format staged files
format-staged() {
  git diff --cached --name-only --diff-filter=ACM \
    | grep -E '\.(js|jsx|ts|tsx|json|css|scss|md)$' \
    | xargs -r npx prettier --write
}
