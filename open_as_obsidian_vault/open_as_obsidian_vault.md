### Overview

This bash script opens a given folder as an Obsidian vault (even though it wasn't previously opened with Obsidian).

```sh
open_as_obsidian_vault.sh <folder_path>
```

### Pre-requisites

1. Python3 installed and available
2. Script is made executable (and ideally in the path so that it is accessible)
```
chmod +x open_as_obsidian_vault.sh
```

### What does it do

1. Closes running Obsidian
2. Updates the Obsidian config file `$HOME/Library/Application Support/obsidian/obsidian.json` and includes the new path supplied as a parameter if it already isn't existing
3. Creates the `.obsidian` folder in the supplied folder
4. Opens Obsidian with the supplied folder

