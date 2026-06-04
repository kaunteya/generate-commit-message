# generate-commit-message

A shell script that uses Claude AI to generate a one-line imperative commit message from your staged git diff, then lets you commit with it in one keystroke.

## How it works

1. Reads the staged diff (`git diff --cached`)
2. Sends it inline to `claude-haiku-4-5` — a single, non-agentic call with no tool use, so it's fast
3. Prints the generated message in green
4. Asks whether to run `git commit` with it (Enter defaults to yes)

## Requirements

- [Claude Code CLI](https://claude.ai/code) (`claude` on your PATH)
- git

## Installation

```sh
git clone https://github.com/kaunteya/gitmsg
cd gitmsg
./install.sh
```

The script installs to `/usr/local/bin/generate-commit-message` if writable, otherwise to `~/.local/bin/generate-commit-message`.

If `~/.local/bin` is not on your PATH, add this to `~/.zshrc`:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

Stage your changes, then run:

```sh
git add <files>
generate-commit-message
```

Example session:

```
$ git add src/parser.swift
$ generate-commit-message
Add recursive descent parser for expression nodes
Commit with this message? [Y/n]
[main a3f91bc] Add recursive descent parser for expression nodes
```

Pressing Enter (or `y`) commits. Any other input aborts without committing.

## Notes

- Lockfiles (`*.lock`, `package-lock.json`, `yarn.lock`) are excluded from the diff to keep the prompt focused and tokens low.
- The script errors immediately if there are no staged files or if it's run outside a git repository.
