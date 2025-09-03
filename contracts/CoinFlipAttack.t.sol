// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// Author: @mcruells.dev

import {CoinFlip, CoinFlipAttack} from "./CoinFlip.sol";
import { Test } from "forge-std/Test.sol";

contract CoinFlipAttackTest is Test {

    CoinFlip coinFlip;
    CoinFlipAttack coinFlipAttack;

    function setUp() public {
        coinFlip = new CoinFlip();
        coinFlipAttack = new CoinFlipAttack(address(coinFlip));
    }

    function test_InitialConsecutiveWinsIsZero() public view {
        require(coinFlip.consecutiveWins() == 0);
    }

    function test_AttackCorrectGuessIncrementsWins() public {
        uint256 beforeAttack = coinFlip.consecutiveWins();
        coinFlipAttack.attackCoinFlip();
        uint256 afterAttack = coinFlip.consecutiveWins();
        require(afterAttack == beforeAttack + 1);
    }

    function test_FlipIncorrectGuessResetsWins() public {
        // setup one win
        coinFlipAttack.attackCoinFlip();
        require(coinFlip.consecutiveWins() > 0);

        // advance block 
        vm.roll(block.number + 1);

        // generate a wrong guess for current block
        bool correctGuess = coinFlipAttack.preCalculateFlip();
        bool wrongGuess = !correctGuess;
        coinFlip.flip(wrongGuess);

        require(coinFlip.consecutiveWins() == 0);
    }

    function test_FlipRevertsOnSameBlockHash() public {
        coinFlipAttack.attackCoinFlip();
        bool reverted = false;

        try coinFlipAttack.attackCoinFlip() {
        } catch {
            reverted = true;
        }
        require(reverted);
    }

    function test_MultipleCorrectGuessesIncreaseWins() public {
        for (uint256 i = 0; i < 3; i++) {
            coinFlipAttack.attackCoinFlip();
            vm.roll(block.number + 1);
        }
        require(coinFlip.consecutiveWins() == 3);
    }

    function test_ConsecutiveWinsResetAfterIncorrectGuess() public {
        for (uint256 i = 0; i < 3; i++) {
            coinFlipAttack.attackCoinFlip();
            vm.roll(block.number + 1);
        }
        require(coinFlip.consecutiveWins() == 3);
        
        bool correctGuess = coinFlipAttack.preCalculateFlip();
        bool wrongGuess = !correctGuess;
        coinFlip.flip(wrongGuess);

        require(coinFlip.consecutiveWins() == 0);
    }

    function test_AddressIsChanged() public { 
        CoinFlip newCoinFlip = new CoinFlip();
        coinFlipAttack.changeTarget(address(newCoinFlip));

        require(address(coinFlipAttack.coinFlip()) != address(coinFlip));
    }
}