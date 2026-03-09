FROM node:20-slim

# Set working directory
WORKDIR /relay

# Copy relay code
COPY . /relay/

# Install dependencies
RUN npm install --production

# Create directory for relay config
RUN mkdir -p /data/.claude-relay

# Set environment variables
ENV CLAUDE_RELAY_HOME=/data/.claude-relay
ENV NODE_ENV=production

# Expose port
EXPOSE 3002

# Start relay
CMD ["node", "lib/daemon.js"]
