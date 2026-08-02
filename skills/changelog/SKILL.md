---
name: changelog
description: Maintain a changelog and cut releases. Use when preparing release notes, bumping versions, or keeping a CHANGELOG current.
---

# changelog

A changelog records what changed for humans, in chronological order. https://keepachangelog.com conventions below.

## File

Keep `CHANGELOG.md` at the repo root.

## Format

```
# Changelog

## [Unreleased]

## [1.2.0] - 2026-08-02
### Added
- Rate limiting on the login endpoint.

### Changed
- Tokens now expire after 1 hour (was 24).

### Deprecated
- `oldThing()` will be removed in 2.0.

### Removed
- Dropped support for Node 16.

### Fixed
- Crash on empty input.

### Security
- Patched CVE-XXXX in dependency `foo`.
```

- Top entry is **`[Unreleased]`**. Add items there as you ship; promote to a version on release.
- Categories: Added / Changed / Deprecated / Removed / Fixed / Security.

## Versioning (SemVer)

Given `MAJOR.MINOR.PATCH`:

- **PATCH**: backwards-compatible fixes.
- **MINOR**: backwards-compatible features.
- **MAJOR**: incompatible changes.

Pre-1.0 (`0.x`) — anything goes; document it.

## Cutting a release

1. Move `[Unreleased]` items under a new version heading with today's date.
2. Start a fresh empty `[Unreleased]` above it.
3. Bump the version in the manifest and any internal references.
4. Update version badge/links (compare links at the bottom of the file).
5. Commit: `chore(release): 1.2.0`.
6. Tag: `git tag -s v1.2.0` and push tags.

## Don't

- Don't write release notes from commit messages alone — curate for users.
- Don't bury breaking changes in "Changed"; call them out and document migration.
- Don't release without updating the changelog in the same commit/tag.
