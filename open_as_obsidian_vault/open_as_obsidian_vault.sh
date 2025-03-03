#!/bin/bash
# For MacOS, Opens a given folder as an Obsidian vault.
# In doing so, this script first close Obsidian, then update 
# its configuration to include the specified folder as a vault
# and then open the folder with Obsidian.

# Close Obsidian if it's running, because we need to update config file
osascript -e 'quit app "Obsidian"'
sleep 0.2  # Small delay to ensure it fully closes

# Get the Obsidian configuration path (default for macOS)
OBSIDIAN_CONFIG="$HOME/Library/Application Support/obsidian/obsidian.json"

# Check if a folder is provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/folder"
    exit 1
fi

# Resolve absolute path of the vault folder
FOLDER_PATH=$(cd "$1" && pwd)

# Ensure the folder exists
mkdir -p "$FOLDER_PATH"

# Initialize as an Obsidian vault if not already
if [ ! -d "$FOLDER_PATH/.obsidian" ]; then
    mkdir "$FOLDER_PATH/.obsidian"
    echo "Initialized new Obsidian vault at: $FOLDER_PATH"
fi

# Ensure Obsidian configuration file exists
if [ ! -f "$OBSIDIAN_CONFIG" ]; then
    echo '{}' > "$OBSIDIAN_CONFIG"
fi

# Add the new vault to Obsidian's known vaults
python3 - <<EOF
import json
import os
import hashlib
import time

config_path = "$OBSIDIAN_CONFIG"
vault_path = "$FOLDER_PATH"

try:
    # Generate a unique ID for the vault (hash of the path)
    vault_id = hashlib.md5(vault_path.encode()).hexdigest()[:16]

    # Read existing config
    with open(config_path, "r+") as f:
        config = json.load(f)

        # Ensure "vaults" section exists
        config.setdefault("vaults", {})

        # Add new vault entry if it doesn't exist
        if vault_id not in config["vaults"]:
            config["vaults"][vault_id] = {
                "path": vault_path,
                "ts": int(time.time() * 1000),  # Current timestamp in milliseconds
                "open": True
            }

            # Write updated config back
            f.seek(0)
            json.dump(config, f, indent=2)
            f.truncate()

            print(f"Added vault '{vault_path}' to Obsidian configuration.")

except Exception as e:
    print(f"Error updating config: {e}")
EOF

# Open Obsidian with the new vault
open -a "Obsidian" "$FOLDER_PATH"
