include .vpn.env

.PHONY: default help import remove list-configs connect disconnect sessions status

default: help

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  import        Import config (if not already)"
	@echo "  connect       Connect VPN"
	@echo "  disconnect    Disconnect VPN"
	@echo "  remove        Remove config"
	@echo "  list-configs  List configs (verbose)"
	@echo "  sessions      List sessions"
	@echo "  status        Show connection status"
	@echo "  help          Show this help"

import:
	@if openvpn3 configs-list | grep -q "$(notdir $(VPN_CONFIG))"; then \
		echo "Config already imported"; \
	else \
		echo "Importing config..."; \
		openvpn3 config-import --config "$(VPN_CONFIG)" --persistent; \
	fi

remove:
	@echo "Removing config..."
	-@openvpn3 config-remove --config "$(VPN_CONFIG)" || echo "Config not found"

list-configs:
	openvpn3 configs-list --verbose

connect: 
	@if openvpn3 sessions-list | grep -q "$(notdir $(VPN_CONFIG))"; then \
		echo "Already connected"; \
	else \
		echo "Starting VPN session..."; \
		openvpn3 session-start --config "$(VPN_CONFIG)"; \
	fi

disconnect:
	@echo "Disconnecting..."
	-@openvpn3 session-manage --disconnect --config "$(VPN_CONFIG)" || echo "No active session"

sessions:
	openvpn3 sessions-list

status:
	@if openvpn3 sessions-list | grep -q "$(notdir $(VPN_CONFIG))"; then \
		echo "CONNECTED"; \
	else \
		echo "DISCONNECTED"; \
	fi

%:
	@echo "Unknown target: $@"
	@echo "Run 'make help' to see available commands"
