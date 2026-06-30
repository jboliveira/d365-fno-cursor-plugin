---
name: xpp-fno-testing
description: Applies D365 F&O SysTest unit testing and Acceptance Test Library (ATL) best practices including test isolation and data-agnostic patterns. Use when writing SysTestCase tests, ATL test data, test isolation configuration, or component tests in X++ finance and operations.
paths:
  - "**/*Test*.xml"
  - "**/AxClass/**"
  - "**/*.xpp"
metadata:
  version: "1.0.0"
  platform: "D365 Finance and Operations"
  sources: "Microsoft Learn F&O dev-itpro"
---

# D365 F&O Testing

SysTest and ATL patterns for reliable automated tests.

## When to Apply

- Writing unit or component tests
- Configuring test isolation
- Using ATL for test data setup
- Naming test methods

## Rules

- 	est-systestcase-attribute — SysTestCase + SysTestMethod
- 	est-isolation-autorollback — AutoRollback; no persisted data
- 	est-data-agnostic — tests own their data; no demo data dependency
- 	est-atl-fluent — ATL fluent API; var + inline declarations
- 	est-naming-when-given-then — descriptive names; never on production

## Additional Resources

- [references/testing-patterns.md](references/testing-patterns.md)
