.PHONY: help install uninstall lint test clean check-shellcheck

help:
	@echo "system-tools development commands:"
	@echo "  make install          - Install system-tools"
	@echo "  make uninstall        - Remove system-tools"
	@echo "  make lint             - Check code with shellcheck"
	@echo "  make test             - Run basic tests"
	@echo "  make clean            - Remove temporary files"

install:
	@chmod +x install.sh bin/*
	@./install.sh

uninstall:
	@rm -f ~/.local/bin/{update,clean,audit,up,full,install,monitor,syshelp}
	@rm -f ~/.system-tools-repo
	@echo "system-tools removed from ~/.local/bin"

check-shellcheck:
	@command -v shellcheck >/dev/null 2>&1 || { echo "shellcheck not found. Install with: apt install shellcheck"; exit 1; }

lint: check-shellcheck
	@echo "Checking bin scripts..."
	@shellcheck bin/* || true
	@echo "Checking lib files..."
	@shellcheck lib/*.sh || true
	@echo "Checking install script..."
	@shellcheck install.sh || true

test:
	@echo "Testing system-tools installation..."
	@chmod +x install.sh bin/*
	@echo "✓ Scripts are executable"
	@[ -f lib/common.sh ] && echo "✓ lib/common.sh exists" || (echo "✗ lib/common.sh missing"; exit 1)
	@[ -f lib/config.sh ] && echo "✓ lib/config.sh exists" || (echo "✗ lib/config.sh missing"; exit 1)
	@echo "✓ All tests passed"

clean:
	@find . -type f -name "*.bak" -delete
	@find . -type f -name "*~" -delete
	@echo "Cleaned up temporary files"

.PHONY: help install uninstall lint test clean check-shellcheck
