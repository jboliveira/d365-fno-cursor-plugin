# F&O Extensibility Patterns

Reference templates and patterns from Microsoft Learn.

## Class CoC Template

```xpp
[ExtensionOf(classStr(SalesTable))]
final class MyPublisher_SalesTable_Extension
{
    public void insert(boolean _dropInvent)
    {
        // Pre logic
        next insert(_dropInvent);
        // Post logic
    }
}
```

## Table CoC Template

```xpp
[ExtensionOf(tableStr(CustTable))]
final class MyPublisher_CustTable_Extension
{
    public boolean validateWrite()
    {
        boolean ret = next validateWrite();
        // Additional validation
        return ret;
    }
}
```

## Form Data Source CoC

Separate extension class per nested concept:

```xpp
[ExtensionOf(formDataSourceStr(SalesTable, SalesTable))]
final class MyPublisher_SalesTableDS_Extension
{
    public void init()
    {
        next init();
    }
}
```

## Form Control CoC

```xpp
[ExtensionOf(formControlStr(SalesTable, MyButton))]
final class MyPublisher_MyButton_Extension
{
    public void clicked()
    {
        next clicked();
    }
}
```

## Replaceable Switch Default

```xpp
private Common findOrderHeader(boolean _forUpdate)
{
    switch (this.InventTransType)
    {
        case InventTransType::Sales:
            return this.salesTable(_forUpdate);
        default:
            return this.findOrderHeaderDefault(_forUpdate);
    }
}

[Replaceable]
protected Common findOrderHeaderDefault(boolean _forUpdate)
{
    throw error(Error::wrongUseOfFunction(funcName()));
}
```

## CoC Constraints

- `next` must be at first-level statements (not inside if/while/for/logical expressions)
- Wrapper signature matches base; omit default parameter values in wrapper
- Platform update 21+: `next` may appear inside try/catch/finally

## Event Handlers

- Multicast delegates; no guaranteed call order
- Execute within base method transaction scope
- Never unconditionally set `EventHandlerResult` or return values in `XppPrePostArgs`

## LCS Extensibility Request

When no extension point exists, log request in Lifecycle Services early. Intrusive overlayering is not supported.

## Links

- [Method wrapping and CoC](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/method-wrapping-coc)
- [Class extensions](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/class-extensions)
- [Intrusive customizations](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/extensibility/intrusive-customizations)
