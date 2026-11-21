#!/bin/sh
# REST examples for the Since98 APIs. Free, no key; 60 requests per minute and
# 2,000 per day per IP address, REST and MCP together.
# Send text typed by people (addresses, salaries, template drafts) with POST:
# a GET query string ends up in server logs.
set -e
BASE=https://since98.vn/api/v1

echo "== Address: rewrite a free-form old address"
curl -s "$BASE/address/normalize" -H 'content-type: application/json' \
  -d '{"address":"123 Le Loi, Phuong Ben Thanh, Quan 1, TP Ho Chi Minh"}'; echo

echo "== Address: convert an old commune"
curl -s "$BASE/address/convert?province=Binh%20Duong&district=Thu%20Dau%20Mot&ward=Phu%20Cuong"; echo

echo "== Address: the 34 new provinces"
curl -s "$BASE/address/provinces?scope=new"; echo

echo "== Payroll: gross to net"
curl -s "$BASE/payroll/gross-to-net" -H 'content-type: application/json' \
  -d '{"gross":30000000,"region":"I","dependents":1,"month":"2026-11"}'; echo

echo "== Payroll: regional minimum wage from January 2027"
curl -s "$BASE/payroll/minimum-wage?region=I&month=2027-01"; echo

echo "== Zalo: cost of 10,000 template messages with a website button"
curl -s "$BASE/zalo/message-cost?template_type=custom&buttons=business_website&count=10000"; echo

echo "== Zalo: error code -133"
curl -s "$BASE/zalo/errors?code=-133"; echo

echo "== Zalo: check a template draft (POST only)"
curl -s "$BASE/zalo/validate-template" -H 'content-type: application/json' \
  -d '{"template_type":"custom","tag":1,"title":"Order <order_code> confirmed","paragraphs":["Hello <customer_name>, your order <order_code> is on its way."]}'; echo
