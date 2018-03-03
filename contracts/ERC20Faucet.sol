pragma solidity 0.4.18;

import "./SafeMath.sol";

contract ERC20TokenInterface {
    function totalSupply() constant public returns (uint256 supply);
    function balanceOf(address _owner) constant public returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function approve(address _spender, uint256 _value) public returns (bool success);
    function allowance(address _owner, address _spender) constant public returns (uint256 remaining);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ERC20Faucet {
    using SafeMath for uint256;

    uint256 public maxAllowanceInclusive;
    mapping (address => uint256) public claimedTokens;
    ERC20TokenInterface public erc20Contract;
    bool public isPaused = false;
    
    address private mOwner; 
    bool private mReentrancyLock = false;
    
    event GetTokens(address requestor, uint256 amount);
    event ReclaimTokens(address owner, uint256 tokenAmount);
    event SetPause(address setter, bool newState, bool oldState);
    event SetMaxAllowance(address setter, uint256 newState, uint256 oldState);
    
    modifier notPaused() {
        require(!isPaused);
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == mOwner);
        _;
    }
    
    modifier nonReentrant() {
        require(!mReentrancyLock);
        mReentrancyLock = true;
        _;
        mReentrancyLock = false;
    }
    
    function ERC20Faucet(ERC20TokenInterface _erc20ContractAddress, uint256 _maxAllowanceInclusive) public {
        mOwner = msg.sender;
        maxAllowanceInclusive = _maxAllowanceInclusive;
        erc20Contract = _erc20ContractAddress;
    }
    
    function getTokens(uint256 amount) notPaused nonReentrant public returns (bool) {
        require(claimedTokens[msg.sender].add(amount) <= maxAllowanceInclusive);
        require(erc20Contract.balanceOf(this) >= amount);
        
        claimedTokens[msg.sender] = claimedTokens[msg.sender].add(amount);

        if (!erc20Contract.transfer(msg.sender, amount)) {
            claimedTokens[msg.sender] = claimedTokens[msg.sender].sub(amount);
            return false;
        }
        
        GetTokens(msg.sender, amount);
        return true;
    }
    
    function setMaxAllowance(uint256 _maxAllowanceInclusive) onlyOwner nonReentrant public {
        SetMaxAllowance(msg.sender, _maxAllowanceInclusive, maxAllowanceInclusive);
        maxAllowanceInclusive = _maxAllowanceInclusive;
    }
    
    function reclaimTokens() onlyOwner nonReentrant public returns (bool) {
        uint256 tokenBalance = erc20Contract.balanceOf(this);
        if (!erc20Contract.transfer(msg.sender, tokenBalance)) {
            return false;
        }

        ReclaimTokens(msg.sender, tokenBalance);
        return true;
    }
    
    function setPause(bool _isPaused) onlyOwner nonReentrant public {
        SetPause(msg.sender, _isPaused, isPaused);
        isPaused = _isPaused;
    }
}
