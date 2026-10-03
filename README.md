# Flutter Music Creator

A feature-first Flutter music creation app with built-in recorder and sequencer capabilities.

## Project Structure

```
flutter-music-creator/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── config/                   # App configuration
│   │   └── app_config.dart       # Initialize app settings
│   ├── core/                     # Shared services and models
│   │   ├── services/
│   │   │   ├── audio_service.dart
│   │   │   └── recorder_service.dart
│   │   └── models/
│   │       └── audio_track.dart
│   └── features/                 # Feature-first architecture
│       ├── recorder/             # Recording feature
│       │   ├── presentation/
│       │   │   ├── pages/
│       │   │   │   └── recorder_page.dart
│       │   │   └── providers/
│       │   │       └── recorder_provider.dart
│       │   └── data/
│       ├── sequencer/            # Sequencer feature
│       │   ├── presentation/
│       │   │   ├── pages/
│       │   │   │   └── sequencer_page.dart
│       │   │   └── providers/
│       │   │       └── sequencer_provider.dart
│       │   └── data/
│       └── home/                 # Home/Navigation feature
│           └── presentation/
│               └── pages/
│                   └── home_page.dart
├── pubspec.yaml                  # Dependencies
└── README.md                     # This file
```

## Features

- 🎙️ **Recorder**: Record audio directly from your device's microphone
- 🎵 **Sequencer**: Arrange and play multiple audio tracks with BPM control
- 🔧 **Provider**: State management with the Provider package
- 📦 **RxDart**: Reactive programming support for advanced features

## Dependencies

- **provider** (^6.0.0): State management
- **audioplayers** (^5.2.0): Audio playback and recording
- **path_provider** (^2.1.0): File system access
- **rxdart** (^0.27.0): Reactive programming utilities

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Android SDK or Xcode for iOS development

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Danzexu26-sng/flutter-music-creator.git
   cd flutter-music-creator
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Usage

### Recording Audio

1. Navigate to the **Recorder** tab
2. Tap the **Start** button to begin recording
3. Tap the **Stop** button when done
4. The recording will be saved to the app's audio directory

### Creating a Sequence

1. Navigate to the **Sequencer** tab
2. Set your desired BPM
3. Add tracks from recorded audio files
4. Use **Play** to start playback and **Stop** to pause

## Architecture

This project follows a **feature-first architecture**:

- **Features**: Self-contained modules (Recorder, Sequencer, Home)
- **Core**: Shared services and models used across features
- **Config**: Application-level configuration

Each feature is organized into:
- **Presentation**: UI pages and state providers
- **Data**: Data sources and repositories (expandable)

## Future Enhancements

- [ ] Multi-track audio mixing
- [ ] Audio effects and filters
- [ ] Save and load projects
- [ ] MIDI support
- [ ] Undo/Redo functionality
- [ ] Audio waveform visualization
- [ ] Export to MP3/WAV

## License

MIT License - feel free to use this project for learning and development.

## Support

For issues or questions, please open an issue in the GitHub repository.
