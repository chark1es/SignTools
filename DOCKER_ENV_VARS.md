# Docker Environment Variables

SignTools now supports Docker environment variables for flexible configuration paths, making it easier to deploy in containerized environments.

## Environment Variables

### SIGNER_CONFIG_PATH
- **Purpose**: Specifies the path to the signer-cfg.yml configuration file
- **Default**: Uses the default path (signer-cfg.yml) if not set
- **Example**: `SIGNER_CONFIG_PATH=/config/my-signer-cfg.yml`

### SAVE_DIR_PATH
- **Purpose**: Specifies the directory where signed apps will be saved
- **Default**: Uses the `save_dir` value from the configuration file if not set
- **Example**: `SAVE_DIR_PATH=/data/signed-apps`

## Docker Usage Examples

### Basic Usage with Environment Variables
```bash
docker run -d \
  -e SIGNER_CONFIG_PATH=/config/signer-cfg.yml \
  -e SAVE_DIR_PATH=/data/signed-apps \
  -v /host/config:/config \
  -v /host/data:/data \
  -p 8080:8080 \
  signtools/signtools
```

### Using Custom Paths
```bash
docker run -d \
  -e SIGNER_CONFIG_PATH=/custom/path/my-config.yml \
  -e SAVE_DIR_PATH=/custom/save/directory \
  -v /host/custom:/custom \
  -p 8080:8080 \
  signtools/signtools
```

### Docker Compose Example
```yaml
version: '3.8'
services:
  signtools:
    image: signtools/signtools
    ports:
      - "8080:8080"
    environment:
      - SIGNER_CONFIG_PATH=/config/signer-cfg.yml
      - SAVE_DIR_PATH=/data/signed-apps
    volumes:
      - ./config:/config
      - ./data:/data
```

## Logging

The application now provides detailed logging for configuration and path detection:

- **Configuration file detection**: Logs which config file is being used
- **Save directory detection**: Logs which save directory is being used
- **Builder detection**: Logs which builders are detected and initialized
- **Path validation**: Logs errors if specified paths are invalid or inaccessible

## Backward Compatibility

These environment variables are completely optional. If not set:
- The application will use the default config file path (`signer-cfg.yml`)
- The save directory will use the value specified in the configuration file
- All existing deployments will continue to work without any changes

## Benefits

1. **Flexible Configuration**: Easy to customize paths for different deployment environments
2. **Container-Friendly**: Perfect for Docker, Kubernetes, and other containerized deployments
3. **Debugging Support**: Enhanced logging helps troubleshoot configuration issues
4. **Path Validation**: Early detection of configuration errors prevents runtime issues
5. **Backward Compatible**: Existing setups continue to work without modification

## Error Handling

The application validates paths and provides clear error messages:
- If `SIGNER_CONFIG_PATH` points to a non-existent file, the application will exit with an error
- If `SAVE_DIR_PATH` cannot be created or accessed, the application will exit with an error
- All errors include the problematic path in the log message for easy debugging
