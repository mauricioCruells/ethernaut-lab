import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CoinFlipAttackModule = buildModule("CoinFlipAttackModule", (m) => {
    const coinFlipAddress = process.env.COINFLIP_ADDRESS;

    let coinFlip;
    if (coinFlipAddress) {
        coinFlip = m.contractAt("CoinFlip", coinFlipAddress);
    } else {
        coinFlip = m.contract("CoinFlip");
    }
    const coinFlipAttack = m.contract("CoinFlipAttack", [coinFlip]);

    return {coinFlipAttack}

    }
);

export default CoinFlipAttackModule;