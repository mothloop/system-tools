# system-tools

Minimal, efficient system maintenance utilities for Ubuntu.

Provides small, focused CLI tools for system maintenance. Scripts are silent, predictable, easy to install, and highly optimized.

## Commands

- `update`: Full system update (APT, Snap, firmware)
- `clean`: Remove unnecessary files and packages (APT, Snap)
- `up`: Check for available updates (APT, Snap, firmware)
- `audit`: Analyze storage and report cleanliness score
- `full`: Update followed by cleanup
- `install`: Update repository and reinstall commands
- `monitor`: Real-time system monitoring
- `syshelp`: Display help for system-tools commands

All commands suppress output, showing only status messages. Developed and tested on Ubuntu 26.04.

## Design Principles

- **Minimal output** — Only show what matters
- **Deterministic behavior** — Predictable and reproducible
- **No external dependencies** — Uses only standard Ubuntu tools
- **Easy installation and portability** — Works across Ubuntu versions
- **Suitable for personal tooling** — Lightweight and focused
- **High performance** — Optimized for speed and efficiency
- **Maintainable** — Shared utilities reduce code duplication
- **Firmware updates are interactive** — May require reboot after update

## Installation

```bash
git clone https://github.com/mothloop/system-tools.git
cd system-tools
chmod +x install.sh bin/*
./install.sh
```

Creates executables in `~/.local/bin`. Adds to `PATH` if needed.

## Updates

Run `install` to update tools:

```bash
install
```

## Requirements

- Ubuntu 26.04+ (or compatible Debian-based system)
- `apt`, `snap`, `bash`, `sudo`
- `fwupdmgr` (optional, for firmware updates)
- `numfmt` (usually pre-installed)

## Path Configuration

Reload shell if commands not recognized:

```bash
source ~/.bashrc
```

## Repository Structure

```
system-tools/
├── lib/
│   ├── common.sh        # Shared utilities and functions
│   └── config.sh        # Configuration and constants
├── bin/
│   ├── update           # Full system update
│   ├── clean            # Clean system
│   ├── up               # Check updates
│   ├── audit            # Storage analysis
│   ├── full             # Update + clean
│   ├── install          # Update tools
│   ├── monitor          # System monitor
│   └── syshelp          # Help system
├── install.sh           # Installation script
└── README.md            # This file
```

## Usage

Run commands from anywhere:

```bash
update              # Update system (APT, Snap, firmware)
clean               # Clean system (APT, Snap)
up                  # Check for updates
audit               # Analyze storage and system health
full                # Update then clean
install             # Update and reinstall tools
monitor             # Monitor system in real-time
syshelp list        # List all commands
syshelp <command>   # Show help for a command
```

## Performance Features

- **Shared utilities library** — Eliminates code duplication
- **Configurable thresholds** — Easy to adjust for different systems
- **Optimized parsing** — Efficient use of pipes and AWK
- **Smart caching** — Reuses parsed data where possible
- **Parallel initialization** — Monitor and other scripts initialize state efficiently

## Safety Notes

- Operations require `sudo` (ask once at the beginning)
- Scripts suppress output; failures terminate without logs
- Review scripts before use
- Firmware updates may require reboot

## Configuration

Edit `lib/config.sh` to customize:

- Cache and temp thresholds
- Cleanliness score weights
- Monitor refresh interval
- Feature flags

## Troubleshooting

**Commands not found after install?**
- Run: `source ~/.bashrc`
- Check: `echo $PATH` includes `~/.local/bin`

**Permission denied?**
- Run: `chmod +x install.sh bin/*`

**Firmware updates unavailable?**
- Check: `which fwupdmgr`
- Disable in config: `ENABLE_FIRMWARE_UPDATES=false`

## License

MIT License
