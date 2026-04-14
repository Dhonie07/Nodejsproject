FROM node:20

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy files
COPY . .

# Install dependencies
RUN pnpm install

# 🔥 BUILD ALL PACKAGES FIRST (IMPORTANT)
RUN pnpm build

# Expose correct port (Next.js uses 3000)
EXPOSE 3000

# Run only frontend (stable)
CMD ["pnpm", "dev:web"]