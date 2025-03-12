# BitPredict - Decentralized Bitcoin Prediction Markets

[![Built with Clarity](https://img.shields.io/badge/Built%20with-Clarity-blue.svg)](https://clarity-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

BitPredict is a trustless prediction market protocol enabling decentralized speculation on Bitcoin price movements, secured by Stacks L2 and Clarity smart contracts.

## Table of Contents

- [Key Features](#key-features)
- [Technical Architecture](#technical-architecture)
- [Smart Contract Functions](#smart-contract-functions)
- [Core Mechanisms](#core-mechanisms)
- [Error Codes](#error-codes)
- [Usage Guide](#usage-guide)
- [Security Model](#security-model)
- [Installation & Deployment](#installation--deployment)
- [Testing](#testing)
- [License](#license)

## Key Features

### Prediction Market Engine

- 🕒 Time-bound markets with configurable duration
- ⚖️ Dual outcome system (UP/DOWN) for price direction
- 📈 Real-time stake tracking with automatic aggregation

### Protocol Infrastructure

- 🔒 Bitcoin-finalized settlements via Stacks L2
- 🧮 Dynamic payout calculations with fee deductions
- 🛡️ Oracle-protected market resolution system
- 💰 Protocol-owned liquidity pool

### Advanced Protections

- 🐋 Anti-whale participation limits
- ⚡ Sub-1 minute transaction finality
- 🔍 Fully auditable market history
- 🛑 Front-running resistant design

## Technical Architecture

### Core Data Structures

```clarity
;; Prediction Market
{
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool
}

;; User Prediction
{
    prediction: (string-ascii 4),  ;; "up" or "down"
    stake: uint,
    claimed: bool
}
```

### System Constants

| Parameter        | Initial Value  | Description                  |
| ---------------- | -------------- | ---------------------------- |
| `contract-owner` | Deployer       | Administrative principal     |
| `minimum-stake`  | 1,000,000 μSTX | Minimum participation amount |
| `fee-percentage` | 2%             | Protocol revenue share       |
| `oracle-address` | Set on deploy  | Price resolution authority   |

## Smart Contract Functions

### Market Operations

| Function          | Parameters                            | Description                           |
| ----------------- | ------------------------------------- | ------------------------------------- |
| `create-market`   | (start-price, start-block, end-block) | Admin-only market creation            |
| `make-prediction` | (market-id, direction, amount)        | Stake participation in active market  |
| `resolve-market`  | (market-id, end-price)                | Oracle-only market resolution         |
| `claim-winnings`  | (market-id)                           | Collect rewards from resolved markets |

### Administrative Controls

| Function             | Parameters  | Description                       |
| -------------------- | ----------- | --------------------------------- |
| `set-oracle-address` | new-address | Update resolution authority       |
| `set-minimum-stake`  | new-minimum | Adjust participation threshold    |
| `set-fee-percentage` | new-fee     | Modify protocol fee (0-100%)      |
| `withdraw-fees`      | amount      | Collect accumulated protocol fees |

### View Functions

| Function               | Parameters        | Returns                  |
| ---------------------- | ----------------- | ------------------------ |
| `get-market`           | market-id         | Market details           |
| `get-user-prediction`  | (market-id, user) | Individual position data |
| `get-contract-balance` | -                 | Current STX holdings     |

## Core Mechanisms

### Market Lifecycle

1. **Creation**: Admin defines start price/block and duration
2. **Participation**: Users stake on UP/DOWN outcomes
3. **Resolution**: Oracle provides final price after end block
4. **Settlement**: Winners claim proportional rewards

### Payout Calculation

```python
total_stake = up_stake + down_stake
winning_pool = up_stake if price_up else down_stake
raw_winnings = (user_stake * total_stake) / winning_pool
final_payout = raw_winnings - (raw_winnings * fee_percent)
```

### Oracle Requirements

1. Must call `resolve-market` after market's end block
2. Must provide valid price > 0
3. Requires authorized principal status

## Error Codes

| Code | Constant                 | Description                     |
| ---- | ------------------------ | ------------------------------- |
| u100 | err-owner-only           | Unauthorized admin action       |
| u101 | err-not-found            | Missing market/user prediction  |
| u102 | err-invalid-prediction   | Invalid direction (non up/down) |
| u103 | err-market-closed        | Market inactive or unresolved   |
| u104 | err-already-claimed      | Duplicate reward claim          |
| u105 | err-insufficient-balance | Insufficient STX balance        |
| u106 | err-invalid-parameter    | Invalid input value             |

## Usage Guide

### Market Creation (Admin)

```clarity
(create-market u50000 u102500 u103000)  ;; $50k start, blocks 102500-103000
```

### Making a Prediction

```clarity
(make-prediction u0 "up" u1500000)  ;; 1.5 STX on market 0 UP
```

### Market Resolution (Oracle)

```clarity
(resolve-market u0 u52000)  ;; Set $52k as final price
```

### Claiming Winnings

```clarity
(claim-winnings u0)  ;; Collect rewards if prediction correct
```

## Security Model

### Assurance Features

- **Bitcoin Anchoring**: All transactions settled on Bitcoin L1
- **Clarity Safeties**: Static analysis prevents reentrancy/overflow
- **Oracle Protection**: Resolution restricted to authorized address
- **Fund Isolation**: User stakes held in contract escrow

### Risk Considerations

1. Oracle reliability critical for fair resolution
2. STX price volatility affects stake values
3. Smart contract upgrade limitations

## Installation & Deployment

### Requirements

- Clarinet v0.30.0+
- Stacks.js SDK
- Node.js v16+

### Deployment Steps

1. Clone repository
2. Install dependencies: `npm install`
3. Run tests: `npm run test`
4. Deploy: `clarinet deployments --network mainnet`
