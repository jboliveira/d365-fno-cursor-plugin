# Data Model Patterns

- Normalize; avoid redundant legacy copies
- Define indexes for frequent query paths
- Configure delete actions (Restricted, Cascade, etc.)
- Use effective date framework for temporal data
- Built-in data entities for general integration; custom entities for high-volume/low-latency
- Extend enums/EDTs without breaking IsExtensible/Extends properties

Source: [Extend F&O apps](https://learn.microsoft.com/dynamics365/guidance/implementation-guide/extend-your-solution-guidance-product-fo#extending-the-app)
