# RHEL WSL – Podman & Ansible Mini Platform

This project lives under the **linux-admin › rhel** skill pillar and shows a
small, professional automation pattern using:

- RHEL (running under WSL2)
- Podman (rootless pods and containers)
- Ansible (as the automation/control layer)

## Goal

Use Ansible to deploy and manage a simple Podman pod on localhost, hosting:
- An Nginx front-end (static page / reverse proxy)
- A "whoami" style backend container

Designed to run on **RHEL on WSL** but be easily portable to a full RHEL VM.

## Layout

- `ansible/` – inventory, playbooks, roles
- `podman/` – pod/container-specific configs (future enhancements)
- `files/` – static files (e.g., custom index.html)
- `docs/` – architecture and runbook notes
