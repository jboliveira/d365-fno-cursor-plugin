---
title: Batch Parameter Versioning
impact: MEDIUM
impactDescription: Parameter changes break in-flight batch jobs without versioning
tags: business-logic, batch, parameters
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/batch-parameter-versioning
---

## Batch Parameter Versioning

Version parameter lists; unpack both old and new formats.

**Incorrect:**
```xpp
public container pack()
{
    return [#CurrentVersion, parmFromDate, parmToDate]; // Removed parmIncludeClosed
}

public boolean unpack(container _packedClass)
{
    int version = conPeek(_packedClass, 1);
    parmFromDate = conPeek(_packedClass, 2);
    parmToDate = conPeek(_packedClass, 3);
    return true; // In-flight jobs with old pack format fail
}
```

**Correct:**
```xpp
public container pack()
{
    return [#CurrentVersion, parmFromDate, parmToDate, parmIncludeClosed];
}

public boolean unpack(container _packedClass)
{
    int version = conPeek(_packedClass, 1);
    switch (version)
    {
        case #CurrentVersion:
            parmFromDate = conPeek(_packedClass, 2);
            parmToDate = conPeek(_packedClass, 3);
            parmIncludeClosed = conPeek(_packedClass, 4);
            break;
        case #PriorVersion:
            parmFromDate = conPeek(_packedClass, 2);
            parmToDate = conPeek(_packedClass, 3);
            parmIncludeClosed = NoYes::No;
            break;
        default:
            return false;
    }
    return true;
}
```
