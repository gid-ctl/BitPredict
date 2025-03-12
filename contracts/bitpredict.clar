;; Title: BitPredict - Trustless Bitcoin Prediction Markets on Stacks L2
;; 
;; Summary: Decentralized Bitcoin Price Prediction Engine Secured by Stacks L2
;;
;; Description:
;; BitPredict revolutionizes price speculation through a decentralized protocol
;; built on Stacks' Bitcoin-linked blockchain. The platform enables participants
;; to stake on BTC price movements with:
;;
;; - Fully automated prediction markets with smart contract execution
;; - Sub-1 minute Bitcoin finality through Stacks L2 architecture
;; - Manipulation-resistant design using decentralized price oracles
;; - Dynamic reward distribution with fair profit sharing
;; - Protocol-owned liquidity model with sustainable fee structure
;;
;; Advanced Features:
;; 1. Clarity smart contracts ensure transparent, auditable market operations
;; 2. Bitcoin-native security with all settlements finalized on BTC blockchain
;; 3. Optimized L2 performance enabling high-frequency prediction windows
;; 4. Anti-whale mechanisms through stake-based participation limits
;; 5. Decentralized governance-ready architecture

;; Constants

;; Contract Administration
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))

;; Error Handling Standards
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; Protocol Configuration

;; Oracle Integration
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var minimum-stake uint u1000000)  ;; 1.0 STX base participation
(define-data-var fee-percentage uint u2)         ;; 2% platform fee structure
(define-data-var market-counter uint u0)