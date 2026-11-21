#!/bin/sh
# Add the three Since98 MCP servers to Claude Code.
# Add --scope user to use them in every project.
claude mcp add --transport http since98-address https://since98.vn/api/mcp/address
claude mcp add --transport http since98-payroll https://since98.vn/api/mcp/payroll
claude mcp add --transport http since98-zalo https://since98.vn/api/mcp/zalo
