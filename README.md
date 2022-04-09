# 5200_final_proj

## git workflow

- Guideline for code collaboration. Our team use the Git Feature Branch workflow. The following is a walk-through of the life-cycle of a feature branch.

#### On local main branch

- keep the local main branch up to date with the remote main branch
```
git pull
```

- create a new feature branch and switch to the new branch
```
git checkout -b new-branch-name
```

#### On local feature branch

- push your changes on the local feature branch to the remote one
```
git push -u origin new-branch-name
```

#### After merging your changes into remote main branch
- Delete the feature branch from the repository
- Remove the local feature branch and its remote-tracking references
```
git branch -d featurebranchname
git fetch --all --prune
```
