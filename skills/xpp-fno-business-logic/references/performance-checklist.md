# Performance Checklist

- Set-based SQL over row-by-row loops
- Joins over nested while-select (N+1)
- Appropriate table caching and temp tables
- Minimize variable scope/lifetime
- Trace Parser for hot paths
- Async framework for long-running UI operations where applicable

Source: [Apply basic performance optimization](https://learn.microsoft.com/training/modules/apply-basic-performance-optimization-finance-operations/)
