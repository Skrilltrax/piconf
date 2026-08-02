---
name: security
description: Review and harden code against common vulnerabilities. Use for web/auth/API code, handling user input, secrets, or untrusted data. OWASP-style threat checklist.
---

# security

Assume input is hostile. Trust nothing past a validated boundary.

## Threat model first

- What's the asset? (data, credentials, funds, availability)
- Who's the attacker and what can they reach? (anonymous, authenticated, insider)
- Spend effort proportional to the actual risk.

## Checklist

**Input & output**
- Validate and constrain at trust boundaries (type, length, format, range).
- Parameterize queries. Never interpolate into SQL / shell / templates / commands.
- Encode on output for the right context (HTML, URL, JS, attribute).

**Authn & authz**
- Verify identity, then authorize every privileged action — on the server.
- Never trust client-side checks or hidden fields for access control.
- Hash passwords (Argon2/bcrypt); constant-time comparisons for secrets/tokens.
- Tokens: short-lived, scoped, revocable. Rotate keys.

**Secrets**
- No secrets in code, logs, URLs, error messages, or commits.
- Load from env/secret manager; fail closed if missing.
- Check `.gitignore` and history for leaks. Rotate anything that was committed.

**Transport & deps**
- TLS everywhere. Reject expired/invalid certs by default.
- Pin and audit dependencies (`npm audit`, `pip-audit`, SBOM). Update on CVEs.

**Common classes**
- Injection (SQLi, command, SSRF, XPATH), XSS, CSRF, open redirect.
- Path traversal, deserialization of untrusted data, ReDoS.
- IDOR / missing object-level authz, mass assignment.

## Mindset

- Fail closed (deny by default), not open.
- Log security events; rate-limit and monitor abuse.
- Least privilege: minimum scopes, permissions, and surface.
