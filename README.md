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

#### With parameters 

List all commits for specific date range with date parameter(s) in format `YYYY-MM-DD`

##### One parameter 

Fom given date to current day
```shell
./daily-git-commits.sh 2022-03-01
```

##### Two parameters

Range between the given dates

```shell
./daily-git-commits.sh 2022-03-01 2022-03-06
```


# TODO

- [ ] Get rid of `short` alias requirement
- [ ] Run without parameter to return current day's work
- [ ] Add rainbow colors (for fun)

# Credit

🙌 High five @tomimikola for the original idea/script. 