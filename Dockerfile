# Use Node.js 18 with Alpine Linux as the base image
# Alpine is a minimal Linux distribution, resulting in smaller image sizes
FROM node:18-alpine AS base

# Set the working directory inside the container to /app
# All subsequent commands will be executed in this directory
WORKDIR /app

# Copy package.json and package-lock.json files first
# This allows Docker to cache the npm install layer if dependencies haven't changed
COPY package*.json package-lock*.json ./

# Install only production dependencies (no dev dependencies)
# npm ci does a clean install based on the lock file, ensuring consistent builds
RUN npm ci --omit=dev

# Copy the rest of the application code into the container
# This includes index.js and any other application files
COPY . .

# Switch to the 'node' user (non-root) for security
# Running as a non-root user reduces security risks
USER node

# Expose port 3000 to allow external access to the application
# This is the port our Express app listens on
EXPOSE 3000

# Set the NODE_ENV environment variable to 'production'
# This optimizes Node.js performance and disables development features
ENV NODE_ENV=production

# Define the command to run when the container starts
# This executes 'npm start' which runs 'node index.js'
CMD [ "npm", "start" ]