Litecore Node + Insight API + Insight UI in Docker
=========

To run **testnet** (the default):

`docker run -d -p 3001:3001 -p 19335:19335 -v /root/litecoin-node/testnet:/root/litecoin-node/data --name litecoin-testnet berrywallet/litecore-node`

To run for **livenet**:

`docker run -e LITECOIN_LIVENET=1 -d -p 3001:3001 -p 9333:9333 -v /root/litecoin-node/livenet:/root/litecoin-node/data --name litecoin-livenet berrywallet/litecore-node`


### Environment variables

- `LITECOIN_LIVENET` (default: 0) - Set 1 to enable livenet
- `API_ROUTE_PREFIX` (default: api) - Set URL prefix for Insight API
- `UI_ROUTE_PREFIX` (default: "") - Set URL prefix for Insight UI
- `API_CACHE_ENABLE` (default: 1) - Enable/disable Insight API cache
- `API_LIMIT_ENABLE` (default: 1) - Enable/disable Insight API rate limiter
- `API_LIMIT_WHITELIST` (default: "127.0.0.1 ::1") - Whitelist, delimited by space
- `API_LIMIT_BLACKLIST` (default: "") - Blacklist, delimited by space
- `API_LIMIT_COUNT` (default: 10800)
- `API_LIMIT_INTERVAL` (default: 10800000)
- `API_LIMIT_WHITELIST_COUNT` (default: 108000)
- `API_LIMIT_WHITELIST_INTERVAL` (default: 10800000)
- `API_LIMIT_BLACKLIST_COUNT` (default: 0)
- `API_LIMIT_BLACKLIST_INTERVAL` (default: 10800000)
