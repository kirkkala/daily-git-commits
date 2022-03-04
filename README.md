# daily-git-commits

A script for listing commits from local machine for given date range.

## Usage

1. Modify `author` and `local_projects_directory_root` variables to match your needs.

2. Run the script from command line with start/end date parameters (in format YYYY-MM-DD)

```shell
./daily-git-commits.sh 2022-03-02 2022-03-04
```

## Requirements

A git alias `short`, add to local `~/.gitconfig`
```txt
[alias]
  short  = log --decorate --pretty=format:\"%ai | %s%d [%an]\" --abbrev-commit --all
```

# TODO

- [ ] Get rid of `short` alias requirement
- [ ] Run without parameter to return current day's work
- [ ] Add rainbow colors (for fun)

# Credit

🙌 High five @tomimikola for the original idea/script. 