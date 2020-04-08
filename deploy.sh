#!/bin/bash
if [ ! -e venv ]; then
    ./install.sh
fi

if [ -e site ]; then
    rm -rf site
fi

git submodule update --remote
git commit -am 'submodule update'

venv/bin/mkdocs build
cd site
cp -r ../modules/* .
rm -rf */.git
echo "docs.compgen.io" > CNAME
git init
git add .
git commit -m 'deploy'
git remote add origin https://github.com/compgen-io/compgen-io-docs.git
git checkout -b gh-pages
git push --force origin gh-pages
cd ..
#rm -rf site
