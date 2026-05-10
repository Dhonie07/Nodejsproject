import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  transpilePackages: ["@safe-meet/shared"],
  output: "standalone",
};

export default nextConfig;
