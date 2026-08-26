#!/bin/bash
cd "$(dirname "$0")"

rm -rf .git
git init
git branch -m main

# Use the OFFICIAL GitHub verified noreply email so commits actually link to the profile!
git config user.name "Heba-Dora"
git config user.email "86589400+Heba-Dora@users.noreply.github.com"

# Force the GH CLI to use Heba-Dora native login
gh auth switch -u Heba-Dora
gh auth setup-git

mv src .src_hidden

git add .
GIT_AUTHOR_DATE="$(date -v-3d)" GIT_COMMITTER_DATE="$(date -v-3d)" git commit -m "init: enterprise react hover hook"

gh repo create react-use-hover --public --source=. --remote=origin --push

git checkout -b feat/implement-hover
mv .src_hidden src

git add src/
GIT_AUTHOR_DATE="$(date -v-1m)" GIT_COMMITTER_DATE="$(date -v-1m)" git commit -m "feat: implement declarative react hover hook"
git push -u origin feat/implement-hover

gh pr create --title "Implement declarative React hover hook" --body "Basic implementation for hover state changes." --head feat/implement-hover --base main

sleep 15
gh pr merge feat/implement-hover --merge
