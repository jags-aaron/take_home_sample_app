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
        └── 📁l10n
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

## Environment

- Flutter 3.16.3 • channel stable • https://github.com/flutter/flutter.git
- Framework • revision b0366e0a3f (6 weeks ago) • 2023-12-05 19:46:39 -0800
- Engine • revision 54a7145303
- Tools • Dart 3.2.3 • DevTools 2.28.4

# Third party libraries
provider: ^6.0.5
dio: ^5.4.0
go_router: ^13.0.0
equatable: ^2.0.3
sqflite: ^2.3.0
flutter_bloc: ^7.3.3

## Run the project

1. Clone the project
2. install FVM package --> https://fvm.app/docs/getting_started/installation
3. Run `fvm use 3.16.3`
2. Run `fvm flutter pub get`
3. Run `fvm flutter run`

## TODO task
1. background process to get new date (considering using [WorkManager](https://pub.dev/packages/workmanager)
2. UI and bloc tests
3. remove Hardcoded and boilerplate code for favorites and detail

## Demo
https://github.com/jags-aaron/take_home_sample_app/assets/4992208/d6aac09b-e515-49fc-95ce-6bd74f506a61

