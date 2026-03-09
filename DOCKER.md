# Ultra-Chat Relay - Docker Setup

Ultra-Chat Relay with `--dangerously-skip-permissions` enabled and banners disabled.

## Quick Start

```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down
```

## Access

- **Direct**: http://localhost:3002
- **Projects**: http://localhost:3002/p/ubuntu/, /p/projects/, /p/hscheema1979/, /p/myhealthteam/

## Workspaces

The following workspaces are mounted inside the container:
- `/workspace/ubuntu` → `/home/ubuntu`
- `/workspace/projects` → `/home/ubuntu/projects`
- `/workspace/hscheema1979` → `/home/ubuntu/hscheema1979`
- `/workspace/myhealthteam` → `/home/ubuntu/hscheema1979/myhealthteam`

## Configuration

Edit `config/daemon.json` to add/remove workspaces:

```json
{
  "port": 3002,
  "dangerouslySkipPermissions": true,
  "projects": [
    {
      "path": "/workspace/your-project",
      "slug": "your-slug",
      "addedAt": 1772392647820
    }
  ]
}
```

Then restart: `docker-compose restart`

## Features

- ✅ `--dangerously-skip-permissions` enabled by default
- ✅ No update banners or notifications
- ✅ Auto-restart on failure
- ✅ Health monitoring
- ✅ All workspaces mounted
- ✅ Configuration persisted in `./config/`

## Docker Management

```bash
# Start
docker-compose up -d

# Stop
docker-compose down

# Restart
docker-compose restart

# View logs
docker-compose logs -f

# Check status
docker-compose ps

# Rebuild
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## Adding New Workspaces

1. Add the volume mount to `docker-compose.yml`:
   ```yaml
   volumes:
     - /path/to/project:/workspace/new-project:rw
   ```

2. Add the project to `config/daemon.json`:
   ```json
   {
     "path": "/workspace/new-project",
     "slug": "new-project",
     "addedAt": 1772392647820
   }
   ```

3. Restart: `docker-compose restart`

## Troubleshooting

**Relay not accessible:**
```bash
docker-compose logs
curl http://localhost:3002/info
```

**Workspace not accessible:**
```bash
# Inside container
docker-compose exec ultra-chat-relay ls -la /workspace/
```

**Port conflict:**
Edit `docker-compose.yml` to change port:
```yaml
ports:
  - "3003:3002"  # Use port 3003 instead
```

## Architecture

```
Docker Container (port 3002)
├── /relay (relay code)
├── /data/.claude-relay (config)
└── /workspace/ (mounted workspaces)
    ├── ubuntu
    ├── projects
    ├── hscheema1979
    └── myhealthteam
```

## Security Notes

- The relay runs without permission prompts
- Only expose through nginx with authentication
- Keep the container updated
- Use firewall rules to restrict access
