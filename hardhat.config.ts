import { configVariable, type HardhatUserConfig } from "hardhat/config";
import hardhatIgnitionViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";
import hardhatKeystore from "@nomicfoundation/hardhat-keystore";
import hardhatVerify from "@nomicfoundation/hardhat-verify";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.28",
  },
  plugins:[
    hardhatIgnitionViemPlugin,
    hardhatKeystore,
    hardhatVerify,
  ],
  networks: {
    hardhat: {
      type: "edr-simulated",
      chainId: 1337,
    },
    sepolia: {
      type: "http",
      url: `https://sepolia.infura.io/v3/${configVariable("INFURA_API_KEY")}`,
      accounts: [configVariable("SEPOLIA_PRIVATE_KEY")]
    }
  },
  verify: {
    etherscan: {    
      apiKey: configVariable("ETHERSCAN_API_KEY"),
    },
  }
};

export default config;
