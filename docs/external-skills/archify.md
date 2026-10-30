# Archify — optional external skill for Codex

- Upstream repository: https://github.com/tt-a1i/archify
- Upstream skill: https://github.com/tt-a1i/archify/blob/main/archify/SKILL.md
- Skill name: `archify`
- License: Apache-2.0 (upstream)
- Scope: **optional external integration**, not one of this repository's bundled engineering skills.
- Upstream stable release observed on 2026-10-30: 3.2.0. Check upstream release information before installing/updating.

## Purpose

Archify generates interactive, standalone HTML diagrams of software architecture, workflows, sequences, data flow, states, ERDs, classes, repository trees, timelines, and request timing. It can visualize a description or cite inspected repository code. It **does not** replace tests, code review, or production approval.

Use it **after** the appropriate codebase analysis, in combination with this repository's `codebase-design`, `domain-modeling`, `diagnosing-bugs`, and `code-review` practices as applicable.

## Install on Windows for Codex CLI

The source contains one distributable skill named `archify` (at `archify/SKILL.md`). Review that skill and the code it may execute before installation. Requires Node.js and `npx`.

1. Discover the upstream skill before changing your machine:

   ```powershell
   npx.cmd -y skills add tt-a1i/archify --list --full-depth
   ```

   Proceed **only** if discovery succeeds and lists exactly one matching skill named `archify`. Stop for unexpected names, conflicts, or errors.

2. From PowerShell, install for **Codex CLI only**, globally so different projects can use it:

   ```powershell
   npx.cmd -y skills add tt-a1i/archify --skill archify --agent codex --global --copy
   ```

   This is an intentional installation into your Windows agent environment, **not** a change made by merging this PR. Follow the installer prompts; do not overwrite an unrelated skill.

   Alternatively, after reviewing the discovery output, run the optional guided script from the root of this skills repository:

   ```powershell
   .\scripts\install-archify-codex.ps1
   ```

3. Check the generated file and start a **new Codex session**:

   ```powershell
   Test-Path "$HOME\.agents\skills\archify\SKILL.md"
   ```

   The expected value is `True` for the documented global Codex location. Installation must also report success; a file's existence by itself does not prove Codex has discovered the skill.

4. Try:

   ```text
   Use the archify skill. Inspect this repository and generate an interactive
   HTML architecture diagram. Trace the actual calls and cite source files.
   Do not change application code or operating data.
   ```

   Verify the HTML output, source links, and the skill's validation receipt. **No installation or runtime test was performed by this GitHub change.**

## Suggested use in warehouse/dispatch projects

- Architecture: UI → API/service → SQLite → backups, with real module boundaries.
- Sequence: draft dispatch → confirmation → deduction of inventory.
- Data flow: Excel import → normalization → SKU lookup → operational snapshots.
- Lifecycle: draft, confirmed, cancelled/deleted and exceptional paths.

Always read the actual project source before drawing a code-backed diagram, and label hypothetical flows clearly.

## Maintenance & boundaries

- Archify remains maintained by `tt-a1i`; this repository **does not vendor, fork, or auto-update** upstream code.
- No modified core skills, no new application dependencies, and no production runtime integration.
- The HTML can be viewed locally; some Archify commands perform a bounded version/update check against an upstream endpoint. Review upstream privacy and update documentation for your environment.
- Offline-first workflows may require an initial online download. Do not assume all optional checks are offline.
- To update or uninstall a live Archify installation, use its upstream instructions explicitly; merging a doc change never authorizes installing/updating software.
