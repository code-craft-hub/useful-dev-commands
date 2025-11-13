# Comprehensive Git & GitHub Commands Guide

Initial Setup

### Configure user information

git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Check configuration

git config --list
git config user.name
Repository Initialization & Cloning

### Initialize a new repository

git init

# Clone an existing repository

git clone <repository-url>
git clone <repository-url> <directory-name>

# Clone with specific branch

git clone -b <branch-name> <repository-url>
Basic Workflow Commands

### Check repository status

git status
git status -s # Short format

# Add files to staging area

git add <file-name>
git add . # Add all files
git add \*.js # Add all JS files
git add -A # Add all changes (new, modified, deleted)
git add -p # Interactive staging

# Commit changes

git commit -m "Commit message"
git commit -am "Message" # Add and commit tracked files
git commit --amend # Modify last commit
git commit --amend --no-edit # Amend without changing message
Branch Management

### List branches

git branch # Local branches
git branch -r # Remote branches
git branch -a # All branches

# Create new branch

git branch <branch-name>
git checkout -b <branch-name> # Create and switch
git switch -c <branch-name> # Modern alternative

# Switch branches

git checkout <branch-name>
git switch <branch-name> # Modern alternative

# Rename branch

git branch -m <old-name> <new-name>
git branch -m <new-name> # Rename current branch

# Delete branch

git branch -d <branch-name> # Safe delete
git branch -D <branch-name> # Force delete
git push origin --delete <branch-name> # Delete remote branch
Remote Repository Operations

### View remotes

git remote -v
git remote show origin

# Add remote

git remote add origin <repository-url>

# Change remote URL

git remote set-url origin <new-url>

# Remove remote

git remote remove <remote-name>

# Fetch changes

git fetch # Fetch all remotes
git fetch origin # Fetch specific remote
git fetch --all # Fetch all remotes

# Pull changes

git pull # Fetch and merge
git pull origin <branch-name>
git pull --rebase # Fetch and rebase

# Push changes

git push
git push origin <branch-name>
git push -u origin <branch-name> # Set upstream
git push --all # Push all branches
git push --tags # Push all tags
git push --force # Force push (use carefully!)
git push --force-with-lease # Safer force push
Viewing History & Changes

### View commit history

git log
git log --oneline # Compact view
git log --graph # Graph view
git log --all --graph --oneline
git log -n 5 # Last 5 commits
git log --author="Name" # Filter by author
git log --since="2 weeks ago"
git log --until="2024-01-01"

# View specific file history

git log <file-name>
git log -p <file-name> # With changes

# Show commit details

git show <commit-hash>
git show HEAD # Latest commit

# View changes

git diff # Unstaged changes
git diff --staged # Staged changes
git diff <branch1> <branch2> # Between branches
git diff <commit1> <commit2>
Undoing Changes

### Discard unstaged changes

git checkout -- <file-name>
git restore <file-name> # Modern alternative

# Unstage files

git reset HEAD <file-name>
git restore --staged <file-name> # Modern alternative

# Reset commits

git reset --soft HEAD~1 # Keep changes staged
git reset --mixed HEAD~1 # Keep changes unstaged (default)
git reset --hard HEAD~1 # Discard changes (dangerous!)

# Revert commit (creates new commit)

git revert <commit-hash>
git revert HEAD # Revert last commit

# Clean untracked files

git clean -n # Preview
git clean -f # Remove files
git clean -fd # Remove files and directories
Stashing

### Save changes temporarily

git stash
git stash save "Description"
git stash -u # Include untracked files

# List stashes

git stash list

# Apply stash

git stash apply # Apply most recent
git stash apply stash@{2} # Apply specific stash
git stash pop # Apply and remove

# Drop stash

git stash drop stash@{0}
git stash clear # Remove all stashes
Merging & Rebasing

### Merge branch

git merge <branch-name>
git merge --no-ff <branch-name> # No fast-forward
git merge --squash <branch-name> # Squash commits

# Rebase

git rebase <branch-name>
git rebase -i HEAD~3 # Interactive rebase (last 3 commits)
git rebase --continue # Continue after resolving conflicts
git rebase --abort # Cancel rebase

# Cherry-pick commits

git cherry-pick <commit-hash>
git cherry-pick <commit1> <commit2>
Tagging

### List tags

git tag
git tag -l "v1.\*" # Filter tags

# Create tag

git tag <tag-name> # Lightweight tag
git tag -a v1.0 -m "Version 1.0" # Annotated tag

# Tag specific commit

git tag <tag-name> <commit-hash>

# Push tags

git push origin <tag-name>
git push origin --tags # Push all tags

# Delete tag

git tag -d <tag-name> # Local
git push origin --delete <tag-name> # Remote
Advanced Operations

### Search in code

git grep "search-term"
git grep -n "search-term" # Show line numbers

# Find who changed a line

git blame <file-name>

# Binary search for bugs

git bisect start
git bisect bad # Current version is bad
git bisect good <commit> # Known good commit
git bisect reset # End bisect

# Submodules

git submodule add <repository-url>
git submodule init
git submodule update
git submodule update --remote

# Reflog (recover lost commits)

git reflog
git reset --hard <commit-hash>
GitHub-Specific Commands

### Using GitHub CLI (gh)

gh auth login
gh repo create
gh repo clone <repository>
gh pr create
gh pr list
gh pr checkout <pr-number>
gh issue create
gh issue list
Useful Aliases

### Add to ~/.gitconfig

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
Best Practices

### Pull before push

git pull origin main && git push origin main

# Check before committing

git status && git diff

# Use meaningful commit messages

# Format: type(scope): subject

# Example: feat(auth): add login functionality

# Keep commits atomic

# One logical change per commit

# Use branches for features

git checkout -b feature/new-feature
