Git tools:

# Install-Module posh-git

git config alias.st status        
git config alias.st # retruns the value of the alias
# git st
cat .git/config | grep -A 1 "\[alias\]"     
# it's stored in a file ^

#does the same but stores it locally ~/.gitconfig file
git config -- global alias.st "status --short --branch" # makes it simpler
alias.cma "commit --all -m" # commit all messages

# quick merge
git config --global alias.qm '!git checkout $1; git merge @{-1}'
 # ! is a cmd
 # $1 argument
 # merge with the previous branch we visited
 
#  more ideas:
# git co [param]

## HISTORY
# git log --pretty=oneline
# git log --pretty='%h | %d %s (%cr) [%an]'
# h - hash, d - commit, s - commit-subject, cr - how-long-ago-created,an - author
# '%C(cyan)[%h]%Creset --graph --all'  # adds graphical representation and color around the [%h]
# do the same thing for git show object "alias.so"

## DIFF
#git config --global core.pager 'less -RFX' # how to invoke pager R - rawOutput for color control, FX- force exit if fits in one page
# less -s # wraps long lines

git config --global alias.do 'diff --word-diff --unified=10'
git config --global diff.algorithm histogram

git show head~2 # shows ddetails of the last 2 commits
# git so head --stat

## displays during commit
# git diff --staged # what's to be added to the commit # same as --cached

#emphasis on whitespaces that aren't ok (also, yells at tabs)
git config --global core.whitespace "blank-at-eol,blank-at-eof,tab-in-indent"
##indent-with-non-tab for yelling at spaces
#similar to git dif --check # w2hich complains about whitespaces

#git diff HEAD~2..HEAD # if yelled at for commits with whitespace
#can fix with
#git rebase HAED~2 --whitespace=fix # it will fix according to the core whitespace setting

# git stash save --keep-index --include-untracked "WIP" # 'work in progress'
#only runs the code that's to be commited


# merges twodot notation
# git log feature..master # displays only the commits that are UNREACHABLE by *feature*
# merges threeDot notation # commits that are reachable exlusively by one of the commits but not by both
# git log --ancestry-path feature..master # the commits between the two commits
# git show-branch # simple representation
# git branch --merged [commit]
# we can see the commits in branches that haven't been merged to the master with
# git show-branch --topic master B C D E F # these commits that aren't merged will be shows with color

# git log --cherry-mark --left-right --no-merges master...experiment
# this displays all exclusive commits that haven't been merged into the master.
# all commits on the left (master) are shown with "<" and all on the right (experiment)
# are shown with ">"
# commits that are Prime (patch equivalent), are marked with "="
## --right-only, left-only # to display only commits on the right or left

# git log --cherry-pick --right-only --no-merges master...experiment
# is === to git log --cherry

# git log --follow --stash filename.c  # "follow" shows a list of commits deviated from the head
# and "stash" includes all changes.

# git log -Sblablabla # only displays diffs to a string diffed with the name blablabla
# git log -S".*is.*" --pickaxe-regex  # looks for regex
## -S only displays Added or Removed lines...
## -G finds Modified lines`

## PARSE LANGUAGE
# git log -L:functionName:FileName.c
#can add to .gitattributes languages to parse, apart for c/c++
#add to the file:
# *.java	diff=java

# git log --author="Yoni" --since="1 week" --until="2 days ago"
# there's an Author and a Commiter(patcher/Devops..)

#git blame master..feature filename.c
#git blame filename.c -L14,16  # by lines
# git blame filename.c -L:funcName   # by func

# git shortlog -s -n | head -10
# shows the top 10 commiters in the repository

# git cherry-pick commitNameOrID
# this adds to the HEAD a new commit which is patch equivalent (Prime) to the commit we cherry picked
# it'll have different commit ID
# git cherry-pick excluded..included # picks more than one commit
# git config --global alias.append '!git cherry-pick (git merge-base HEAD $1)..$1'
# gets the commits from the base of theyr ancestor until the $1 commit

# git commit --amend -C   #uses message from HEAD
# git commit --hard HEAD~2 # DESTRUCTIVE! removes all commits & unstaged until HEAD~2
# git commit --soft HEAD~2 # moves the HEAD to ~2 but keeps the index staged (we can use amend now..)
# git commit --mixed HEAD~2 # moves the HEAD to ~2 & takes off from index staged (things are unstaged now, but not deleted)

# CAREFUL...
# git config --global alais.undo '!f() { git reset --hard $(git rev-parse --abbrev-ref HEAD)@{1-1}}; }; f'
## 

# git fsck --unreachable | wc -l
# git fsck --unreachable --no-reflogs | wc -l 
## the number of reachable and not reachable commits respectively (the no-reflogs commits includes also the the unreachable)
## they are collected by the GC (default: reacheable 90 days, unreachable 30 days)

# git log --grep=StringNameRefference. --walk-reflogs  # greps through messages with string name
# displays the HEAD@{number} & commit info

# A-B-C-D
## flow to recover C if it was removed
# A-B-D

# git checkout -b HEAD~1
# git cherry-pick HEAD@{approriateNumber} # cherry pick "C" after grepping it (see above)
# git cherry-pick branchName
# git branch -f branchName HEAD  # forces git to accept w/o commit


# DEBUGGING
# git bisect start
# git bisect bad HEAD
# git bisect good HEAD~4
# action
# git bisect good ## give your response if it's good or bad

# git bisect start HEAD HEAD~4 
# git bisect run ACTION_NAME

# bisect is a binary-search of the commits to find the failing test while doing a dissection

