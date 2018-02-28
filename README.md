# erc20faucet-contracts

Smart contract that holds an ERC20 token and provides `getTokens` method to claim free tokens.



### Constructors
1. `_erc20ContractAddress`: The address of the ERC20 token the faucet holds.

2. `_maxAllowanceInclusive`: The maximum amount (inclusive) allowed to claim.  This can be changed later via `setMaxAllowance`.



### Example

##### TRST faucet on Rinkeby
- This smart contract is deployed at https://rinkeby.etherscan.io/address/0x9bc14c55139501643b62d49c9e8def17029ad418#code
- To claim free TRST, copy and paste ./scripts/getTokens.js into the Chrome's console that is connected to metamask on Rinkeby.
