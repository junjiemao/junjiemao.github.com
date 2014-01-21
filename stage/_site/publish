#!/bin/bash
rm -fR  ../!\(".nojekyll"\|"stage"\)
cp -r ./_site/** ..
cd ../
git add .
git commit -m "publish blog"
git push origin master
