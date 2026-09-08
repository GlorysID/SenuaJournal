# Trading Journal

A personal trading journal built with Flutter — record every trade, track your performance, and understand your edge with analytics and visual insights.

![Flutter](https://img.shields.io/badge/Flutter-3.9%2B-02569B?logo=flutter&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux%20%7C%20Web-lightgrey)

## Features

- **Authentication** — Email/password login and registration, secured by Firebase Auth
- **Dashboard & Analytics** — Overview of your trading performance at a glance
- **Trades List & Detail** — Browse all logged trades and inspect each one in detail
- **Performance Trend Chart** — Interactive charts of your equity/performance over time
- **Contribution Heatmap** — GitHub-style heatmap showing your trading activity
- **Notifications** — In-app notification center
- **In-App Update System** — The app checks a remote `version.json` and prompts you when a new release is available
- **Cloud Sync** — Your journal data syncs across devices via Firebase (Auth + Firestore)

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State management | Riverpod |
| Local database | Isar |
| Cloud / Backend | Firebase Auth, Cloud Firestore |
| Charts | fl_chart |

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.9.0`
- An Android/iOS device or emulator (or desktop/web target)

### Installation

```bash
git clone https://github.com/GlorysID/SenuaJournal.git
cd SenuaJournal
flutter pub get
flutter run
```

## Firebase Setup

This project uses Firebase for authentication and cloud sync. **You must connect it to your own Firebase project** — the Firebase configuration file is intentionally **not committed** to this repo (it is gitignored, see `.gitignore`).

1. Create a new project at the [Firebase Console](https://console.firebase.google.com/).
2. Register an **Android app** in your Firebase project.
3. Download the generated `google-services.json` and place it at `android/app/google-services.json`.
4. Enable **Authentication** (Email/Password) and **Cloud Firestore** in the Firebase Console.
5. (Optional, for iOS) Add your `GoogleService-Info.plist` to `ios/Runner/`.

## Security Notes

> ⚠️ **Warning:** Firebase API keys are not secrets by themselves — they are safe to ship in a public app **only if** you restrict how they can be used. Before distributing any build publicly:
>
> - Enable **Firebase App Check** and/or restrict the API key (e.g., SHA-1/SHA-256 fingerprint restriction for Android).
> - Configure **Firestore Security Rules** so users can only read/write their own data.
> - Never commit service-account keys or signing keystores to the repository (see `.gitignore`).

## License

This project is licensed under the [MIT License](LICENSE).
