import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CoinFlipModule = buildModule("CoinFlipModule", (m) => {
    const coinFlip = m.contract("coinflip");

    return { coinFlip }
    }
);

export default CoinFlipModule;