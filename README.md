# daily-commits 📅✨

🕵️‍♂️ A delightfully fancy command-line tool that stalks your git commits across
all your projects and presents them in a beautiful report. Perfect when you need
to remember what you actually accomplished on a given day (or pretend you were productive).

## ⚡ Quick Install

```bash
git clone https://github.com/kirkkala/daily-git-commits.git
cd daily-git-commits
./install.sh
```

The installer will ask you a few friendly questions (like where your projects live) and you are done! 🚀

## 🚀 Usage

```bash
# Today's masterpieces
daily-commits

# Yesterday's forgotten brilliance
daily-commits yd

# Last 7 days (the "what did I even do?" command)
daily-commits w

# Last 3 days
daily-commits 3d

# Specific date (when your boss asks "what were you working on?")
daily-commits 2025-11-19

# Date range (for the overachievers)
daily-commits 2025-11-01 2025-11-15
```

## 🎯 Features

- 🚀 **Fast** - Searches through all your projects in seconds
- 🎨 **Beautiful** - Colorful output that makes `git log` jealous
- 🧠 **Smart** - Automatically finds all git repos in your projects folder
- 😄 **Fun** - Includes witty messages when you... "took a break from coding"
- 💾 **Clean** - No mess in your repo, config lives in `~/.config/`
- 🎪 **Professional** - Clean install/uninstall, like a real grown-up CLI tool

## 🔧 Advanced

Need to change your config? Just re-run installer!
```bash
./install.sh
```

## 🗑️ Uninstall

```bash
cd /path/to/daily-git-commits
./uninstall.sh
```

It'll even ask if you want to keep your config. So considerate! 🥺

## 📋 Requirements

- macOS or Linux (Windows users: WSL is your friend)
- Bash shell (you have it, trust me)
- Git (if you don't have this, we need to talk)

## 🤝 Credit

🙌 Original idea/script by [@tomimikola](https://github.com/tomimikola) - legend!

## 📄 License

See [LICENSE](LICENSE) file for the legal stuff.

---

Made with ❤️ (and 🤖) for developers who can't remember what they did yesterday

*P.S. - If you try to look up commits from the future, you'll get a Back to the Future reference.  You're welcome.* 🚗⚡
