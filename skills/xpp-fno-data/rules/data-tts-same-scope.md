---
title: TTS Same Scope
impact: CRITICAL
impactDescription: ttsLevel check rejects updates outside select-forUpdate transaction scope
tags: data, tts, transaction
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-ref/xpp-data/xpp-transaction
---

## TTS Same Scope

Update/delete in same TTS scope as forUpdate select.

**Incorrect:**
```xpp
ttsBegin;
select forUpdate custTable;
ttsCommit;

ttsBegin;
custTable.update(); // Rejected by ttsLevel check
ttsCommit;
```

**Correct:**
```xpp
ttsBegin;
select forUpdate custTable where custTable.AccountNum == _accountNum;
custTable.CreditMax = 5000;
custTable.update();
ttsCommit;
```
