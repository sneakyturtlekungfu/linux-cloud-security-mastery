# Attention to Detail

This section documents high-precision troubleshooting, polishing, and configuration fixes performed while building my Linux and cloud environments.

The goal is to show:

- Clear problem descriptions
- Root cause analysis
- Exact, reproducible fix steps
- Verification steps
- Lessons learned

## Current Areas

### 1. Desktop Environment (RHEL / GNOME)

`attention-to-detail/desktop-environment/`

- **Brave icon + launcher fix**  
  Path: `desktop-environment/brave-icon-fix/fix.md`  
  Notes how the Brave browser .desktop entry and icon were corrected so the proper lion icon appears in the app grid.

- **Tilix VTE integration warning fix**  
  Path: `desktop-environment/tilix-vte-warning-fix/fix.md`  
  Documents resolving the VTE configuration warning and integrating Tilix cleanly with the shell.

## How this folder is used

Whenever a small but meaningful issue is discovered and fixed:

1. Create a new subfolder under `attention-to-detail/`  
2. Add a `fix.md` file documenting:
   - Problem
   - Investigation
   - Fix steps (with commands)
   - Verification
   - Why it matters
3. Optionally add screenshots (before/after) to that subfolder.

Over time, this becomes a portfolio of real-world troubleshooting and attention to detail.
