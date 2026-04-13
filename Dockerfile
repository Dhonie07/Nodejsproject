# Use Node 20 (required by your project)
FROM node:20

# Set working directory inside container
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy all files into container
COPY . .

# Install dependencies
RUN pnpm install

# Expose port (we’ll adjust later if needed)
EXPOSE 3000

# Start the app
CMD ["pnpm", "dev"]