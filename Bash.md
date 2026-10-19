
## Find any file part, if you know a little about the name
find src -type f -name "*.ts"


|Command  |What it shows
|---------|----------------
|find src |Everything (files + directories)
|find src |-type f,Only files (most common)
|find src |-type d,Only directories
|ls -R src|Recursive listing (less clean)
|find src |-type f -name "*.ts",Only TypeScript files


Here’s a practical cheat-sheet of the most useful Bash (Git Bash) commands:

### Navigation
| Command | Explanation | Example |
|---------|-------------|---------|
| `pwd` | Print current directory | `pwd` |
| `cd dir` | Change directory | `cd src` |
| `cd ..` | Go up one level | `cd ..` |
| `cd ~` | Go to home directory | `cd ~` |
| `cd -` | Go to previous directory | `cd -` |

### Listing
| Command | Explanation | Example |
|---------|-------------|---------|
| `ls` | List files | `ls` |
| `ls -la` | List all files with details | `ls -la` |
| `ls -R` | List recursively | `ls -R src` |
| `find . -type f` | Find all files recursively | `find src -type f` |
| `find . -name "*.ts"` | Find files by name | `find . -name "*.ts"` |
| `tree` | Show directory tree (if installed) | `tree src` |

### File & Directory Operations
| Command | Explanation | Example |
|---------|-------------|---------|
| `mkdir dir` | Create directory | `mkdir src/utils` |
| `mkdir -p a/b/c` | Create nested directories | `mkdir -p src/a/b` |
| `touch file` | Create empty file | `touch index.ts` |
| `cp src dest` | Copy file | `cp a.ts b.ts` |
| `cp -r src dest` | Copy directory recursively | `cp -r src backup` |
| `mv src dest` | Move or rename | `mv old.ts new.ts` |
| `rm file` | Delete file | `rm temp.ts` |
| `rm -r dir` | Delete directory recursively | `rm -r dist` |
| `rm -rf dir` | Force delete (no confirmation) | `rm -rf node_modules` |

### Viewing Files
| Command | Explanation | Example |
|---------|-------------|---------|
| `cat file` | Print entire file | `cat package.json` |
| `less file` | View file page by page | `less README.md` |
| `head -n 20 file` | Show first 20 lines | `head -n 20 app.ts` |
| `tail -n 20 file` | Show last 20 lines | `tail -n 20 log.txt` |
| `tail -f file` | Follow file in real time | `tail -f app.log` |

### Searching
| Command | Explanation | Example |
|---------|-------------|---------|
| `grep "text" file` | Search text in file | `grep "export" index.ts` |
| `grep -r "text" dir` | Search recursively | `grep -r "TODO" src` |
| `grep -i "text"` | Case-insensitive search | `grep -i "error" log.txt` |
| `grep -n "text"` | Show line numbers | `grep -n "function" app.ts` |

### Permissions
| Command | Explanation | Example |
|---------|-------------|---------|
| `chmod +x file` | Make file executable | `chmod +x script.sh` |
| `chmod 755 file` | Set read/write/execute permissions | `chmod 755 deploy.sh` |
| `chown user file` | Change file owner | `chown admin file.txt` |

### Process & System
| Command | Explanation | Example |
|---------|-------------|---------|
| `ps aux` | List running processes | `ps aux` |
| `kill PID` | Kill process by ID | `kill 1234` |
| `killall name` | Kill process by name | `killall node` |
| `top` / `htop` | Live process monitor | `top` |
| `df -h` | Show disk space | `df -h` |
| `du -sh *` | Show folder sizes | `du -sh *` |
| `free -h` | Show memory usage | `free -h` |
| `uname -a` | Show system info | `uname -a` |
| `whoami` | Show current user | `whoami` |
| `date` | Show current date/time | `date` |

### Text Processing
| Command | Explanation | Example |
|---------|-------------|---------|
| `echo "text"` | Print text | `echo "Hello"` |
| `wc -l file` | Count lines | `wc -l app.ts` |
| `sort file` | Sort lines | `sort names.txt` |
| `uniq file` | Remove duplicate lines | `uniq sorted.txt` |
| `cut -d',' -f1 file` | Extract columns | `cut -d',' -f1 data.csv` |
| `sed 's/old/new/g' file` | Find and replace | `sed 's/foo/bar/g' file.txt` |
| `awk '{print $1}' file` | Process columns | `awk '{print $1}' data.txt` |

### Compression
| Command | Explanation | Example |
|---------|-------------|---------|
| `tar -czf archive.tar.gz dir` | Create compressed archive | `tar -czf src.tar.gz src` |
| `tar -xzf archive.tar.gz` | Extract archive | `tar -xzf src.tar.gz` |
| `zip -r archive.zip dir` | Create zip | `zip -r src.zip src` |
| `unzip archive.zip` | Extract zip | `unzip src.zip` |

### Networking
| Command | Explanation | Example |
|---------|-------------|---------|
| `curl url` | Fetch URL content | `curl https://api.github.com` |
| `curl -O url` | Download file | `curl -O https://example.com/file.zip` |
| `wget url` | Download file | `wget https://example.com/file.zip` |
| `ping host` | Test connectivity | `ping google.com` |
| `ssh user@host` | Connect via SSH | `ssh admin@192.168.1.10` |

### History & Shortcuts
| Command | Explanation | Example |
|---------|-------------|---------|
| `history` | Show command history | `history` |
| `!!` | Re-run last command | `!!` |
| `!n` | Re-run command number n | `!42` |
| `Ctrl + R` | Search command history | (press Ctrl+R then type) |
| `Ctrl + L` | Clear screen | (press Ctrl+L) |
| `Ctrl + C` | Cancel current command | (press Ctrl+C) |
| `clear` | Clear terminal | `clear` |

### Useful Combinations
| Command | Explanation | Example |
|---------|-------------|---------|
| `ls \| grep ".ts"` | Pipe output to filter | `ls \| grep ".ts"` |
| `cat file \| wc -l` | Count lines via pipe | `cat app.ts \| wc -l` |
| `cmd1 && cmd2` | Run cmd2 only if cmd1 succeeds | `npm test && npm run build` |
| `cmd1 \|\| cmd2` | Run cmd2 only if cmd1 fails | `npm start \|\| echo "Failed"` |
| `cmd > file` | Redirect output to file | `ls > files.txt` |
| `cmd >> file` | Append output to file | `echo "log" >> app.log` |
| `cmd 2> file` | Redirect errors to file | `npm run build 2> errors.log` |

### Quick Tips for Git Bash
- Use `Tab` for auto-completion.
- Use `↑` / `↓` to cycle through previous commands.
- `man command` shows the manual (e.g. `man find`).
- Most commands accept `--help` (e.g. `find --help`).




node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"


mkdir -p src/modules/ai-chat/{domain/{entities,interfaces,value-objects},application/{use-cases,dto},infrastructure/{providers,factories},presentation/{controllers,routes}}


git commit --amend -m "Your new commit message"


git push --force



gh auth login


gh repo create meetai --private --description "AI chat assistant built with Next.js" --source=. --push


 git log --online --graph --decorate --all


gh repo create __ --private --source=. --push


gh pr create --base master --head frontend-auth-ui --title "feat(auth): implement frontend authentication UI and functionality" --body "This PR implements the frontend auth UI with full functionality, including login, register, and error handling."


rmdir /s /q "path\to\your\folder"

del /f /q *.exe *.msi *.zip

DELETE ALL DIRECTORY IN THE ROOT


for /d %i in (*) do echo rmdir /s /q "%i"


for /d %i in (*) do rmdir /s /q "%i"