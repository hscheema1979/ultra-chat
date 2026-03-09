module.exports = {
  apps: [{
    name: "claude-relay",
    script: "lib/daemon.js",
    cwd: "/home/ubuntu/projects/claude-relay",
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: "1G",
    env: {
      NODE_ENV: "production",
      CLAUDE_RELAY_HOME: "/home/ubuntu/.claude-relay"
    }
  }]
};
