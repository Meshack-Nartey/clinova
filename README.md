# Clinova

Offline-first patient data capture and sync for rural health outreach.

## Stack

- **Flutter** — cross-platform (mobile, web, desktop)
- **Drift + SQLCipher** — encrypted local SQLite database
- **Shelf** — embedded HTTP server for local device-to-device sync
- **Riverpod** — state management
- **go_router** — navigation

## Getting Started

```bash
flutter pub get
flutter run
```

## Features

- Capture patient records offline
- Sync data across devices on the same local network
- Export records as CSV or PDF
- Encrypted storage with PIN-based access
