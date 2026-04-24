# Development Guidelines

## Architecture

### Library Organization

- **lib/common.sh** — Shared utility functions used across scripts
- **lib/config.sh** — Configuration constants and thresholds
- **bin/** — Individual command scripts

### Adding New Functions

New utility functions should be:

1. Added to `lib/common.sh`
2. Exported with `export -f function_name`
3. Documented with a comment explaining purpose and usage
4. Tested across different systems if possible

### Creating New Commands

To add a new system-tools command:

1. Create `bin/newcommand`
2. Source the common libraries at the top:
   ```bash
   SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
   source "$SCRIPT_DIR/lib/common.sh"
   source "$SCRIPT_DIR/lib/config.sh"
   ```
3. Use helper functions instead of duplicating code
4. Make it executable: `chmod +x bin/newcommand`
5. Add to `SCRIPTS` array in `install.sh`
6. Document in README.md

## Code Standards

### Bash Best Practices

- Always use `set -euo pipefail` at the top of scripts
- Use `shellcheck` for linting: `shellcheck bin/*`
- Prefer `printf` over `echo` for portability
- Use `[[ ]]` for conditionals (bash), `[ ]` for POSIX compat
- Quote all variables: `"$var"` instead of `$var`
- Use meaningful variable names in UPPERCASE for constants
- Use lowercase for function and local variables

### Efficiency

- Minimize subprocess calls (avoid unnecessary pipes)
- Reuse parsed data rather than re-parsing
- Batch operations when possible
- Use built-in bash when faster than external commands
- Cache results that don't change frequently

### Error Handling

- Use `set -euo pipefail` to fail fast
- Provide meaningful error messages
- Use `trap` for cleanup when necessary
- Validate inputs before processing

## Configuration Management

### Adding New Configuration Variables

1. Add to `lib/config.sh` with a clear comment
2. Export it: `export VARIABLE_NAME`
3. Use UPPERCASE names for constants
4. Document default values and ranges

### Dynamic Configuration

For user-specific settings, consider:

1. Environment variables that override defaults
2. A per-user config file (e.g., `~/.system-tools/config`)
3. Command-line flags for overrides

## Performance Considerations

### Data Collection

For scripts that parse system data:

1. Minimize calls to expensive commands (`apt list`, `fwupdmgr`)
2. Parse `/proc` directly when faster
3. Cache results within a single run
4. Use string manipulation instead of external tools when possible

### Monitoring

The `monitor` script has special performance requirements:

- Reads are sampled every `MONITOR_REFRESH_INTERVAL` seconds
- Use efficient parsing of `/proc/diskstats` and `/proc/net/dev`
- Calculate deltas for rate calculation
- Terminal rendering should be fast (use ANSI codes)

## Testing

### Manual Testing

Before committing changes:

1. Test on a fresh Ubuntu 26.04 system when possible
2. Verify all commands work without errors
3. Check output formatting is correct
4. Test error cases (missing tools, permission issues)

### Automated Testing

Recommended improvements for future versions:

- Create `tests/` directory with test scripts
- Use BATS (Bash Automated Testing System)
- Test error handling and edge cases
- Mock external commands for predictable testing

## Code Review Checklist

Before submitting changes:

- [ ] No code duplication (use shared functions)
- [ ] Consistent with existing style
- [ ] All variables quoted properly
- [ ] Error handling appropriate
- [ ] Comments explain why, not what
- [ ] README updated if behavior changed
- [ ] Configuration options in `lib/config.sh`
- [ ] Tested on Ubuntu 26.04

## Performance Benchmarks

Current performance targets (may improve):

- `update` — Should complete in < 2 minutes
- `clean` — Should complete in < 1 minute
- `audit` — Should complete in < 10 seconds
- `monitor` — Should use < 5% CPU
- `up` — Should complete in < 30 seconds

## Future Improvements

Potential enhancements:

1. **Logging** — Optional log file for debugging
2. **Notifications** — Desktop/email alerts for important events
3. **Scheduling** — Cron job templates for automation
4. **Systemd units** — Service files for background monitoring
5. **Statistics** — Track system metrics over time
6. **Multi-system** — Remote monitoring via SSH
7. **Rollback** — Snapshot system before major operations

## Debugging

### Enable Debug Output

Add to any script for debug tracing:

```bash
set -x  # Enable debug output
```

### Common Issues

1. **Scripts not found** — Check `$PATH` and file permissions
2. **sudo not working** — Verify wheel/sudoers group membership
3. **Permission denied** — Ensure scripts are executable: `chmod +x`
4. **Source errors** — Verify relative paths from script location

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes following guidelines
4. Test thoroughly
5. Submit pull request with clear description
6. Address any review comments

## License

All code follows the MIT License as defined in LICENSE file.
