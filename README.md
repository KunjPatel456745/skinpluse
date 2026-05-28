# Skinpulse AI

AI powered skin diagnosis tool using Flutter and Gemini API.

## Build and Run Configurations

The app requires compile-time configuration parameters to integrate with Supabase. Always supply the `SUPABASE_URL` and `SUPABASE_ANON_KEY` when running or building the app using `--dart-define`.

### Running locally
```bash
flutter run --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

### Building for Android (Release APK)
```bash
flutter build apk --release --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

### Building for iOS (Release App Bundle)
```bash
flutter build ipa --release --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

