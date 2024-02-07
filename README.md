# Tourney Craft

Tourney Craft is a Flutter application designed to streamline the creation and management of sports tournaments. It utilizes Firebase for real-time data storage and authentication.

## Features

- **Firebase Authentication:** User authentication using Firebase Authentication.
- **Firestore Database:** Real-time storage for tournament, player, and match information.
- **Competition Creation:** Allows administrators to create new competitions.
- **Single-Elimination Draw:** Functionality to automatically draw single-elimination matches.
- **Player and Administrator Profiles:** Different levels of access for participants and administrators.

## Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase Project: Create a project on the [Firebase Console](https://console.firebase.google.com/) and set up the app for iOS and Android.

## Setup

1. Clone the repository:

```bash
git clone https://github.com/your-username/TourneyCraft.git
cd TourneyCraft
```

2. Install dependencies:
```bash
flutter pub get
```

3. Add Firebase configuration files:

Download the google-services.json and GoogleService-Info.plist files from the Firebase console.
Place the files in the android/app directory (for Android) and ios/Runner directory (for iOS).

4. Run the app:
```bash
flutter run
```

