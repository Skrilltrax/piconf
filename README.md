# piconf

A versioned [pi](https://github.com/badlogic/pi-mono) harness config: settings, global
agent instructions, and a curated set of standard skills from the community repos.

## What's inside

```
piconf/
├── settings.json     # pi settings (symlinked to ~/.pi/agent/settings.json)
├── AGENTS.md         # global agent instructions (symlinked to ~/.pi/agent/AGENTS.md)
├── install.sh        # wires everything up
├── skills/           # your personal skills (auto-loaded)
├── extensions/       # your personal extensions (auto-loaded)
├── prompts/          # your personal prompt templates (auto-loaded)
└── themes/           # your personal themes (auto-loaded)
```

## Seeded skill repos

`install.sh` clones these into `~/.pi/agent/skills/`, where pi auto-discovers any
folder containing a `SKILL.md`. No settings entries required.

| Repo | Skills |
|------|--------|
| [badlogic/pi-skills](https://github.com/badlogic/pi-skills) | brave-search, browser-tools, gccli, gdcli, gmcli, transcribe, vscode, youtube-transcript |
| [anthropics/skills](https://github.com/anthropics/skills) | docx, pdf, pptx, xlsx + creative/dev/enterprise examples |
| [obra/superpowers](https://github.com/obra/superpowers) | systematic-debugging, test-driven-development, requesting/receiving-code-review, using-git-worktrees, writing-skills, planning, verification |
| [android/skills](https://github.com/android/skills) | Google official: Compose adaptive/migration/styles, navigation-3, edge-to-edge, perfetto, R8, intent security, AGP, camera, wear |
| [chrisbanes/skills](https://github.com/chrisbanes/skills) | deep Compose (state, recomposition, stability, side-effects, slot API) + Kotlin (coroutines, flows, value classes, KMP) |

> **Security:** skills can instruct the model to run arbitrary commands and may
> ship executables. Review the source of anything you clone before trusting it.

## Install

```bash
git clone <this-repo> ~/.piconf   # or anywhere you like
cd ~/.piconf
./install.sh
```

`install.sh` will:
1. Back up any existing `~/.pi/agent/settings.json` and `~/.pi/agent/AGENTS.md`.
2. Symlink this repo's `settings.json` and `AGENTS.md` into `~/.pi/agent/`.
3. Clone (or update) the two standard skill repos into `~/.pi/agent/skills/`.
4. Print next steps.

Then start pi:

```bash
pi
```

> If you cloned somewhere other than `~/.piconf`, edit the `skills`,
> `extensions`, `prompts`, and `themes` paths in `settings.json` to match, then
> re-run `install.sh`.

## Optional community packages

Pi packages (npm/git) extend pi with tools, UI tweaks, and integrations. A few
popular ones — install the ones you want, then they appear in `packages`:

```bash
pi install npm:pi-spark                                # daily-experience polish
pi install npm:@danypops/pi-packed                     # lifecycle, profiles, daemon
pi install npm:@demigodmode/pi-web-agent               # reliable web search/fetch
pi install npm:@eko24ive/pi-ask                        # interactive clarification tool
pi install git:github.com/zigai/pi-tweaks              # the @zigai UI-tweak family
pi list                                                # show what's installed
```

Browse more at the [package gallery](https://pi.dev/packages) (search keyword
`pi-package`).

## Update

```bash
cd ~/.piconf && git pull && ./install.sh        # this repo + skill repos
pi update --all                                     # pi CLI + installed packages
```

## Files you'll want to edit

- `settings.json` — provider, model, theme, paths.
- `AGENTS.md` — how you want the agent to behave globally.
- `skills/` etc. — drop in your own resources; they load automatically.
