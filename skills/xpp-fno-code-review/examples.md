# Code Review Examples

## Example 1: CoC Violation

**Finding (Critical):** CoC wrapper calls `next` inside conditional block.

```xpp
public boolean validateWrite()
{
    boolean ret;
    if (this.MyPubField)
    {
        ret = next validateWrite();
    }
    return ret;
}
```

**Recommendation:** Move `next` to first level; apply custom logic after.

```xpp
public boolean validateWrite()
{
    boolean ret = next validateWrite();
    if (ret && this.MyPubField)
    {
        ret = this.validateCustomRule();
    }
    return ret;
}
```

**Rule:** `ext-coc-next-first-level`

---

## Example 2: Data Integrity

**Finding (Critical):** Update without `forUpdate`.

```xpp
ttsBegin;
select custTable where custTable.AccountNum == _accountNum;
custTable.CreditMax = 5000;
custTable.update();
ttsCommit;
```

**Recommendation:** Add `forUpdate` and null check.

**Rule:** `data-forupdate-before-mutate`

---

## Example 3: Security Gap

**Finding (Critical):** New menu item without privilege mapping.

**Recommendation:** Create privilege with menu item permission; add to duty; assign duty to role.

**Rule:** `sec-entry-point-permissions`

---

## Example 4: Missing Tests

**Finding (Suggestion):** New `OrderValidationService` class has no SysTest coverage.

**Recommendation:** Add `MyPub_OrderValidationServiceTest extends SysTestCase` with AutoRollback and data-agnostic ATL setup.

**Rule:** `test-systestcase-attribute`, `test-data-agnostic`

---

## Example 5: Form Pattern

**Finding (Suggestion):** New workspace uses legacy Workspace pattern.

**Recommendation:** Migrate to Operational Workspace pattern.

**Rule:** `form-operational-workspace`
