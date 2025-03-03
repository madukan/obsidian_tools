### Contents

1. [Overview](#Overview)
2. [Pre-requisites](#Pre-requisites)
3. [What does this script do?](#What%20does%20this%20script%20do?)
4. [A bit about obsidian.json](#A%20bit%20about%20obsidian.json)

### Overview

Obsidian is an excellent tool for creating technical and research documentation. However, it currently does not support opening vaults from the command line unless they have been previously opened via the UI ([discussed here](https://forum.obsidian.md/t/command-line-interface-to-open-folders-and-files-in-obsidian-from-the-terminal/860)).

This bash script ([originally shared here](https://forum.obsidian.md/t/command-line-interface-to-open-folders-and-files-in-obsidian-from-the-terminal/860/81)) offers a solution by enabling you to open any folder as an Obsidian vault, even if it hasn’t been accessed through the UI. It gives you greater control and saves the time and effort of opening the vault twice.

```sh
open_as_obsidian_vault.sh <folder_path>
```

### Pre-requisites

1. Python3 installed and available in the path (Verify by: `python3 --version`)
2. Script is made executable (and ideally in the path so that it is accessible)
```
chmod +x open_as_obsidian_vault.sh
```

### What does this script do?

1. Closes any running instance of Obsidian to ensure that configuration changes are applied when the app is reopened.
2. Updates the Obsidian configuration file (`$HOME/Library/Application Support/obsidian/obsidian.json`) to include the new folder path provided via the command-line parameter, adding it as a new entry only if it doesn't already exist.
3. Creates a `.obsidian` folder within the supplied directory. Once Obsidian is launched, it will generate the necessary metadata inside this folder.
4. Opens Obsidian with the specified folder as a vault, passing the folder path directly to Obsidian.

### A bit about obsidian.json

Obsidian configuration file (`$HOME/Library/Application Support/obsidian/obsidian.json`) has the following path. This file is updated each time Obsidian is closed. 

1. `"vaults"` tag contains all the vaults the user has opened so far if those folders still exists in the system. 
2. `"openSchemes"` tag configure the handling of special URI schemes that Obsidian can recognise and open. The `"jetbrains": true` entry specifically enables Obsidian to open links that are in the JetBrains IDE's URI scheme format (e.g., `jetbrains://...`). This setting allows you to open Obsidian from JetBrains-based IDEs like IntelliJ IDEA, WebStorm, or PyCharm by using the JetBrains-specific URL scheme.

Example `obsidian.json`:
```json
{
    "vaults": {
        "8c9934fd94a922d3": {
            "path": "/path/to/vault1",
            "ts": 1740725290904
        },
        "7569703248a60a28": {
            "path": "/path/to/vault2",
            "ts": 1740814019347
        }
    },
    "openSchemes": {
        "jetbrains": true
    }
}
```

