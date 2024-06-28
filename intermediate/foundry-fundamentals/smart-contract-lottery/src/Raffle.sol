// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title A sample Raffle contract
 */

contract Raffle {
    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }
    
    function enterRaffle() public {}

    function pickWinner() public {}

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
