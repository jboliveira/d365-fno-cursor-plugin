# Workflows

Eight end-to-end scenarios with copy-paste prompts, expected agent/skill chains, artifacts, and quality gates.

## 1. New table extension field

**Starting prompt:**

```text
/xpp-fno-planner Add a new EDT-backed field "Customer tier" to CustTable via table extension in our publisher model.
```

**Expected chain:**

1. `/xpp-fno-planner` → plan with table extension artifact
2. `/xpp-fno-implementer` with plan → creates `AxTableExtension`, EDT if needed, labels
3. `subagentStop` hook → auto `/xpp-fno-reviewer`

**Skills:** `xpp-fno-data`, `xpp-fno-extensibility`

**Rules:** `xpp-fno-core`, `xpp-fno-data-access`, `xpp-fno-scenario-router`

**Artifacts touched:**

- `AxTableExtension/CustTable.MyPublisher.xpp` (or similar)
- `AxEdt/` (if new EDT)
- Label file

**Quality gates before merge:**

- Best practice check — zero deviations
- Compatibility checker vs baseline
- No overlayering; publisher prefix on all artifacts

---

## 2. CoC on validateWrite

**Starting prompt:**

```text
/xpp-fno-planner Add CoC validation on SalesTable.validateWrite to block orders when credit limit is exceeded.
```

**Expected chain:**

1. Planner identifies CoC on `validateWrite` (scenario router row: validate before save)
2. Implementer creates `[ExtensionOf(tableStr(SalesTable))]` CoC class with `next` at first level
3. Auto-reviewer checks CoC correctness (step 2 of checklist)

**Skills:** `xpp-fno-extensibility`, `xpp-fno-business-logic`

**Rules:** `xpp-fno-extensibility`, `xpp-fno-core`

**Artifacts touched:**

- `AxClass/SalesTableMyPublisher_ValidateWrite.xpp`

**Quality gates:**

- CoC: unconditional `next` at first method level
- BP check; compatibility checker
- SysTest for validation rule (recommended)

---

## 3. SysOperation batch job

**Starting prompt:**

```text
/xpp-fno-planner Create a SysOperation batch job to export open sales orders nightly with a dialog for date range.
```

**Expected chain:**

1. Planner recommends SysOperationServiceController + contract + service (not RunBaseBatch for greenfield)
2. Implementer creates controller, contract, service classes + menu item
3. Reviewer checks batch TTS scope, idempotency, parameter versioning

**Skills:** `xpp-fno-business-logic`, `xpp-fno-data`

**Rules:** `xpp-fno-batch-logic`, `xpp-fno-data-access`

**Artifacts touched:**

- `AxClass/*Controller.xpp`, `*Contract.xpp`, `*Service.xpp`
- `AxMenuItemAction/` or `AxMenuItemOutput/`
- Security artifacts (privilege, duty, role assignment)

**Quality gates:**

- Short TTS scopes in batch
- SysOperation pattern (not legacy RunBaseBatch)
- Entry-point security configured
- SysTest for service logic

---

## 4. Form extension + security

**Starting prompt:**

```text
/xpp-fno-planner Show "Customer tier" on CustTable form via form extension and secure the new view with least-privilege RBAC.
```

**Expected chain:**

1. Planner: form extension + privilege → duty → role
2. Implementer: form extension, label, security artifacts
3. Reviewer: form pattern (step 7), security (step 9), labels (step 8)

**Skills:** `xpp-fno-forms-ui`, `xpp-fno-security`, `xpp-fno-data`

**Rules:** `xpp-fno-forms-ui`, `xpp-fno-security`, `xpp-fno-core`

**Artifacts touched:**

- `AxFormExtension/CustTable.MyPublisher.xpp`
- `AxSecurityPrivilege/`, `AxSecurityDuty/`, role extension or assignment
- `AxMenuItemDisplay/` (if new entry point)

**Quality gates:**

- Standard form pattern applied
- Labels — no hardcoded captions
- Privilege → duty → role chain complete
- Compatibility checker

---

## 5. SysTest for new logic

**Starting prompt:**

```text
/xpp-fno-implementer Add SysTest coverage for the credit limit validation in SalesTableMyPublisher_ValidateWrite using ATL and AutoRollback.
```

**Expected chain:**

1. Implementer loads `xpp-fno-testing` skill
2. Creates `SysTestCase` class with `[SysTestMethod]` attributes
3. Reviewer verifies step 10 (testing) of checklist

**Skills:** `xpp-fno-testing`, `xpp-fno-business-logic`

**Rules:** `xpp-fno-testing`

**Artifacts touched:**

- `AxClass/SalesTableMyPublisher_ValidateWriteTest.xpp`

**Quality gates:**

- Data-agnostic tests (ATL builders, no production data dependency)
- AutoRollback for isolation
- When-given-then naming convention
- All tests pass in CI/local test run

---

## 6. Pre-merge PR review

**Starting prompt:**

```text
/xpp-fno-reviewer Review my branch changes against the 12-step checklist. Focus on CoC, forUpdate, security entry points, and SysTest coverage.
```

**Alternative (in current chat):**

```text
/xpp-fno-code-review Review the X++ changes in this branch for BP, compatibility, and security.
```

**Expected chain:**

1. Reviewer agent uses bash for `git diff` / `git status`
2. Explore inspects changed Ax* files
3. 12-step checklist with Critical / Suggestion / Nice to have output

**Skills:** `xpp-fno-code-review` (+ domain skills as needed per finding)

**Rules:** All applicable xpp-fno rules cross-checked

**Quality gates verified:**

- Extension model (step 1)
- CoC correctness (step 2)
- Data integrity — forUpdate, no do-methods (step 4)
- Security entry points (step 9)
- Testing coverage (step 10)
- BP zero + CAR clean (step 12)

---

## 7. Debug a batch job failure

**Starting prompt:**

```text
/xpp-fno-debugger Batch job Contoso_ExportOrders fails nightly with Infolog "Cannot create a record in Export staging table" on line 87 of Contoso_ExportOrdersService.
```

**Alternative (in current chat):**

```text
/xpp-fno-debug Batch Contoso_ExportOrders fails with staging table insert error — help me find root cause.
```

**Expected chain:**

1. Debugger loads `xpp-fno-debug` skill + `xpp-fno-debugging` rule
2. Explore searches service class, staging table, related CoC
3. Output: symptom → reproduction → root cause → minimal fix → verify steps

**Skills:** `xpp-fno-debug`, `xpp-fno-business-logic`, `xpp-fno-data`

**Rules:** `xpp-fno-debugging`, `xpp-fno-batch-logic`, `xpp-fno-data-access`

**Follow-up after fix:**

```text
/xpp-fno-implementer Apply the minimal fix from the debug report.
/xpp-fno-verify Claim: batch job completes with zero BP deviations and staging records created.
```

---

## 8. Verify before merge

**Starting prompt:**

```text
/xpp-fno-verify Claim: project compiles with zero BP deviations, compatibility checker is clean, and SalesTableMyPublisher_ValidateWriteTest passes.
```

**Expected chain:**

1. Verify skill requests evidence (build output, BP report, test results)
2. Returns **VERIFIED**, **NOT VERIFIED**, or **INCONCLUSIVE** with cited evidence

**Skills:** `xpp-fno-verify`, `xpp-fno-testing`

**Rules:** `xpp-fno-core`, `xpp-fno-testing`

**Quality gates verified:**

- Compile succeeds
- BP check — zero deviations
- Compatibility checker vs baseline
- SysTest pass (when claimed)

---

## Quick reference: which workflow?

| Goal | Start with |
|------|------------|
| Plan before coding | `/xpp-fno-plan` or `/xpp-fno-planner` |
| Implement from plan | `/xpp-fno-implement` or `/xpp-fno-implementer` |
| Audit before merge | `/xpp-fno-review` or `/xpp-fno-reviewer` |
| Quick in-chat review | `/xpp-fno-code-review` |
| Runtime failure | `/xpp-fno-debug` or `/xpp-fno-debugger` |
| Prove fix works | `/xpp-fno-verify` |
| Unclear technique | Hub skill or `@xpp-fno-scenario-router` |

## See also

- [Commands](commands.md) — slash command reference
- [Agents](agents.md) — agent capabilities and output formats
- [Skills](skills.md) — domain skill catalog
- [Rules](rules.md) — scenario router table
