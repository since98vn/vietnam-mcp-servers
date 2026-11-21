#!/bin/sh
# Call the Since98 MCP servers with plain HTTP (Streamable HTTP, stateless, no key).
set -e
call() {
  curl -s "https://since98.vn/api/mcp/$1" \
    -H 'content-type: application/json' \
    -H 'accept: application/json, text/event-stream' \
    -H 'mcp-protocol-version: 2025-06-18' \
    -d "$2"
  echo
}

echo "== List the tools of the address server"
call address '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'

echo "== Payroll: gross to net"
call payroll '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"gross_to_net","arguments":{"gross":30000000,"region":"I","dependents":1}}}'

echo "== Zalo: error code"
call zalo '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"error_lookup","arguments":{"code":-133}}}'
