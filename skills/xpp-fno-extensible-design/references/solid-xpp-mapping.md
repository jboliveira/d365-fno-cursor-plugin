# SOLID to X++ Mapping

| Principle | F&O Application |
|-----------|-----------------|
| Single responsibility | Methods 5–10 lines; ≤2 params; every public/protected method is an extension point |
| Open/closed | Minimize surface: private > internal > protected > public; open by demand |
| Liskov substitution | `[Replaceable]` methods, SysExtension factories, derived classes substitutable for base |
| Interface segregation | Small focused interfaces/contracts for replacement implementations |
| Dependency inversion | Depend on abstractions (SysExtension, interfaces) not concrete classes |
| DRY | No duplicated logic across extension points extenders might partially override |
| Clean code | Methods read like headings; extract blocks into named extensible methods |

## Microsoft Example

```xpp
public void processOrder(SalesOrder _salesOrder)
{
    if (this.approveOrder(_salesOrder))
        this.confirmOrder(_salesOrder);
    else
        this.rejectOrder(_salesOrder);
}
```

Each step is overridable via CoC on protected methods.

Source: [Write extensible code](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/writing-extensible-code)
