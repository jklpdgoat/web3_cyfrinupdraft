// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTestIntegration is Test {
    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();

        DeployFundMe deployFundMe = new DeployFundMe();
        FundMe fundMe = deployFundMe.run();
    }
}
