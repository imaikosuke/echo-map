# Portfolio Project Makefile
# Requires pnpm to be installed

.PHONY: all install dev build start lint lint-fix format-check format clean check secretlint help

# Default target
all: help

# Install dependencies
install:
	pnpm install

# Development server with turbopack
dev:
	pnpm dev

# Build the production application
build:
	pnpm build

# Start the production server
start:
	pnpm start

# Run linting
lint:
	pnpm lint

# Run linting with auto-fix
lint-fix:
	pnpm lint-fix

# Check formatting with Prettier
format-check:
	pnpm prettier-check

# Fix formatting with Prettier
format:
	pnpm prettier

# Run secretlint to check for leaked secrets
secretlint:
	pnpm secretlint

# Cleanup
clean:
	rm -rf .next
	rm -rf node_modules

# Run all checks (linting, formatting, secrets)
check: lint format-check secretlint

# Help command
help:
	@echo "Usage:"
	@echo "  make install       Install dependencies"
	@echo "  make dev           Start development server with turbopack"
	@echo "  make build         Build production application"
	@echo "  make start         Start production server"
	@echo "  make lint          Run ESLint"
	@echo "  make lint-fix      Run ESLint with auto-fix"
	@echo "  make format        Fix formatting with Prettier"
	@echo "  make format-check  Check formatting with Prettier"
	@echo "  make secretlint    Run secretlint to check for leaked secrets"
	@echo "  make clean         Remove built artifacts and dependencies"
	@echo "  make check         Run all checks (lint, format, secrets)"
	@echo "  make help          Show this help message"
