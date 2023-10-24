# Research Rovers: Astrolex

Project: Astrolex is an AI-powered research assistant designed to help its users rapidly explore broad research fields.

Author: Joe Muller

License: MIT

# Getting Started

The Astrolex application relies on 3 technologies:
1. [Flutter](https://flutter.dev/) (Android/iOS applications)
2. [Firebase](https://firebase.google.com/) (Backend)
3. [PaLM API](https://developers.generativeai.google/) (AI) 

To run the application, perform the following steps in order:

## Flutter Setup
1. [Install Flutter](https://docs.flutter.dev/get-started/install)
2. [Set up an editor](https://docs.flutter.dev/get-started/editor) (I use Android Studio. VS Code is also popular). You will need to install the Dart and Flutter plugins for your editor.
3. Clone this repository
4. Run `flutter pub get` in the root directory of the project to fetch dependencies. All dependencies are listed in the `pubspec.yaml` file at the root of the project and can be found on [pub.dev](https://pub.dev/).
5. Setup Firebase (see below)

## Firebase Setup
1. Create a Firebase account (free tier is fine)
2. Create a new project (any name is fine)
3. [Enable Firebase Authentication](https://firebase.google.com/docs/auth/where-to-start) and ensure that the "Email/Password" sign-in method is enabled
4. [Enable Cloud Firestore](https://firebase.google.com/docs/firestore/quickstart) and create a new database

## Flutter and Firebase Setup
1. Navigate to the root of the Astrolex project
2. Install the [flutterfire_cli](https://firebase.google.com/docs/flutter/setup?platform=ios#install-cli-tools) by running `dart pub global acivate flutterfire_cli`
3. Run `flutterfire configure` and follow the prompts to connect your Firebase project to the Astrolex project. You only need to select Android and iOS as the platforms.

Completing these steps will add a `firebase_options.dart` file to the lib directory.

## PaLM API Setup
Follow the [steps listed here to get an PaLM API key from MakerSuite](https://developers.generativeai.google/tutorials/setup). [MakerSuite](https://makersuite.google.com/app/home) is a Google service that allows you to use the PaLM API for free. You will need to create a MakerSuite account and then create a new project. Once you have a project, you can create an API key.

Once you have an API key, move on to the next section.

## Environment Variable Setup
The goal of this section is to securely pass your PaLM API key to the mobile application.

**Option 1:** 
1. Add your API key to the `config.json` file in the `assets` directory
2. Run the Flutter app using the following command: `flutter run --dart-define-from-file=assets/config.json`

**Option 2:**
1. Pass your API key in the run command directly: 
```agsl
flutter run --dart-define=PALM_API_KEY=<YOUR_API_KEY>
```
The important part is that the name of the environment variable is "PALM_API_KEY".

## Run the Application
You can run the application on a real device or on a simulator/emulator. This section of the Flutter docs shows you how to [select a run target](https://docs.flutter.dev/tools/android-studio#running-and-debugging).

When the application first loads, you will be signed out. Create an account using an email and password. Once you are signed in, you can use the application.

# Application Structure
The main source code for the application lives in the `lib` directory. The `lib` directory contains the following items:
- app (directory): Contains feature-agnostic components that are used by the entire application
- features (directory): Contains feature-specific components that are used by a single feature
- main.dart (file): The entry point for the application