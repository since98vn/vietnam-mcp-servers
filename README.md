# Vietnam MCP servers by Since98

**Free remote MCP servers and REST APIs for working with Vietnam: post-2025 addresses, payroll and personal income tax, and Zalo business messaging prices and rules.**

No API key. No sign-up. Read-only. Every answer carries the data version, the official source and the act or page it comes from.

| Server | MCP endpoint (Streamable HTTP) | REST API | Tools |
|---|---|---|---|
| **Vietnam Address Converter (2025 reform)** | `https://since98.vn/api/mcp/address` | `https://since98.vn/api/v1/address/` | 7 |
| **Vietnam Payroll and Tax Calculator** | `https://since98.vn/api/mcp/payroll` | `https://since98.vn/api/v1/payroll/` | 9 |
| **Zalo Business Reference (ZBS Template Message, OA)** | `https://since98.vn/api/mcp/zalo` | `https://since98.vn/api/v1/zalo/` | 7 |

Add a URL to your AI assistant and ask in plain words:

> *"My customer list still has 'Phường Phú Cường, TP Thủ Dầu Một, Bình Dương'. What is the address now?"*
> *"Gross salary 30,000,000 VND in Region I with one dependant: what is the net pay in November 2026?"*
> *"What do 10,000 ZNS order updates with a website button cost?"*

This repository holds the documentation, client configs, request examples and registry metadata. The servers run on [since98.vn](https://since98.vn); there is no code to install.

---

## Contents

- [The servers and their tools](#the-servers-and-their-tools)
- [Connect a client](#connect-a-client)
- [REST examples](#rest-examples)
- [Data sources and versions](#data-sources-and-versions)
- [Limits and larger volumes](#limits-and-larger-volumes)
- [Privacy](#privacy)
- [Disclaimers](#disclaimers)
- [Reporting a data error](#reporting-a-data-error)
- [About Since98](#about-since98)
- [Tiếng Việt](#tiếng-việt)

---

## The servers and their tools

All tools are read-only (`readOnlyHint: true`, `destructiveHint: false`) and have a title. The lists below match `tools/list` on the live servers.

### 1. Vietnam Address Converter (2025 reform)

On 1 July 2025 Vietnam went from 63 provinces to 34 and abolished districts; 10,035 old communes became 3,321 new ones. This server converts addresses written the old way to the new units, using the official transition table of the National Statistics Office (Cục Thống kê). When an old commune was split, it returns every resulting unit and marks the answer as ambiguous instead of guessing.

| Tool | What it does |
|---|---|
| `convert_old_to_new` | Convert an old province, district and commune to the new units (2025 reform) |
| `normalize_address` | Rewrite a free-form address, with or without diacritics, to the new units |
| `find_units` | Find administrative units by name, old or new |
| `list_provinces` | List the 34 new or the 63 old provinces |
| `list_wards` | List the communes of a province |
| `explain_merge` | Explain how a new unit was formed and which resolution did it |
| `data_info` | Dataset version, source file checksum and the resolutions used |

Web tool: [Vietnam address converter](https://since98.vn/tools/vietnam-address-converter) · [Vietnamese version](https://since98.vn/vi/cong-cu/chuyen-doi-dia-chi-sau-sap-nhap) · [API and MCP docs](https://since98.vn/tools/vietnam-address-converter/api)

### 2. Vietnam Payroll and Tax Calculator

Monthly payroll under the rules in force from 1 January 2026: social, health and unemployment insurance, personal income tax by bracket, family deductions, regional minimum wages (including the 2027 rates), the 10% withholding without a labour contract and the one-time social insurance payment. Every line is rounded to the dong, and every answer lists the act numbers behind the figures.

| Tool | What it does |
|---|---|
| `gross_to_net` | Gross to net salary, with every insurance line and the tax by bracket |
| `net_to_gross` | The gross salary needed for a target net pay |
| `pit_only` | Personal income tax by bracket for a taxable income |
| `employer_cost` | What a salary costs the employer, with each contribution |
| `minimum_wage` | Regional minimum wage (Regions I–IV) for a date |
| `withholding_10pct` | 10% tax withholding for payments without a labour contract |
| `bhxh_lump_sum` | One-time social insurance payment (BHXH một lần) |
| `amount_in_words` | An amount in words, in Vietnamese and English, for invoices and contracts |
| `data_info` | Parameters, acts and the dates they cover |

Web tools: [Salary calculator](https://since98.vn/tools/vietnam-salary-calculator) · [Vietnamese version](https://since98.vn/vi/cong-cu/tinh-luong-gross-net) · [Number to words](https://since98.vn/tools/vietnamese-number-to-words) · [API and MCP docs](https://since98.vn/tools/vietnam-salary-calculator/api)

### 3. Zalo Business Reference (ZBS Template Message, OA)

Prices and rules for businesses that message customers on Zalo: ZBS Template Message (formerly ZNS) prices by template type, buttons and delivery, Official Account plans, formal checks of a template draft, sending windows and quotas, and Zalo error codes. Figures Zalo does not publish come back as `null` with a status; they are never guessed. Nothing is sent to Zalo, and no tokens or phone numbers are accepted.

| Tool | What it does |
|---|---|
| `estimate_message_cost` | Price per ZBS template message and the total for a campaign, with a line breakdown |
| `oa_plan_compare` | Compare Zalo OA plans and pick the smallest one that fits |
| `validate_template` | Check a template draft against Zalo's published formal rules |
| `check_sending_rules` | Sending window by tag, daily quota and promotion limits |
| `choose_channel` | Which Zalo channel fits a task: template message, free reply, broadcast or Mini App |
| `error_lookup` | Explain a Zalo error code and what to check |
| `data_info` | Sources, figures Zalo does not publish, and where Zalo's own pages disagree |

Web tool: [Zalo ZNS cost calculator](https://since98.vn/tools/zalo-zns-cost-calculator) · [Vietnamese version](https://since98.vn/vi/cong-cu/tinh-chi-phi-zns) · [API and MCP docs](https://since98.vn/tools/zalo-zns-cost-calculator/api)

---

## Connect a client

The servers use Streamable HTTP, are stateless, and need no authentication or headers. Replace the URL with the server you want; you can add all three. Ready-made files are in [`examples/`](examples/).

### Claude (web and desktop)

1. Open **Customize → Connectors**, choose **+ Add → Add custom connector**. On Team and Enterprise plans, an owner adds it in **Organization settings → Connectors**.
2. Enter a name, for example *Vietnam payroll*, and the URL `https://since98.vn/api/mcp/payroll`.
3. Choose **No sign in** and click **Add**.

Free plans can add one custom connector. Source: [Claude Help Center](https://support.claude.com/en/articles/11175166-getting-started-with-custom-connectors-using-remote-mcp).

### Claude Code

```sh
claude mcp add --transport http since98-address https://since98.vn/api/mcp/address
claude mcp add --transport http since98-payroll https://since98.vn/api/mcp/payroll
claude mcp add --transport http since98-zalo https://since98.vn/api/mcp/zalo
```

Add `--scope user` to use them in every project, or commit [`examples/claude-code.mcp.json`](examples/claude-code.mcp.json) as `.mcp.json` to share them with your team. Check with `/mcp` inside a session. Source: [Claude Code docs](https://code.claude.com/docs/en/mcp).

### Cursor

Put this in `~/.cursor/mcp.json` (all projects) or `.cursor/mcp.json` (one project):

```json
{
  "mcpServers": {
    "since98-address": { "url": "https://since98.vn/api/mcp/address" },
    "since98-payroll": { "url": "https://since98.vn/api/mcp/payroll" },
    "since98-zalo": { "url": "https://since98.vn/api/mcp/zalo" }
  }
}
```

Source: [Cursor docs](https://cursor.com/docs/context/mcp).

### VS Code (GitHub Copilot)

Run **MCP: Add Server** from the Command Palette, choose **HTTP**, paste the URL and give it an ID. Or add the servers to the Copilot configuration (`~/.copilot/mcp-config.json`, or `.mcp.json` at the workspace root):

```json
{
  "mcpServers": {
    "since98-address": { "type": "http", "url": "https://since98.vn/api/mcp/address" },
    "since98-payroll": { "type": "http", "url": "https://since98.vn/api/mcp/payroll" },
    "since98-zalo": { "type": "http", "url": "https://since98.vn/api/mcp/zalo" }
  }
}
```

Older setups that still use `.vscode/mcp.json` take the same entries under a `servers` key: see [`examples/vscode.mcp.json`](examples/vscode.mcp.json). Source: [VS Code docs](https://code.visualstudio.com/docs/copilot/customization/mcp-servers).

### ChatGPT

On chatgpt.com, open the plugins page, choose **+ → Add custom MCP server**, paste the server URL and choose **No authentication**. Availability depends on your plan and workspace settings. Source: [OpenAI docs](https://developers.openai.com/api/docs/guides/custom-mcp-server.md).

### Any other MCP client

Add a remote MCP server by URL. Transport: Streamable HTTP. No key, no OAuth, no headers. Protocol versions from 2024-11-05 to 2026-07-28 are accepted.

### Try it without a client

```sh
curl -s https://since98.vn/api/mcp/payroll \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -H 'mcp-protocol-version: 2025-06-18' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"gross_to_net","arguments":{"gross":30000000,"region":"I","dependents":1}}}'
```

---

## REST examples

Each API also publishes an OpenAPI 3.1 document: [`address`](https://since98.vn/api/v1/address/openapi.json), [`payroll`](https://since98.vn/api/v1/payroll/openapi.json), [`zalo`](https://since98.vn/api/v1/zalo/openapi.json). Endpoints that take text a person typed, or a salary, also accept POST: the body stays out of URLs and server logs. More in [`examples/rest.sh`](examples/rest.sh).

**Rewrite an old address** (POST keeps the address out of logs):

```sh
curl -s https://since98.vn/api/v1/address/normalize \
  -H 'content-type: application/json' \
  -d '{"address":"123 Le Loi, Phuong Ben Thanh, Quan 1, TP Ho Chi Minh"}'
```

```json
{"status":"converted","ambiguous":false,"confidence":"high","address":"123 Le Loi, Phường Bến Thành, Thành phố Hồ Chí Minh", ...}
```

**Convert an old commune:**

```sh
curl -s "https://since98.vn/api/v1/address/convert?province=Binh%20Duong&district=Thu%20Dau%20Mot&ward=Phu%20Cuong"
```

Returns *Phường Thủ Dầu Một, Thành phố Hồ Chí Minh*, with the resolution number.

**Gross to net:**

```sh
curl -s https://since98.vn/api/v1/payroll/gross-to-net \
  -H 'content-type: application/json' \
  -d '{"gross":30000000,"region":"I","dependents":1,"month":"2026-11"}'
```

```json
{"as_of":"2026-11-01","region":"I","gross":30000000,"net":26592500,"employee_contributions":{...,"total":3150000},"pit":{...,"tax":257500}, ...}
```

**Regional minimum wage from 2027:**

```sh
curl -s "https://since98.vn/api/v1/payroll/minimum-wage?region=I&month=2027-01"
```

**ZBS template message cost:**

```sh
curl -s "https://since98.vn/api/v1/zalo/message-cost?template_type=custom&buttons=business_website&count=10000"
```

Returns 400 VND per message (300 for the template, 100 for the website button) and 4,000,000 VND for 10,000 delivered messages, excluding VAT.

**Zalo error code:**

```sh
curl -s "https://since98.vn/api/v1/zalo/errors?code=-133"
```

**Check a template draft** (POST only):

```sh
curl -s https://since98.vn/api/v1/zalo/validate-template \
  -H 'content-type: application/json' \
  -d '{"template_type":"custom","tag":1,"title":"Order <order_code> confirmed","paragraphs":["Hello <customer_name>, your order <order_code> is on its way."]}'
```

The examples above were run against the live APIs on 2026-11-21. Figures change when the law or Zalo's prices change; check `data_version` in each answer.

---

## Data sources and versions

| Server | Data version | Source |
|---|---|---|
| Address | `2026.11.20` | Official administrative-unit transition table of the National Statistics Office of Viet Nam (Cục Thống kê, Ministry of Finance), [danhmuchanhchinh.nso.gov.vn](https://danhmuchanhchinh.nso.gov.vn/), retrieved 2026-11-20, plus the resolutions of the National Assembly Standing Committee on the 2025 reorganisation and the changes of 2026. Counts: 34 provinces and 3,321 communes now; 63 provinces, 696 districts and 10,035 communes before. |
| Payroll | `2026.11.21` | Laws, decrees and circulars as published on congbao.chinhphu.vn and vanban.chinhphu.vn, among them the Personal Income Tax Law 109/2025/QH15, Resolution 110/2025/UBTVQH15 on family deductions, the Social Insurance Law 41/2024/QH15, the Employment Law 74/2025/QH15, and Decrees 293/2025/ND-CP and 399/2026/ND-CP on regional minimum wages. Calculations are supported from 2026-01-01. |
| Zalo | `2026.11.21` | 36 official Zalo pages (zalo.solutions, developers.zalo.me and the price data behind Zalo's pricing page), retrieved 2026-11-21. Every record keeps its page and how it was checked. |

The `data_info` tool and the `meta` endpoint of each API return the full list of sources, checksums, act numbers and known gaps.

---

## Limits and larger volumes

Each IP address can make **60 requests per minute and 2,000 per day**, all three REST APIs and MCP servers together. Over the limit, the REST API answers `429` with a `Retry-After` header and the MCP server returns an error with the same wait time.

**Need a higher volume, bulk processing of your own database, or these tools built into your system?** Write to us at [hello@since98.vn](mailto:hello@since98.vn) or through [since98.vn/contact](https://since98.vn/contact).

Access stays free, without keys, at the limit above.

---

## Privacy

The application answers each request in memory and keeps no request content, such as addresses, salaries or template drafts. For the rate limit it keeps a counter per IP address in memory for one day; it also counts calls per tool and day, without IP addresses or inputs. The web server keeps standard access logs (IP address, time, full URL including the query string, user agent) for 14 days, so send text typed by people with POST. MCP requests are always POST. Requests pass through Cloudflare.

---

## Disclaimers

- **Reference only.** The payroll results are a reference calculation, not tax, legal or accounting advice. The address data is reference data: for legally significant actions, check the official resolutions. Zalo figures are as published by Zalo on the retrieval date: check the linked official page before relying on them.
- **Not affiliated with Zalo or VNG.** The Zalo reference is an independent tool. It sends nothing to Zalo.
- **Not a government service.** The address and payroll data come from official publications, but these tools are not run by any authority.

---

## Reporting a data error

Found a wrong commune, an outdated rate or a Zalo price that changed? [Open an issue](../../issues/new/choose) with the **Data error** template: what you asked, what you got, what is right, and a link to the official source. Ideas go to the **Feature request** template. See [CONTRIBUTING.md](CONTRIBUTING.md).

Security issues: see [SECURITY.md](SECURITY.md).

---

## About Since98

Since98 is an AI and software studio in Ho Chi Minh City. We build AI assistants and agents connected to Zalo OA and to the systems a business already uses, along with websites, apps and automation. These servers are tools we use in our own work and keep open for everyone.

[since98.vn](https://since98.vn) · [hello@since98.vn](mailto:hello@since98.vn)

---

## Tiếng Việt

**Máy chủ MCP và REST API miễn phí cho các công việc tại Việt Nam:** chuyển đổi địa chỉ sau sáp nhập 2025 (34 tỉnh, 3.321 xã phường), tính lương gross/net, thuế TNCN, bảo hiểm, và bảng giá, quy định ZBS Template Message (ZNS), gói Zalo OA. Không cần khóa, không cần đăng ký.

- Địa chỉ: `https://since98.vn/api/mcp/address` · [công cụ trên web](https://since98.vn/vi/cong-cu/chuyen-doi-dia-chi-sau-sap-nhap)
- Lương và thuế: `https://since98.vn/api/mcp/payroll` · [công cụ trên web](https://since98.vn/vi/cong-cu/tinh-luong-gross-net)
- Zalo: `https://since98.vn/api/mcp/zalo` · [công cụ trên web](https://since98.vn/vi/cong-cu/tinh-chi-phi-zns)

Giới hạn: 60 yêu cầu mỗi phút và 2.000 yêu cầu mỗi ngày cho một địa chỉ IP. Cần khối lượng lớn hơn, xử lý hàng loạt cơ sở dữ liệu hoặc tích hợp vào hệ thống của bạn? Hãy viết cho chúng tôi: [hello@since98.vn](mailto:hello@since98.vn).

Kết quả chỉ để tham khảo, không phải tư vấn thuế hay pháp lý. Công cụ Zalo độc lập, không liên kết với Zalo hay VNG.

---

The text and examples in this repository are under the [MIT License](LICENSE). See the license file for the data.
