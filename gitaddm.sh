git status | grep modified | awk '{system("git add \""$3"\"")}'
git status | grep "deleted:" | awk '{system("git rm \""$3"\"")}'
