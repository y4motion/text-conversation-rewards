#!/bin/bash

# Array of branch:issue
declare -A branches=(
  ["fix/github-decoupling-385-clean"]="385"
  ["fix/retry-token-limits-330-clean"]="330"
  ["fix/differential-rewards-301-clean"]="301"
  ["fix/credit-research-296-clean"]="296"
  ["fix/relevance-scoring-223-clean"]="223"
  ["fix/cryptic-error-271-clean"]="271"
  ["fix/validate-rewards-455-clean"]="455"
  ["fix/non-collab-pr-527-clean"]="527"
)

for branch in "${!branches[@]}"; do
  issue="${branches[$branch]}"
  echo "Creating PR for branch $branch closing issue $issue..."
  
  # Ensure we have the branch locally or fetch it
  git fetch origin $branch
  
  # Get the last commit message for the title
  title=$(git log -1 --format=%s origin/$branch)
  
  gh pr create \
    --repo ubiquity-os-marketplace/text-conversation-rewards \
    --head y4motion:$branch \
    --title "$title" \
    --body "Closes #$issue" || echo "Failed to create PR for $branch"
done
