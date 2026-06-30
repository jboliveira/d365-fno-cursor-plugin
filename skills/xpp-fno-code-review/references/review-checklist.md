# Code Review Checklist

## 1. Extension Model

- [ ] No overlayering; extensions only
- [ ] Correct technique: metadata → CoC → events → plugins
- [ ] Publisher prefix on new artifacts
- [ ] LCS request if no extension point exists

## 2. CoC Correctness

- [ ] `next` at first level, unconditional
- [ ] Wrapper signature matches base (no default param values)
- [ ] Separate extension classes for form datasource/control CoC
- [ ] `[ExtensionOf]` classes are `final`

## 3. Extensible Design

- [ ] Methods ≤10 lines where practical; ≤2 params
- [ ] Minimal public/protected surface
- [ ] No duplicated logic across extension points
- [ ] Switch defaults extracted to `[Replaceable]` methods

## 4. Data Integrity

- [ ] `select forUpdate` before update/delete
- [ ] Mutations in same TTS as forUpdate
- [ ] No `doUpdate`/`doInsert`/`doDelete`
- [ ] UpdateConflict handling with explicit catch + retry

## 5. Data Model

- [ ] Normalized design; no redundant legacy copies
- [ ] Indexes on query/join columns
- [ ] Delete actions defined
- [ ] Data entity choice appropriate for integration volume

## 6. Performance

- [ ] Set-based bulk where applicable
- [ ] Joins instead of N+1 nested selects
- [ ] Batch: short TTS, idempotent, ≤1000 tasks/job
- [ ] Trace Parser for hot paths (if performance-sensitive)

## 7. Forms

- [ ] Standard form pattern applied
- [ ] Not a monster all-in-one form
- [ ] Operational Workspace (not legacy Workspace)

## 8. Labels

- [ ] No hardcoded user-facing strings
- [ ] New labels added (not modifying existing `@SYS` labels)

## 9. Security

- [ ] New entry points have privilege/permission mapping
- [ ] Duties assigned to roles (least privilege)
- [ ] TPF for sensitive fields
- [ ] XDS policies performance-tested if used

## 10. Testing

- [ ] SysTestCase with SysTestMethod for new logic
- [ ] AutoRollback isolation configured
- [ ] Data-agnostic; no demo data dependency
- [ ] ATL for component/integration tests where appropriate

## 11. Breaking Changes

- [ ] No protected/public signature changes without major version plan
- [ ] No table field delete/rename without migration
- [ ] Compatibility checker run against baseline

## 12. Quality Gates

- [ ] Zero BP deviations target
- [ ] CAR report clean
- [ ] No new CAR/overlayering violations
