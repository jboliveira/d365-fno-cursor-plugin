---
title: Liskov Replaceable Specialization
impact: HIGH
impactDescription: Replaceable methods and factories enable safe specialization
tags: design, solid, liskov, replaceable
microsoftDocs: https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/writing-extensible-code
---

## Liskov Replaceable Specialization

Use `[Replaceable]` and factories instead of blocking switch defaults.

**Incorrect:**
```xpp
switch (_type)
{
    case Type::A: return this.handleA();
    default: throw error("Unsupported"); // Blocks extension
}
```

**Correct:**
```xpp
switch (_type)
{
    case Type::A: return this.handleA();
    default: return this.handleDefault(_type);
}

[Replaceable]
protected boolean handleDefault(Type _type)
{
    throw error(Error::wrongUseOfFunction(funcName()));
}
```
