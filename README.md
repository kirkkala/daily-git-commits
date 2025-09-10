# daily-git-commits

Shell script for listing git commits for current date or given
date range.

## Usage

### Requirements

A git alias `short`, add to local `~/.gitconfig`
```txt
[alias]
  short  = log --decorate --pretty=format:\"%ai | %s%d [%an]\" --abbrev-commit --all
```

### Edit variables

Edit the `author` and `local_projects_directory_root` variables in the beginning of script to match your directory structure


### Running the script

#### Without parameters

List all commits for current day:

```shell
./daily-git-commits.sh
```

##### One specific day

Fom given date `YYYY-MM-DD` to current day

```shell
./daily-git-commits.sh 2025-09-21
```

##### Specific date range

Range between the given dates

```shell
./daily-git-commits.sh 2025-08-30 2025-09-06
```

# Credit

🙌 High five for [@tomimikola](https://github.com/tomimikola) for the original idea/script.
