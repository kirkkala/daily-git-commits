#!/bin/bash

# Uninstallation script for daily-commits
# This script removes daily-commits from your system

set -e  # Exit on error

COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_YELLOW='\033[1;33m'
COLOR_RED='\033[0;31m'
COLOR_RESET='\033[0m'

INSTALL_DIR="/usr/local/bin"
COMMAND_NAME="daily-commits"
CONFIG_DIR="${HOME}/.config/daily-git-commits"

echo ""
echo -e "${COLOR_BLUE}╔═══════════════════════════════════════════════════════╗${COLOR_RESET}"
echo -e "${COLOR_BLUE}║                                                       ║${COLOR_RESET}"
echo -e "${COLOR_BLUE}║         📦  daily-commits uninstaller  👋             ║${COLOR_RESET}"
echo -e "${COLOR_BLUE}║                                                       ║${COLOR_RESET}"
echo -e "${COLOR_BLUE}╚═══════════════════════════════════════════════════════╝${COLOR_RESET}"
echo ""

# Check if installed
if [[ ! -f "${INSTALL_DIR}/${COMMAND_NAME}" ]]; then
  echo -e "${COLOR_YELLOW}⚠️  ${COMMAND_NAME} is not currently installed${COLOR_RESET}\n"
  exit 0
fi

# Confirm uninstallation
echo -e "${COLOR_YELLOW}This will remove:${COLOR_RESET}"
echo -e "  • ${INSTALL_DIR}/${COMMAND_NAME}"
echo ""
read -p "$(echo -e ${COLOR_YELLOW})Do you want to continue? (y/N) $(echo -e ${COLOR_RESET})" -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo -e "\n${COLOR_BLUE}Uninstallation cancelled.${COLOR_RESET}\n"
  exit 0
fi

echo ""

# Check if we need sudo
if [[ ! -w "$INSTALL_DIR" ]]; then
  echo -e "${COLOR_YELLOW}⚠️  Removing from ${INSTALL_DIR} requires elevated privileges${COLOR_RESET}"
  echo -e "   You may be prompted for your password...\n"
  USE_SUDO="sudo"
else
  USE_SUDO=""
fi

# Remove the command
echo -e "${COLOR_BLUE}🗑️  Removing ${COMMAND_NAME}...${COLOR_RESET}"
$USE_SUDO rm -f "${INSTALL_DIR}/${COMMAND_NAME}"
echo -e "${COLOR_GREEN}✓ Removed ${INSTALL_DIR}/${COMMAND_NAME}${COLOR_RESET}"

# Ask about configuration
echo ""
if [[ -d "$CONFIG_DIR" ]]; then
  echo -e "${COLOR_YELLOW}Configuration found at: ${CONFIG_DIR}${COLOR_RESET}"
  read -p "$(echo -e ${COLOR_YELLOW})Do you want to remove your configuration too? (y/N) $(echo -e ${COLOR_RESET})" -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$CONFIG_DIR"
    echo -e "${COLOR_GREEN}✓ Removed configuration directory${COLOR_RESET}"
  else
    echo -e "${COLOR_BLUE}ℹ️  Kept configuration (for future reinstall)${COLOR_RESET}"
  fi
fi

echo ""
echo -e "${COLOR_GREEN}╔═══════════════════════════════════════════════════════╗${COLOR_RESET}"
echo -e "${COLOR_GREEN}║                                                       ║${COLOR_RESET}"
echo -e "${COLOR_GREEN}║        ✅  Uninstallation complete! 👋                ║${COLOR_RESET}"
echo -e "${COLOR_GREEN}║                                                       ║${COLOR_RESET}"
echo -e "${COLOR_GREEN}╚═══════════════════════════════════════════════════════╝${COLOR_RESET}"
echo ""
echo -e "${COLOR_BLUE}Thanks for using daily-commits!${COLOR_RESET}"
echo -e "You can reinstall anytime by running: ${COLOR_GREEN}./install.sh${COLOR_RESET}"
echo ""

