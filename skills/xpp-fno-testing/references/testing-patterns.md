# Testing Patterns

## SysTest Skeleton

```xpp
[SysTestTransaction(TestTransactionMode::AutoRollback)]
class MyPub_OrderServiceTest extends SysTestCase
{
    [SysTestMethod]
    public void createOrder_validInput_succeeds()
    {
        // Arrange, Act, Assert
    }
}
```

## Isolation Modes

| Mode | Use |
|------|-----|
| AutoRollback | Default; best isolation |
| LegacyRollback | Concurrency/user connection tests |
| None | Debugging only |

## ATL Example

```xpp
var salesOrder = data.sales().salesOrders().createDefault();
var salesLine = salesOrder.addLine().setItem(item).setQuantity(10).save();
```

Never run tests on production systems.

Sources: [Testing support](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/perf-test/testing-support), [ATL best practices](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/perf-test/atl-best-practices)
