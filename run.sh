#!/bin/sh

#installing git
apt-get update
apt-get install -y git-core

#repo
repo="$WERCKER_GITHUB_PUSH_REPO"

info "using github repo \"$repo\""

# remote path
remote="https://$WERCKER_GITHUB_PUSH_TOKEN@github.com/$repo.git"
# base directory
cd "$WERCKER_GITHUB_PUSH_BASEDIR"
# remove existing commit history
rm -rf .git
#select branch
branch="$WERCKER_GITHUB_PUSH_BRANCH"
# init repository
git init
git config user.email "$WERCKER_GITHUB_PUSH_EMAIL"
git config user.name "$WERCKER_GITHUB_PUSH_UNAME"
git add --all
git commit -m "deploy from $WERCKER_STARTED_BY"
result="$(git push -f $remote master:$branch)"

if [[ $? -ne 0 ]]
then
warning "$result"
fail "failed pushing to github"
else
success "pushed to github"
fi
