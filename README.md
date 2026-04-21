# system-tools

Minimal system maintenance utilities for Ubuntu.

Provides small, focused CLI tools for system maintenance. Scripts are silent, predictable, and easy to install.

## Commands

- `update`: Full system update (APT, Snap, firmware)
- `clean`: Remove unnecessary files and packages (APT, Snap)
- `up`: Check for available updates (APT, Snap, firmware)
- `audit`: Analyze storage and report cleanliness score
- `full`: Update followed by cleanup
- `install`: Update repository and reinstall commands
- `monitor`: Real-time system monitoring
- `syshelp`: Display help for system-tools commands

All commands suppress output, showing only status messages. Developed on Ubuntu 24.04.

## Design Principles

- Minimal output
- Deterministic behavior
- No external dependencies (beyond Ubuntu tools)
- Easy installation and portability
- Suitable for personal tooling
- Firmware updates are interactive (may require reboot)

## Installation

```bash
git clone https://github.com/mothloop/system-tools.git
cd system-tools
chmod +x install.sh bin/*
./install.sh
```

Creates executables in `~/.local/bin`. Adds to `PATH` if needed.

## Updates

Run `install` to update tools.

## Requirements

- Ubuntu/Debian-based system
- `apt`, `snap`, `bash`, `sudo`
- `fwupdmgr` (optional, for firmware)

## Path Configuration

Reload shell if commands not recognized: `source ~/.bashrc`

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
│   ├── monitor
│   └── syshelp
├── install.sh
└── README.md
```

## Usage

Run commands from anywhere:

```bash
update             # Update system
clean              # Clean system
up                 # Check updates
audit              # Analyze storage
full               # Update + clean
install            # Update tools
monitor            # Monitor system
syshelp list       # List all commands
syshelp <command>  # Show help for a command
```

## Safety Notes

- Operations require `sudo`
- Scripts suppress output; failures terminate without logs
- Review scripts before use

## License

MIT License
