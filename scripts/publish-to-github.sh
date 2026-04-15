#!/usr/bin/env bash
# Create github.com/$ORG/$REPO (if token provided) and push this repository.
set -euo pipefail

REPO_NAME="${1:-EAC-Training-Bundle}"
ORG="${GITHUB_ORG:-branson124}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repository: $ROOT"
  exit 1
fi

REMOTE_URL="https://github.com/${ORG}/${REPO_NAME}.git"

if git remote get-url origin >/dev/null 2>&1; then
  echo "Remote 'origin' already set: $(git remote get-url origin)"
else
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    echo "Creating repository ${ORG}/${REPO_NAME} via GitHub API..."
    HTTP_CODE=$(curl -sS -o /tmp/gh-create-repo.json -w '%{http_code}' -X POST \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "https://api.github.com/user/repos" \
      -d "{\"name\":\"${REPO_NAME}\",\"private\":false,\"description\":\"EAC contractor training bundle (docs + CRM submodule)\"}")
    if [[ "$HTTP_CODE" != "201" ]]; then
      echo "API returned HTTP $HTTP_CODE. Response:"
      cat /tmp/gh-create-repo.json
      echo ""
      echo "If the repo already exists, add the remote manually:"
      echo "  git remote add origin ${REMOTE_URL}"
      exit 1
    fi
    echo "Repository created."
  else
    echo "GITHUB_TOKEN not set — cannot create the repo via API."
    echo "Create an empty repo named '${REPO_NAME}' under https://github.com/${ORG} (no README), then run:"
    echo "  git remote add origin ${REMOTE_URL}"
    echo "  git push -u origin main"
    exit 0
  fi
  git remote add origin "$REMOTE_URL"
fi

echo "Pushing to origin (submodule refs included)..."
git push -u origin main
