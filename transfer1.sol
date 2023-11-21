// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

contract Test {
    function transferFunds(address payable _address, uint256 _amount) external payable {
        require(address(this).balance >= _amount, "Insufficient balance in the contract.");
        _address.transfer(_amount);
    }
}

contract Faucet {
    address payable public testContractAddress = payable(0xD900FFb0c6e3D982aA34e479331375F3cb351179); // Replace with the contract address of the Test contract
    address payable public yourAddress;

    function setYourAddress(address payable) external {
        yourAddress = payable(0xC78fb93a84cfAfa295e8824C176F5B52654974D3);
    }

    function sendWeiToAccount() external {
        require(yourAddress != address(0), "BSC address not set.");

        Test testContract = Test(testContractAddress);

        uint256 amountToSend = 100 wei; // Amount to send (10 wei)

        testContract.transferFunds{value: amountToSend}(yourAddress, amountToSend);
    }
}