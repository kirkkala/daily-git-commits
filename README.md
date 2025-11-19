# daily-git-commits 📅✨

🕵️‍♂️ A delightfully fancy shell script that stalks your git commits and presents
them in a beautiful report. Perfect when you need to remember what you actually
accomplished on a given day (or pretend you were productive).

## Documentation

### Requirements

- Bash shell
- Git (obviously! 😄)
- Having your name attached to git commits
  ```shell
  # Set your git author globally if not already done
  git config --global user.name "Your Name"
  ```

### Setup 

Create `.env` file and edit variables to match your local.

```shell
cp env.example .env
```

### Usage

#### Commits of today

```shell
./daily-git-commits.sh
```

#### Shorthand parameters (for the lazy typist 😎)

```shell
./daily-git-commits.sh yd     # or "yesterday" - commits from yesterday
./daily-git-commits.sh 3d     # or "3days" or "3day" - commits from last 3 days
./daily-git-commits.sh 10d    # any number! - commits from last 10 days
./daily-git-commits.sh w      # or "week" - commits from past 7 days
```

#### Commits from a specific day

From a specific date `YYYY-MM-DD`

```shell
./daily-git-commits.sh 2025-09-21
```

#### Commits from specific date range

Date range `YYYY-MM-DD YYYY-MM-DD`

```shell
./daily-git-commits.sh 2025-08-30 2025-09-06
```

# Credit

🙌 High five for [@tomimikola](https://github.com/tomimikola) for the original idea/script.
