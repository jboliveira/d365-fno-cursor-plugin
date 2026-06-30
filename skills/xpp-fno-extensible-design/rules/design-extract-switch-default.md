---
title: Extract Switch Default
impact: HIGH
impactDescription: Default switch blocks with throw prevent extension
tags: design, extensible-methods, switch
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/extensible-methods
---

## Extract Switch Default

Extract default case to `[Replaceable]` method instead of inline throw.

**Incorrect:**
```xpp
switch (this.InventTransType)
{
    case InventTransType::Sales: return this.salesTable(_forUpdate);
    default: throw error(Error::wrongUseOfFunction(funcName()));
}
```

**Correct:**
```xpp
switch (this.InventTransType)
{
    case InventTransType::Sales: return this.salesTable(_forUpdate);
    default: return this.findOrderHeaderDefault(_forUpdate);
}

[Replaceable]
protected Common findOrderHeaderDefault(boolean _forUpdate)
{
    throw error(Error::wrongUseOfFunction(funcName()));
}
```
