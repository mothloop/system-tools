# system-tools

Minimal system maintenance utilities for Ubuntu.

This repository provides small, focused command-line tools for maintaining a clean and up-to-date system. The scripts are designed to be silent, predictable, and easy to install, with consistent behavior across environments.

## Overview

The repository defines seven primary commands:

- `update` - performs a full system update
- `clean` - removes unnecessary files and packages
- `up` - checks for available system updates
- `audit` - analyzes system storage and reports cleanliness score
- `full` - performs a full system update followed by cleanup
- `install` - updates the system-tools repository and reinstalls all commands
- `monitor` - provides real-time system monitoring

All commands suppress all underlying command output and present only controlled status messages. This keeps terminal output minimal and readable while still performing complete maintenance operations.

This repository is developed on Ubuntu 24.04 and will work best on that version of Ubuntu.

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

### `full`

Performs a full system update followed by cleanup.

Includes:
- Running the `update` command to update all packages and firmware
- Running the `clean` command to remove unnecessary files and packages

### `install`

Updates the system-tools repository and reinstalls all commands.

Includes:
- Pulling the latest changes from the repository
- Reinstalling all commands to ensure they are up to date

### `monitor`

Provides real-time system monitoring with live updates.

Includes:
- CPU usage percentage
- Memory usage (used/total and percentage)
- Network I/O rates (receive/transmit)
- Disk I/O rates (read/write)
- Updates every 2 seconds
- Clean display that refreshes in place
- Graceful exit on Ctrl+C

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/mothloop/system-tools.git
cd system-tools
chmod +x install.sh bin/*
./install.sh
```

The installer creates executables in `~/.local/bin`, making the commands available globally for the current user. It also adds `~/.local/bin` to your `PATH` if not already present.

## Updates

To update the system-tools and ensure all commands are current, run:

```bash
install
```

This command can be run from anywhere and will automatically pull the latest changes and reinstall all tools.

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
│   ├── audit
│   ├── full
│   ├── install
│   └── monitor
├── install.sh
└── README.md
```

## Usage

Once installed, the commands can be run from anywhere:

```bash
update
clean
up
audit
full
install
monitor
```

## Safety Notes

* All operations that modify the system require `sudo`
* The scripts suppress command output, so failures will terminate execution without detailed logs
* Review scripts before use if modifying for your own environment

## License

This project is licensed under the MIT License.
