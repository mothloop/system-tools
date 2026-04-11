# system-tools

Minimal system maintenance utilities for Ubuntu.

This repository provides small, focused command-line tools for maintaining a clean and up-to-date system. The scripts are designed to be silent, predictable, and easy to install, with consistent behavior across environments.

## Overview

The repository defines two primary commands:

- `update` - performs a full system update
- `clean` - removes unnecessary files and packages

Both commands suppress all underlying command output and present only controlled status messages. This keeps terminal output minimal and readable while still performing complete maintenance operations.

## Design Principles

- Minimal output
- Deterministic behavior
- No external dependencies beyond standard Ubuntu tools
- Easy installation and portability
- Suitable for personal system tooling and dotfile ecosystems

## Commands

### `update`

Performs a full system update using both APT and Snap.

Includes:
- Updating package lists
- Upgrading installed packages
- Handling dependency changes
- Refreshing Snap packages

### `clean`

Performs system cleanup across APT and Snap.

Includes:
- Removing unused packages
- Clearing package caches
- Removing outdated package lists
- Removing disabled Snap revisions

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/mothloop/system-tools.git
cd system-tools
chmod +x install.sh bin/update bin/clean
./install.sh
````

The installer creates symlinks in `~/.local/bin`, making the commands available globally for the current user.

## Requirements

* Ubuntu or Debian-based system
* `apt`
* `snap`
* `bash`
* `sudo` privileges

## Path Configuration

The installer ensures that `~/.local/bin` is included in your `PATH`. If commands are not recognized, reload your shell:

```bash
source ~/.bashrc
```

or restart your terminal.

## Repository Structure

```
system-tools/
├── bin/
│   ├── update
│   └── clean
├── install.sh
└── README.md
```

## Usage

Once installed, the commands can be run from anywhere:

```bash
update
clean
```

## Safety Notes

* All operations that modify the system require `sudo`
* The scripts suppress command output, so failures will terminate execution without detailed logs
* Review scripts before use if modifying for your own environment

## License

This project is licensed under the MIT License.
