// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFConsumerBaseV2Plus} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";

/**
 * @title A sample Raffle contract
 * @notice This contract is for creating a sample raffle
 * @dev Implementations Chainlink VRFv2.5
 */

contract Raffle is VRFConsumerBaseV2Plus {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle();


    uint256 private immutable i_entranceFee;
    // @dev The duration of lottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 s_lastTimeStamp;

    /* Events */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval, address vrfCoordinator) VRFConsumerBaseV2Plus(vrfCoordinator) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
        s_vrfCoordinator.requestRandomWords();
    }

    function enterRaffle() public payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH sent!");
        // require(msg.value >= i_entranceFee, SendMoreToEnterRaffle()); 
        if(msg.value <= i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));
        // Makes migration easier
        // Makes frond end "indexing" easier
        emit RaffleEntered(msg.sender);
    }

    // 1. Get a random number
    // 2. Use random nuber to pick a player
    // 3. Be automatically called
    function pickWinner() external {
        // check to see if enough time has passed


        // 1000 - 900 = 100, 200
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }

        // Get our random number 2.5
        // 1. Request RNG
        // 2. Get RNG
        // requestId = s_vrfCoordinator.requestRandomWords(
        //     VRFV2PlusClient.RandomWordsRequest({
        //         keyHash: s_keyHash,
        //         subId: s_subscriptionId,
        //         requestConfirmations: requestConfirmations,
        //         callbackGasLimit: callbackGasLimit,
        //         numWords: numWords,
        //         extraArgs: VRFV2PlusClient._argsToBytes(
        //             // Set nativepayment to true to pay for VRF requests with Sepolia ETH instead
        //             VRFV2PlusClient.ExtraAngsV1({nativepayment: false})
        //         )
        //     })            
        // );

        // s_rollers[requestId] = roller;
        // s_results[rolller] = ROLL_IN_PROGRESS;
        // emit DiceRolled(requestId, roller);
    }

    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override {}

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
