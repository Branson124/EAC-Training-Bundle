# Publish this bundle to GitHub

The umbrella repo did not exist on GitHub yet if `git push` failed with **repository not found**.

## Option A — Create in the browser (fastest)

1. Open **[github.com/new](https://github.com/new)** while logged in.
2. **Repository name:** `EAC-Training-Bundle` (must match the remote URL).
3. **Public**, **no** README / .gitignore / license (empty repo).
4. Click **Create repository**.
5. In Terminal:

```bash
cd /path/to/EAC-Training-Bundle
git push -u origin main
```

If `origin` is not set:

```bash
git remote add origin https://github.com/branson124/EAC-Training-Bundle.git
git push -u origin main
```

## Option B — Script + personal access token

1. Create a [fine-grained or classic PAT](https://github.com/settings/tokens) with **repo** scope.
2. In Terminal (replace `YOUR_TOKEN`):

```bash
export GITHUB_TOKEN=YOUR_TOKEN
export GITHUB_ORG=branson124
cd /path/to/EAC-Training-Bundle
./scripts/publish-to-github.sh
```

If the repo was already created, the script only runs `git push`.

## After the first push

Clone for others (includes CRM code):

```bash
git clone --recursive https://github.com/branson124/EAC-Training-Bundle.git
```
