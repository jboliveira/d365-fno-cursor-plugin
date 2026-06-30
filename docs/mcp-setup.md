# Optional MCP configuration

The xpp-fno plugin does **not** bundle MCP servers. Agents reference **user-microsoft-learn** when official Microsoft F&O documentation is needed.

## Setup

1. Copy [`mcp.template.json`](../mcp.template.json) to your Cursor user MCP config, or
2. Enable **Microsoft Learn MCP** in Cursor **Settings → MCP** as `user-microsoft-learn`.

The template configures the official Learn MCP endpoint:

```json
{
  "mcpServers": {
    "user-microsoft-learn": {
      "url": "https://learn.microsoft.com/api/mcp"
    }
  }
}
```

Without MCP, agents rely on skill reference docs and embedded Microsoft doc links.

See [Getting started — Prerequisites](getting-started.md#prerequisites).
