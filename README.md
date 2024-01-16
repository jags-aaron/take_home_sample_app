# TakeHomeSampleApp
Build a simple, user friendly news app that consumes the API from newsapi.org

## Project Folder Structure

```
└── 📁lib
    └── .DS_Store
    └── app.dart
    └── app_router.dart
    └── 📁common_platform
        └── 📁dio
        └── 📁extensions
        └── i_platform_client.dart
        └── 📁l10n
        └── mobile_platform_client.dart
        └── 📁theme
    └── 📁data
        └── 📁model
        └── 📁repository
        └── 📁source
    └── 📁domain
        └── 📁entity
        └── 📁use_case
    └── 📁features
        └── 📁<feature>
            └── 📁navigation
                └── <feature>_route.dart
            └── 📁screen
                └── 📁bloc
                    └── <feature>_bloc.dart
                    └── <feature>_event.dart
                    └── <feature>_state.dart
                └── <feature>_controller.dart
                └── <feature>_screen.dart
                └── <feature>_screen_model.dart
    └── main.dart
```

## Running and tested on

- Flutter 3.16.3 • channel stable • https://github.com/flutter/flutter.git
- Framework • revision b0366e0a3f (6 weeks ago) • 2023-12-05 19:46:39 -0800
- Engine • revision 54a7145303
- Tools • Dart 3.2.3 • DevTools 2.28.4

## Run the project

1. Clone the project
2. install FVM package --> https://fvm.app/docs/getting_started/installation
3. Run `fvm use 3.16.3`
2. Run `fvm flutter pub get`
3. Run `fvm flutter run`