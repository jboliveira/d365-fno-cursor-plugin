# Batch and SysOperation Patterns

## SysOperation (Preferred for New Code)

Use `SysOperationServiceController` over `RunBaseBatch` for new batch/services.

## Batch Best Practices

- Short TTS per iteration; idempotent operations
- Checkpoints for resumption after failure
- ≤1000 tasks per job; decompose larger workloads
- Version batch parameter lists for backward compatibility
- Retry-safe; transactional integrity

## Server-Bound Batch

Override `runsImpersonated()` returning true when using RunBaseBatch patterns.

Source: [Create a batch class](https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/sysadmin/create-batch-class)
