#!/bin/bash
if [ ! -e venv ]; then
    ./install.sh
fi

if [ -e site ]; then
    rm -rf site
fi

ls -las
ls -las modules

if [ $1 != "" ]; then
git config user.email "noreply@compgen.io"
git config user.name "Deployment/$GITHUB_ACTOR"
fi
git submodule update --remote
git commit -am 'submodule update'

venv/bin/mkdocs build
cd site
cp -r ../modules/* .
rm -rf */.git
echo "docs.compgen.io" > CNAME
git init

if [ $1 != "" ]; then
git config user.email "noreply@compgen.io"
git config user.name "Deployment/$GITHUB_ACTOR"
fi
git add .
git commit -m 'deploy'
if [ $1 != "" ]; then
    git remote add origin https://deploy:$1@github.com/compgen-io/compgen-io-docs.git
else
    git remote add origin git@github.com/compgen-io/compgen-io-docs.git
fi
git checkout -b gh-pages
git push --force origin gh-pages

ls -las

cd ..
rm -rf site

