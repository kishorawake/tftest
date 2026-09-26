# Git & GitHub BAU Guide

A practical, repeatable handbook for everyday Git and GitHub work — from beginner basics to production-ready habits.

---

## 1. Introduction

This guide covers:

- Git fundamentals
- Branching workflow
- Pull request process
- Merge conflict resolution
- GitHub navigation
- Troubleshooting
- Advanced Git techniques
- Production-ready team practices

> Use this as your day-to-day reference for BAU (Business-As-Usual) development work.

---

## 2. Starting Work in an Existing Repository

### Clone the repo

```bash
git clone <repo-url>
cd <repo-folder>
```

### Check your current branch

```bash
git branch
```

### Pull the latest changes

```bash
git checkout main
git pull origin main
```

---

## 3. Branching Workflow

### Create a feature branch

```bash
git checkout -b feature/my-task
```

### Make your change, stage it, and commit

```bash
git add .
git commit -m "Meaningful message"
```

### Push your branch to GitHub

```bash
git push origin feature/my-task
```

---

## 4. Raising a Pull Request (PR)

1. Open the GitHub repository.
2. Click on the Pull Requests tab.
3. Select New Pull Request.
4. Set:
   - Base branch: `main`
   - Compare branch: `feature/my-task`
5. Add a title and description.
6. Add reviewers.
7. Click Create Pull Request.

---

## 5. Reviewing a PR

Inside the PR, you can:

- review the Files changed section
- leave comments
- approve the request
- request changes
- check pipeline status
- merge after approval

---

## 6. Deleting Branches After Merge

### Delete the remote branch

```bash
git push origin --delete feature/my-task
```

### Delete the local branch

```bash
git branch -d feature/my-task
```

---

## 7. Merge Conflicts

Conflict markers look like this:

```git
<<<<<<< HEAD
your changes
=======
their changes
>>>>>>> main
```

### How to resolve

1. Open the conflicted file.
2. Decide which version is correct.
3. Remove the conflict markers.
4. Save the file.
5. Stage it:

```bash
git add <file>
```

6. Continue the merge:

```bash
git commit
```

---

## 8. GitHub UI Navigation

### Where to find PRs

- Repository → Pull Requests tab
- Filter by author, status, branch, or label

### Where to add collaborators

- Repository → Settings → Collaborators & teams

### Where to check pipeline status

- Open the PR
- Go to Checks section

---

## 9. Troubleshooting Common Git Issues

### Issue 1: “src refspec main does not match any”

This usually happens when your branch is named `master`, not `main`.

#### Fix

```bash
git push origin master
```

Or rename the branch:

```bash
git branch -m master main
git push origin main
```

---

### Issue 2: Large file rejected by GitHub

Example error:

```text
File ...terraform-provider-azurerm_v4.81.0_x5.exe is 223 MB; exceeds GitHub limit
```

#### Fix

- Delete the large file
- Add it to `.gitignore`
- Rewrite the repository history
- Force-push the cleaned branch

```bash
git filter-branch --force --tree-filter "rm -f .terraform/providers/.../terraform-provider-azurerm_v4.81.0_x5.exe" --prune-empty --tag-name-filter cat -- --all
git push origin master --force
```

Add `.gitignore` entries:

```gitignore
.terraform/
*.tfstate
*.exe
*.zip
```

---

### Issue 3: “adding embedded git repository: devsecops”

This usually means a subfolder contains its own `.git` directory.

#### Fix

```bash
git rm --cached devsecops
git commit -m "Remove nested repo"
```

---

### Issue 4: Remote branch cannot be deleted

Error:

```text
remote ref does not exist
```

#### Fix

```bash
git remote prune origin
git fetch --prune
```

---

## 10. Rebase Explained Simply

### What does rebase mean?

Think of Git like a notebook:

- `main` = the official notebook
- your branch = your working notebook

When `main` gets new updates, rebase means:

> “Replay my work on top of the latest main changes.”

### Example

Main branch:

```python
print("New logging format")
```

Your branch:

```python
print("Logging enabled")
```

Run:

```bash
git pull origin main --rebase
```

If Git shows a conflict, fix it and continue:

```bash
git add app.py
git rebase --continue
```

---

## 11. `git rebase --continue`

When a rebase pauses due to a conflict, Git is waiting for you to resolve it.

After fixing the conflict:

```bash
git rebase --continue
```

This means:

> “I resolved the conflict and am continuing to replay the remaining commits.”

---

## 12. Cherry-Pick

Use cherry-pick when you want to move one specific commit from one branch to another.

### Example

You accidentally committed on `main`:

```python
print("Fix: added validation")
```

Move it to your feature branch:

```bash
git checkout feature/payment-validation
git cherry-pick <hash>
```

Then remove it from `main`:

```bash
git checkout main
git reset --hard HEAD~1
```

---

## 13. Stash

Use stash when you need to temporarily save your work and switch branches.

### Example

You edited `login.html`, but need to fix a production bug elsewhere:

```bash
git stash
git checkout hotfix/prod-issue
```

Return later:

```bash
git checkout feature/login-ui
git stash pop
```

---

## 14. Production Pattern: Two Developers Edit the Same Line

### Scenario

Developer B merges first.

`main` now contains:

```python
print("New logging format")
```

Developer A rebases before opening the PR:

```bash
git checkout feature/add-logging
git pull origin main --rebase
```

Then they fix the conflict, test locally, and continue.

### Why teams prefer this

- cleaner history
- earlier conflict detection
- local validation
- cleaner PRs
- more stable CI/CD

---

## 15. Final Production Rules

### Always do this

- Rebase your feature branch before PR
- Resolve conflicts locally
- Push clean commits
- Raise a PR
- Merge after review
- Delete the branch after merge

### Avoid this

- Do not rebase shared branches like `main`, `develop`, or `release`
- Do not rebase after the PR is already raised
- Do not rebase someone else’s branch

---

## 16. Cheat Sheet

```bash
# Rebase latest main into your branch
git pull origin main --rebase

# Interactive rebase
git rebase -i HEAD~N

# Cherry-pick a commit
git cherry-pick <hash>

# Stash changes
git stash
git stash pop

# Undo last commit but keep changes
git reset --soft HEAD~1

# Undo last commit and discard changes
git reset --hard HEAD~1

# Revert a pushed commit
git revert <hash>

# Recover deleted branch
git reflog
git checkout -b <branch> <hash>
```

---

## ✅ Summary

The safest and most professional Git workflow is:

1. pull latest `main`
2. create a feature branch
3. commit cleanly
4. rebase before PR
5. resolve conflicts locally
6. raise a PR
7. merge and clean up

> Use this as your standard BAU process for reliable team collaboration.

---

### End of Document

Suggested filename: `git-github-bau-guide.md`
