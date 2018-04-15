# erc20faucet-contracts
Smart contract that holds an ERC20 token and provides `getTokens` method to claim free tokens.


### Constructors
1. `_erc20ContractAddress`: The address of the ERC20 token the faucet holds.

2. `_maxAllowanceInclusive`: The maximum amount (inclusive) allowed to claim.  This can be changed later via `setMaxAllowance`.


### Example

##### TRST faucet on Rinkeby
- This smart contract is deployed on the Rinkeby network https://rinkeby.etherscan.io/address/0x9bc14c55139501643b62d49c9e8def17029ad418#code at commit https://github.com/WeTrustPlatform/erc20faucet-contracts/commit/1686ab46efd67dccf36427d65cc2ac4ca886e3ee

##### How to get free TRST on Rinkeby Network
- Add TRST token address [0x87099add3bcc0821b5b151307c147215f839a110](https://rinkeby.etherscan.io/address/0x87099add3bcc0821b5b151307c147215f839a110) on Rinkeby to Metamask following this [handy guide](https://docs.google.com/document/d/1rnJPZBstpzyMUZ_DGDTFeXeI037eg1dpA31X7egq4Lo/edit#heading=h.nidysogysmaf).
- To claim free TRST, copy and paste `./scripts/getTokens.js` raw content into Chrome's console that is connected to Metamask on Rinkeby. The default amount to claim in the script is 1 TRST. You can change the value of `amountToClaim` in the script to the amount you want to claim but the maximum amount allowed is `_maxAllowanceInclusive`.
- Submit the transaction in the Metamask popup modal.
- The amount of claimed TRST should be displayed on Metamask once the transaction is mined on Rinkeby.


### License
[GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html)
