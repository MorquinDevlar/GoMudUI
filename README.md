# GoMudUI

A modern, feature-rich Mudlet UI package for the Official GoMud engine. This UI package enhances your GoMud gaming experience with a clean, intuitive interface and powerful functionality.

## Features

- **Modern UI Components**: Clean and intuitive interface elements for better gameplay experience
- **Customizable Settings**: Extensive configuration options to tailor the UI to your preferences
- **Event-Driven Architecture**: Efficient handling of game events and updates
- **Container Management**: Advanced container tracking and management system
- **Informational Displays**: Real-time game information and status updates
- **Self-updating**: The UI is self-updating to the newest release on Github

## Installation

### Option 1: In-Game Installation
1. Connect to GoMud
2. Type `install ui` in the game
3. Follow the on-screen prompts to complete the installation

### Option 2: Manual Package Installation
1. Download the latest `.mpackage` file from the [releases page](https://github.com/yourusername/GoMudUI/releases)
2. Open Mudlet
3. Go to Settings → Package Manager
4. Click "Import" and select the downloaded `.mpackage` file
5. Restart Mudlet to ensure all components are properly loaded

### Option 3: Building from Source
1. Clone or fork the repository:
   ```bash
   git clone https://github.com/yourusername/GoMudUI.git
   cd GoMudUI
   ```
2. Install [Muddler](https://github.com/demonnic/muddler) (a build tool for Mudlet packages)
3. Run Muddler to build the package:
   ```bash
   muddler
   ```
4. The built `.mpackage` file will be in the `build` directory
5. Import the package using Mudlet's Package Manager as described in Option 2

## Configuration

The UI can be customized through the settings panel. More settings are available using the "ui" command in Mudlet.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Credits

Created by Morquin, inspired by [Durd](https://github.com/MentalThinking) of Asteria
Copyright (c) 2025