# generate-commit-message

A shell script that uses a local [Ollama](https://ollama.com) LLM to generate a one-line imperative commit message from your staged git diff, then lets you commit with it in one keystroke.

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
Commit? [Enter] yes / [n]o / [space] regenerate
[main a3f91bc] Add recursive descent parser for expression nodes
```

At the prompt (a single keypress):

- `Enter` — commit with the message
- `n` — abort without committing
- `space` — regenerate a fresh suggestion (uses a higher temperature for variety)

## How it works

1. Reads the staged diff (`git diff --cached`)
2. Starts the Ollama server if it isn't already running (no login daemon needed)
3. Pipes the diff to a local Ollama model (`qwen2.5-coder:7b` by default) — runs entirely on your machine, no network calls
4. Prints the generated message in green
5. Asks whether to run `git commit` with it (Enter defaults to yes)

## Requirements

- [Ollama](https://ollama.com) (`ollama` on your PATH) with the default model pulled: `ollama pull qwen2.5-coder:7b`
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

## Configuration

Use a different model by setting the `OLLAMA_MODEL` environment variable:

```sh
OLLAMA_MODEL=llama3.2 generate-commit-message
```

## Notes

- Lockfiles (`*.lock`, `package-lock.json`, `yarn.lock`) are excluded from the diff to keep the prompt focused and tokens low.
- The script errors immediately if there are no staged files, if it's run outside a git repository, or if `ollama` is not installed.
- The Ollama server is started on demand and left running; Ollama unloads idle models from memory on its own, so there's no need to run it as a login service.
