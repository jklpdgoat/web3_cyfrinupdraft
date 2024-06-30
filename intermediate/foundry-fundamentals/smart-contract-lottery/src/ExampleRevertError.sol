// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ExampleRevertError {
    error ExampleRevertError__Error();

    function revertWithError() public pure {
        if(false) {
            revert ExampleRevertError__Error();
        }
    }

    function revertWithRequire() public pure {
        require(true, "ExampleRevert__Error");
    }
}
