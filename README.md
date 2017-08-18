#  Arm-money token solidity contract
  
How to create contract:
1. Open Ethereum Wallet (Mist)
2. Click to "contracts tab" then Click to "deploy new contract"
3. Select account (contract owner)
4. Copy code from own-currency.sol and put to code editor
5. Select AMT c contract and set two params:
- _ex - Exchange price (1e16)
- initialCount Count of tokens (10000)

**NOTE: For set token exchange price, you need set price in wei:
Example: 
- 1 ETHER = 1 TOKEN (1e18)
- 1 ETHER = 5 TOKENS (5e18)
- 1 ETHER = 100 TOKENS (1e16)
- 1 TOKEN = 10 ETHER (1e19)