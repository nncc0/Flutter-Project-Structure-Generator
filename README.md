# 🚀 Advanced Flutter Project Structure Generator

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

A powerful command-line tool that generates a production-ready Flutter project structure following clean architecture principles and best practices. This tool helps you kickstart your Flutter projects with a solid foundation that scales well with your application growth.

## ✨ Features

- 🏗️ **Clean Architecture Implementation**: Follows the Domain-Driven Design principles
- 📱 **Feature-Based Structure**: Organized by features rather than layers
- 🎨 **Theme Management**: Built-in light/dark theme support with system preference
- 🌐 **Internationalization**: Ready-to-use localization system (English/Arabic)
- 🧭 **Navigation**: GoRouter implementation for declarative routing
- 🔄 **Dependency Injection**: GetIt service locator setup
- 📊 **State Management**: BLoC/Cubit pattern implementation
- 🎯 **Error Handling**: Comprehensive error handling with failures and exceptions
- 🌐 **Network Layer**: Structured network layer with connectivity checks

## 📁 Project Structure

```
lib/
├── core/                    # Core functionality shared across features
│   ├── errors/             # Custom exceptions and failures
│   ├── network/            # Network information and connectivity
│   ├── utils/              # Utilities, constants, and themes
│   ├── widgets/            # Reusable UI components
│   ├── services/           # App services (navigation, locator)
│   ├── usecases/           # Base usecase implementation
│   ├── common/             # Shared resources (colors, etc.)
│   ├── theme/              # Theme management
│   └── l10n/               # Localization setup
├── features/               # Feature modules
│   └── settings/           # Example settings feature
│       ├── data/           # Data layer (models, datasources, repositories)
│       ├── domain/         # Domain layer (entities, repositories, usecases)
│       └── presentation/   # UI layer (cubit, pages, widgets)
├── main.dart               # App entry point
├── app_router.dart         # Navigation configuration
└── dependency_injection.dart # Dependency injection setup
assets/
└── l10n/                   # Localization files
    ├── en.json             # English translations
    └── ar.json             # Arabic translations
```

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 2.12 or higher)
- [Dart SDK](https://dart.dev/get-dart) (version 2.17 or higher)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter-project-structure-generator.git
   cd flutter-project-structure-generator
   ```

2. Run the generator:
   ```bash
   dart run generator.dart
   ```

3. Follow the on-screen instructions to create your project structure.

### Usage

The generator provides a simple command-line interface:

```bash
🚀 Advanced Flutter Project Structure Generator
===============================================

📋 Choose an option:
1. Create complete project structure
2. Add a new feature
3. Exit

Enter your choice (1-3): 
```

#### Option 1: Create Complete Project Structure

This option creates the entire project structure with all the core components:

- Core directories and files
- Settings feature as an example
- Localization setup
- Theme management
- Dependency injection configuration
- Navigation setup

#### Option 2: Add a New Feature

This option allows you to add a new feature to your existing project:

1. Enter the feature name (e.g., `user_profile`)
2. The generator will create:
   - Feature directory structure (data, domain, presentation)
   - Entity, model, repository, and usecase files
   - Cubit and state management files
   - Page and widget files
   - Feature injection configuration
   - Updates to the router and dependency injection

## 🛠️ Adding a New Feature Manually

If you prefer to add features manually, follow these steps:

1. Create the feature directory structure:
   ```
   lib/features/your_feature/
   ├── data/
   │   ├── datasources/
   │   ├── models/
   │   └── repositories/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   └── presentation/
       ├── cubit/
       ├── pages/
       └── widgets/
   ```

2. Create the necessary files following the pattern from existing features.

3. Register your feature in `dependency_injection.dart`:
   ```dart
   Future<void> initializeDependencies() async {
     await setupLocator();
     
     // Register features
     await initSettingsFeature();
     await initYourFeatureFeature(); // Add this line
   }
   ```

4. Add your feature routes to `app_router.dart`.

## 📚 Architecture Overview

This project follows the Clean Architecture pattern with these layers:

### Domain Layer
- Contains business logic and entities
- Defines use cases and repository interfaces
- Independent of any frameworks or external dependencies

### Data Layer
- Implements repository interfaces
- Handles data sources (API, database)
- Contains data models and mappers

### Presentation Layer
- Contains UI components (pages, widgets)
- Implements state management with BLoC/Cubit
- Handles user interactions and navigation

### Core Layer
- Contains shared functionality across features
- Includes utilities, services, and base implementations
- Provides infrastructure for the entire application

## 🌐 Localization

The project includes a ready-to-use localization system:

1. Translation files are located in `assets/l10n/`
2. Supported languages: English (`en.json`) and Arabic (`ar.json`)
3. To add a new language:
   - Create a new JSON file in `assets/l10n/` (e.g., `fr.json`)
   - Add the language code to `AppConstants.supportedLocales`
   - Update `pubspec.yaml` to include the new asset

## 🎨 Theming

The project includes theme management with:

- Light and dark theme support
- System theme preference option
- Customizable colors and text styles
- Theme persistence using SharedPreferences

To customize the theme, modify the `AppThemes` class in `lib/core/utils/themes.dart`.

## 🔄 State Management

The project uses the BLoC pattern with Cubit for state management:

- Each feature has its own Cubit and State
- States extend a base state class
- Cubits handle business logic and emit new states
- UI components listen to state changes and rebuild accordingly

## 🧭 Navigation

Navigation is handled using GoRouter:

- Declarative routing configuration
- Nested routing support
- Route parameters and query strings
- Easy integration with deep linking

To add a new route, update the `AppRouter` class in `lib/app_router.dart`.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) for the amazing framework
- [GoRouter](https://pub.dev/packages/go_router) for navigation
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) for state management
- [GetIt](https://pub.dev/packages/get_it) for dependency injection
- [ScreenUtil](https://pub.dev/packages/flutter_screenutil) for responsive design

## 📞 Support

If you have any questions or need help, please open an issue on GitHub or contact the maintainers.

---

Made with ❤️ by [Your Name](https://github.com/your-username)
