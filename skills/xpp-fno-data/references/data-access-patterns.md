# Data Access Patterns

## Transaction Template

```xpp
ttsBegin;
    select forUpdate custTable
        where custTable.AccountNum == _accountNum;

    if (custTable.RecId)
    {
        custTable.CreditMax = _newCreditMax;
        custTable.update();
    }
ttsCommit;
```

## Set-Based Bulk

```xpp
ttsBegin;
update_recordset custTable
    setting CreditMax = custTable.CreditMax + 1000
    where custTable.CreditMax > 0;
ttsCommit;
```

## Update Conflict Retry

```xpp
try
{
    ttsbegin;
    // select forUpdate + update
    ttscommit;
}
catch (Exception::UpdateConflict)
{
    if (appl.ttsLevel() == 0)
    {
        retry;
    }
    else
    {
        throw Exception::UpdateConflictNotRecovered;
    }
}
```

Sources: [Transactional integrity](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-transaction), [X++ exception handling](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-exceptions)
