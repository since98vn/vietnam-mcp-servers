# Security policy

The MCP servers and REST APIs described here run on since98.vn. They are read-only, take no credentials and store no request content.

## Reporting a vulnerability

Please do not open a public issue for a security problem. Write to **hello@since98.vn** with the subject line "Security", and include:

- the endpoint or tool involved;
- what you did and what happened;
- the impact you see.

We reply within a few working days and tell you when the problem is fixed. Please give us reasonable time to fix it before you publish details, and do not run tests that degrade the service for other people (load tests, attempts to bypass the rate limit) or that access data other than your own.

## Scope

In scope: `https://since98.vn/api/mcp/*` and `https://since98.vn/api/v1/*`.

Out of scope: rate-limit responses (`429`) as such, reports from automated scanners without a demonstrated impact, and third-party services such as Cloudflare.
