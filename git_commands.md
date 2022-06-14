#task1.3
mkdir Task1
vim Task1/README.md
git add README.md
git add Task1/
git commit -m 'readme.md'
git push
#task1.4
git checkout -b dev
vim testfile.txt
git push origin dev
git add testfile.txt
git commit -m 'testfile'
#task1.5
git checkout -b vodoroshenko-new_feature
#task1.6
vim README.md
git add README.md
git commit -m 'new README.md'
git push origin vodoroshenko-new_feature
#task1.7
git status
#task1.8
vim .gitignore
#task1.9
git add -f .gitignore
git commit -m '.gitignore'
git push origin vodoroshenko-new_feature
#task1.10
git push --set-upstream origin dev
#task1.11
git merge vodoroshenko-new_feature
git checkout dev
git push --set-upstream origin master
git merge dev
#task1.12
git checkout vodoroshenko-new_feature
vim README.md
git add README.md
git commit -m 'item12'
git push
git revert HEAD
#task1.13
git checkout master
git log > log.txt
#task1.14
git branch -D vodoroshenko-new_feature
git push origin --delete vodoroshenko-new_feature
