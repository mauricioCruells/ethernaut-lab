import type { HardhatUserConfig } from "hardhat/config";
import hardhatIgnitionViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.28",
  },
  plugins:[hardhatIgnitionViemPlugin],
  networks: {
    hardhat: {
      type: "edr-simulated",
      chainId: 1337,
    },
  }
};

export default config;
