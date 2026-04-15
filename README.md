# system-tools

Minimal system maintenance utilities for Ubuntu.

This repository provides small, focused command-line tools for maintaining a clean and up-to-date system. The scripts are designed to be silent, predictable, and easy to install, with consistent behavior across environments.

## Overview

The repository defines four primary commands:

- `update` - performs a full system update
- `clean` - removes unnecessary files and packages
- `up` - checks for available system updates
- `audit` - analyzes system storage and reports cleanliness score

All commands suppress all underlying command output and present only controlled status messages. This keeps terminal output minimal and readable while still performing complete maintenance operations.

## Design Principles

- Minimal output
- Deterministic behavior
- No external dependencies beyond standard Ubuntu tools
- Easy installation and portability
- Suitable for personal system tooling and dotfile ecosystems
- Firmware updates are intentionally interactive and may require reboot

## Commands

### `update`

Performs a full system update using APT, Snap, and firmware (if available).

Includes:
- Updating package lists
- Upgrading installed packages
- Handling dependency changes
- Refreshing Snap packages
- Checking and applying firmware updates (interactive confirmation required)
- Notifying if reboot is needed after firmware updates

### `clean`

Performs system cleanup across APT and Snap.

Includes:
- Removing unused packages
- Clearing package caches
- Removing outdated package lists
- Removing disabled Snap revisions

### `up`

Performs a check for available updates using APT, Snap, and firmware (if available).

Includes:
- Checking package lists for updates
- Counting upgradable APT packages
- Counting refreshable Snap packages
- Checking for available firmware updates

### `audit`

Analyzes system storage and generates a comprehensive cleanliness report.

Includes:
- Disk usage across partitions
- Identification of large files (500MB+)
- Cache and temporary directory sizes
- Package inventory (APT and Snap)
- Firmware status (if tool available)
- System health metrics (uptime, memory usage, pending updates)
- Cleanliness score (0-100) with health status

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/mothloop/system-tools.git
cd system-tools
chmod +x install.sh bin/update bin/clean bin/up
./install.sh
````

The installer creates symlinks in `~/.local/bin`, making the commands available globally for the current user.

```bash
chmod +x bin/audit
```

## Requirements

* Ubuntu or Debian-based system
* `apt`
* `snap`
* `bash`
* `sudo` privileges
* `fwupdmgr` (optional, for firmware updates)

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
│   ├── clean
│   ├── up
│   └── audit
├── install.sh
└── README.md
```

## Usage

Once installed, the commands can be run from anywhere:

```bash
update
clean
up
```

## Safety Notes

* All operations that modify the system require `sudo`
* The scripts suppress command output, so failures will terminate execution without detailed logs
* Review scripts before use if modifying for your own environment

## License

This project is licensed under the MIT License.
