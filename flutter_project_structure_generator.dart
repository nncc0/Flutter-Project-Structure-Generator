import 'dart:io';

void main() {
  print('🚀 Advanced Flutter Project Structure Generator');
  print('===============================================');
  
  while (true) {
    print('\n📋 Choose an option:');
    print('1. Create complete project structure');
    print('2. Add a new feature');
    print('3. Exit');
    
    stdout.write('\nEnter your choice (1-3): ');
    final choice = stdin.readLineSync();
    
    switch (choice) {
      case '1':
        _createCompleteStructure();
        break;
      case '2':
        _addNewFeature();
        break;
      case '3':
        print('\n👋 Goodbye!');
        exit(0);
      default:
        print('\n❌ Invalid choice. Please try again.');
    }
  }
}

void _createCompleteStructure() {
  print('\n🏗️ Creating complete Flutter project structure...');
  
  // Create lib directory if it doesn't exist
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    libDir.createSync();
    print('📁 Created: lib/');
  }
  
  // Create core structure
  _createCoreStructure();
  
  // Create features directory
  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    featuresDir.createSync();
    print('📁 Created: lib/features/');
  }
  
  // Create main.dart
  _createMainFile();
  
  // Create app_router.dart
  _createAppRouter();
  
  // Create dependency injection setup
  _createDependencyInjection();
  
  // Create theme service
  _createThemeService();
  
  // Create localization setup
  _createLocalizationSetup();
  
  // Create localization assets
  _createLocalizationAssets();
  
  // Create settings feature
  _createSettingsFeature();
  
  print('\n✅ Complete project structure created successfully!');
  print('\n📁 Structure created:');
  print('lib/');
  print('├── core/');
  print('│   ├── errors/');
  print('│   ├── network/');
  print('│   ├── utils/');
  print('│   ├── widgets/');
  print('│   ├── services/');
  print('│   ├── usecases/');
  print('│   ├── common/');
  print('│   ├── theme/');
  print('│   └── l10n/');
  print('├── features/');
  print('│   └── settings/');
  print('├── main.dart');
  print('├── app_router.dart');
  print('└── dependency_injection.dart');
  print('assets/');
  print('└── l10n/');
  print('    ├── en.json');
  print('    └── ar.json');
}

void _createCoreStructure() {
  print('\n🔧 Creating core structure...');
  
  // Create core directories
  final coreDirs = [
    'lib/core/errors',
    'lib/core/network',
    'lib/core/utils',
    'lib/core/widgets',
    'lib/core/services',
    'lib/core/usecases',
    'lib/core/common',
    'lib/core/theme',
    'lib/core/l10n',
  ];
  
  for (final dir in coreDirs) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
  
  // Create core files
  _createCoreFiles();
}

void _createCoreFiles() {
  // errors/exceptions.dart
  final exceptionsFile = File('lib/core/errors/exceptions.dart');
  exceptionsFile.writeAsStringSync('''
// 🚨 Custom Exceptions
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}
class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}
class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}
''');
  print('📄 Created: lib/core/errors/exceptions.dart');
  
  // errors/failures.dart
  final failuresFile = File('lib/core/errors/failures.dart');
  failuresFile.writeAsStringSync('''
// ❌ Failures
import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}
''');
  print('📄 Created: lib/core/errors/failures.dart');
  
  // network/network_info.dart
  final networkInfoFile = File('lib/core/network/network_info.dart');
  networkInfoFile.writeAsStringSync('''
// 🌐 Network Information
import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetworkInfo {
  Future<bool> get isConnected;
}
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  
  NetworkInfoImpl(this.connectionChecker);
  
  @override
  Future<bool> get isConnected async => connectionChecker.hasConnection;
}
''');
  print('📄 Created: lib/core/network/network_info.dart');
  
  // utils/constants.dart
  final constantsFile = File('lib/core/utils/constants.dart');
  constantsFile.writeAsStringSync('''
// 🔧 App Constants
class AppConstants {
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int defaultPageSize = 20;
  static const List<String> supportedLocales = ['en', 'ar'];
}
''');
  print('📄 Created: lib/core/utils/constants.dart');
  
  // utils/themes.dart
  final themesFile = File('lib/core/utils/themes.dart');
  themesFile.writeAsStringSync('''
// 🎨 App Themes
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 16.sp),
      titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
    ),
  );
  
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 16.sp),
      titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
    ),
  );
}
''');
  print('📄 Created: lib/core/utils/themes.dart');
  
  // widgets/custom_button.dart
  final buttonFile = File('lib/core/widgets/custom_button.dart');
  buttonFile.writeAsStringSync('''
// 🔘 Custom Button
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  
  const CustomButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(fontSize: 16.sp),
              ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/core/widgets/custom_button.dart');
  
  // services/navigation_service.dart
  final navigationFile = File('lib/core/services/navigation_service.dart');
  navigationFile.writeAsStringSync('''
// 🧭 Navigation Service
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  BuildContext get context => navigatorKey.currentContext!;
  
  void push(String location) {
    GoRouter.of(context).go(location);
  }
  
  void pop() {
    navigatorKey.currentState!.pop();
  }
  
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
''');
  print('📄 Created: lib/core/services/navigation_service.dart');
  
  // services/locator_service.dart
  final locatorFile = File('lib/core/services/locator_service.dart');
  locatorFile.writeAsStringSync('''
// 📍 Service Locator
import 'package:get_it/get_it.dart';
import '../network/network_info.dart';
import '../theme/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // External
  // getIt.registerLazySingleton(() => InternetConnectionChecker());
  
  // Core
  // getIt.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  // );
  
  // Theme
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
}
''');
  print('📄 Created: lib/core/services/locator_service.dart');
  
  // usecases/usecase.dart
  final usecaseFile = File('lib/core/usecases/usecase.dart');
  usecaseFile.writeAsStringSync('''
// 🎯 Base Use Case
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
''');
  print('📄 Created: lib/core/usecases/usecase.dart');
  
  // common/app_colors.dart
  final colorsFile = File('lib/core/common/app_colors.dart');
  colorsFile.writeAsStringSync('''
// 🎨 App Colors
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFB00020);
  static const Color background = Color(0xFFFFFFFF);
}
''');
  print('📄 Created: lib/core/common/app_colors.dart');
}

void _createThemeService() {
  print('\n🎨 Creating theme service...');
  
  // theme_cubit.dart
  final themeCubitFile = File('lib/core/theme/theme_cubit.dart');
  themeCubitFile.writeAsStringSync('''
// 🎨 Theme Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, system }

class ThemeCubit extends Cubit<AppTheme> {
  ThemeCubit() : super(AppTheme.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode') ?? 2; // Default to system
    emit(AppTheme.values[themeIndex]);
  }

  Future<void> setTheme(AppTheme theme) async {
    emit(theme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', theme.index);
  }
}
''');
  print('📄 Created: lib/core/theme/theme_cubit.dart');
}

void _createLocalizationSetup() {
  print('\n🌐 Creating localization setup...');
  
  // app_localizations.dart
  final localizationsFile = File('lib/core/l10n/app_localizations.dart');
  localizationsFile.writeAsStringSync('''
// 🌐 App Localizations
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final Map<String, String> _localizedStrings;

  AppLocalizations(this._localizedStrings);

  String get appName => _localizedStrings['app_name'] ?? 'Flutter App';
  String get welcome => _localizedStrings['welcome'] ?? 'Welcome';
  String get settings => _localizedStrings['settings'] ?? 'Settings';
  String get theme => _localizedStrings['theme'] ?? 'Theme';
  String get language => _localizedStrings['language'] ?? 'Language';
  String get lightTheme => _localizedStrings['light_theme'] ?? 'Light';
  String get darkTheme => _localizedStrings['dark_theme'] ?? 'Dark';
  String get systemTheme => _localizedStrings['system_theme'] ?? 'System';
  String get english => _localizedStrings['english'] ?? 'English';
  String get arabic => _localizedStrings['arabic'] ?? 'Arabic';
  String get backToHome => _localizedStrings['back_to_home'] ?? 'Back to Home';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final String jsonString = await rootBundle.loadString(
      'assets/l10n/locale.languageCode.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final Map<String, String> localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return AppLocalizations(localizedStrings);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
''');
  print('📄 Created: lib/core/l10n/app_localizations.dart');
}

void _createLocalizationAssets() {
  print('\n🌐 Creating localization assets...');
  
  // Create assets directory
  final assetsDir = Directory('assets/l10n');
  if (!assetsDir.existsSync()) {
    assetsDir.createSync(recursive: true);
    print('📁 Created: assets/l10n/');
  }
  
  // en.json
  final enJsonFile = File('assets/l10n/en.json');
  enJsonFile.writeAsStringSync('''
{
  "app_name": "Flutter App",
  "welcome": "Welcome",
  "settings": "Settings",
  "theme": "Theme",
  "language": "Language",
  "light_theme": "Light",
  "dark_theme": "Dark",
  "system_theme": "System",
  "english": "English",
  "arabic": "Arabic",
  "back_to_home": "Back to Home"
}
''');
  print('📄 Created: assets/l10n/en.json');
  
  // ar.json
  final arJsonFile = File('assets/l10n/ar.json');
  arJsonFile.writeAsStringSync('''
{
  "app_name": "تطبيق فلاتر",
  "welcome": "مرحبا",
  "settings": "الإعدادات",
  "theme": "السمة",
  "language": "اللغة",
  "light_theme": "فاتح",
  "dark_theme": "داكن",
  "system_theme": "النظام",
  "english": "الإنجليزية",
  "arabic": "العربية",
  "back_to_home": "العودة للرئيسية"
}
''');
  print('📄 Created: assets/l10n/ar.json');
  
  // Update pubspec.yaml
  _updatePubspecForAssets();
}

void _updatePubspecForAssets() {
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('⚠️ pubspec.yaml not found. Please add the following assets manually:');
    print('flutter:');
    print('  assets:');
    print('    - assets/l10n/en.json');
    print('    - assets/l10n/ar.json');
    return;
  }

  String content = pubspecFile.readAsStringSync();

  // Check if assets are already included
  if (content.contains('assets/l10n/en.json')) {
    return; // Already added
  }

  // Find the flutter section
  final flutterSection = RegExp(r'flutter:\s*\n((?:[ ]{2}.*\n)*)');
  final match = flutterSection.firstMatch(content);
  
  if (match != null) {
    String flutterContent = match.group(1) ?? '';
    
    // Check if assets section exists
    if (flutterContent.contains('assets:')) {
      // Add to existing assets section
      final assetsSection = RegExp(r'assets:\s*\n((?:[ ]{4}- .*\n)*)');
      final assetsMatch = assetsSection.firstMatch(flutterContent);
      
      if (assetsMatch != null) {
        String assetsContent = assetsMatch.group(1) ?? '';
        if (!assetsContent.contains('assets/l10n/en.json')) {
          assetsContent += '    - assets/l10n/en.json\n';
          assetsContent += '    - assets/l10n/ar.json\n';
          
          flutterContent = flutterContent.replaceFirst(
            assetsSection,
            'assets:\n$assetsContent',
          );
          
          content = content.replaceFirst(
            flutterSection,
            'flutter:\n$flutterContent',
          );
        }
      }
    } else {
      // Add new assets section
      flutterContent += '  assets:\n';
      flutterContent += '    - assets/l10n/en.json\n';
      flutterContent += '    - assets/l10n/ar.json\n';
      
      content = content.replaceFirst(
        flutterSection,
        'flutter:\n$flutterContent',
      );
    }
    
    pubspecFile.writeAsStringSync(content);
    print('📄 Updated: pubspec.yaml with localization assets');
  } else {
    print('⚠️ Could not find flutter section in pubspec.yaml. Please add assets manually:');
    print('flutter:');
    print('  assets:');
    print('    - assets/l10n/en.json');
    print('    - assets/l10n/ar.json');
  }
}

void _createSettingsFeature() {
  print('\n⚙️ Creating settings feature...');
  
  // Create settings directory
  final settingsDir = Directory('lib/features/settings');
  if (!settingsDir.existsSync()) {
    settingsDir.createSync(recursive: true);
    print('📁 Created: lib/features/settings/');
  }
  
  // Create settings structure
  final settingsDirs = [
    'lib/features/settings/presentation/pages',
  ];
  
  for (final dir in settingsDirs) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
  
  // Create settings files
  _createSettingsFiles();
  
  // Update app router
  _updateAppRouterForSettings();
  
  // Update dependency injection
  _updateDependencyInjectionForSettings();
}

void _createSettingsFiles() {
  // settings_page.dart
  final settingsPageFile = File('lib/features/settings/presentation/pages/settings_page.dart');
  settingsPageFile.writeAsStringSync('''
// 📱 Settings Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.theme,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            BlocBuilder<ThemeCubit, AppTheme>(
              builder: (context, themeMode) {
                return Column(
                  children: [
                    RadioListTile<AppTheme>(
                      title: Text(l10n.lightTheme),
                      value: AppTheme.light,
                      groupValue: themeMode,
                      onChanged: (value) {
                        context.read<ThemeCubit>().setTheme(value!);
                      },
                    ),
                    RadioListTile<AppTheme>(
                      title: Text(l10n.darkTheme),
                      value: AppTheme.dark,
                      groupValue: themeMode,
                      onChanged: (value) {
                        context.read<ThemeCubit>().setTheme(value!);
                      },
                    ),
                    RadioListTile<AppTheme>(
                      title: Text(l10n.systemTheme),
                      value: AppTheme.system,
                      groupValue: themeMode,
                      onChanged: (value) {
                        context.read<ThemeCubit>().setTheme(value!);
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              l10n.language,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: Text(l10n.english),
              onTap: () {
                // Change language to English
                // This would require a LanguageCubit to implement
              },
            ),
            ListTile(
              title: Text(l10n.arabic),
              onTap: () {
                // Change language to Arabic
                // This would require a LanguageCubit to implement
              },
            ),
          ],
        ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/settings/presentation/pages/settings_page.dart');
  
  // settings_injection.dart
  final settingsInjectionFile = File('lib/features/settings/settings_injection.dart');
  settingsInjectionFile.writeAsStringSync('''
// 🔄 Settings Feature Injection
import 'package:get_it/get_it.dart';

Future<void> initSettingsFeature() async {
  // Settings doesn't require any dependencies for now
  // Add any required dependencies here in the future
}
''');
  print('📄 Created: lib/features/settings/settings_injection.dart');
}

void _updateAppRouterForSettings() {
  final routerFile = File('lib/app_router.dart');
  if (!routerFile.existsSync()) return;
  
  final content = routerFile.readAsStringSync();
  
  // Check if settings route already exists
  if (content.contains('SettingsPage')) {
    return;
  }
  
  // Add settings route
  final settingsRoute = '''
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
''';
  
  // Add import
  final updatedContent = content.replaceFirst(
    'import \'package:go_router/go_router.dart\';',
    'import \'package:go_router/go_router.dart\';\nimport \'package:your_app/features/settings/presentation/pages/settings_page.dart\';',
  );
  
  // Insert new route before closing bracket
  final finalContent = updatedContent.replaceFirst(
    '    ],',
    '$settingsRoute    ],',
  );
  
  routerFile.writeAsStringSync(finalContent);
  print('📄 Updated: lib/app_router.dart with settings route');
}

void _updateDependencyInjectionForSettings() {
  final diFile = File('lib/dependency_injection.dart');
  if (!diFile.existsSync()) return;
  
  final content = diFile.readAsStringSync();
  
  // Add settings import and initialization
  if (!content.contains('initSettingsFeature')) {
    final updatedContent = content.replaceFirst(
      'Future<void> initializeDependencies() async {\n  await setupLocator();',
      'Future<void> initializeDependencies() async {\n  await setupLocator();\n\n  // Register features\n  await initSettingsFeature();',
    );
    
    diFile.writeAsStringSync(updatedContent);
    print('📄 Updated: lib/dependency_injection.dart with settings feature');
  }
}

void _createMainFile() {
  final mainFile = File('lib/main.dart');
  mainFile.writeAsStringSync('''
// 🚀 App Entry Point
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';
import 'core/l10n/app_localizations.dart';
import 'core/services/locator_service.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils/themes.dart';
import 'dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                title: 'Flutter App',
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: _getThemeMode(themeMode),
                locale: const Locale('en'),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
              );
            },
          );
        },
      ),
    );
  }

  ThemeMode _getThemeMode(AppTheme appTheme) {
    switch (appTheme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.system:
        return ThemeMode.system;
    }
  }
}
''');
  print('📄 Created: lib/main.dart');
}

void _createAppRouter() {
  final routerFile = File('lib/app_router.dart');
  routerFile.writeAsStringSync('''
// 🛣️ App Router
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Home Page'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go('/auth');
                },
                child: const Text('Go to Auth Page'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go('/settings');
                },
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Auth Page')),
        ),
      ),
    ],
  );
}
''');
  print('📄 Created: lib/app_router.dart');
}

void _createDependencyInjection() {
  final diFile = File('lib/dependency_injection.dart');
  diFile.writeAsStringSync('''
// 🔄 Dependency Injection Setup
import 'package:get_it/get_it.dart';
import 'core/services/locator_service.dart';

Future<void> initializeDependencies() async {
  await setupLocator();
  
  // TODO: Register your features here
  // Example:
  // await initAuthFeature();
  // await initUserProfileFeature();
}
''');
  print('📄 Created: lib/dependency_injection.dart');
}

void _addNewFeature() {
  stdout.write('\n📝 Enter feature name (e.g., user_profile): ');
  final featureName = stdin.readLineSync()?.trim() ?? '';
  
  if (featureName.isEmpty) {
    print('❌ Feature name cannot be empty!');
    return;
  }
  
  final snakeCase = _toSnakeCase(featureName);
  final pascalCase = _toPascalCase(featureName);
  
  print('\n🔨 Creating feature: $featureName');
  
  // Create feature directory
  final featureDir = Directory('lib/features/$snakeCase');
  if (featureDir.existsSync()) {
    print('⚠️ Feature already exists!');
    return;
  }
  
  featureDir.createSync(recursive: true);
  print('📁 Created: lib/features/$snakeCase/');
  
  // Create feature structure
  _createFeatureStructure(snakeCase, pascalCase);
  
  // Create feature files
  _createFeatureFiles(snakeCase, pascalCase);
  
  // Update app router
  _updateAppRouter(snakeCase, pascalCase);
  
  // Update dependency injection
  _updateDependencyInjection(snakeCase, pascalCase);
  
  print('\n✅ Feature "$featureName" created successfully!');
  print('\n📁 Feature structure:');
  print('lib/features/$snakeCase/');
  print('├── data/');
  print('│   ├── datasources/');
  print('│   ├── models/');
  print('│   └── repositories/');
  print('├── domain/');
  print('│   ├── entities/');
  print('│   ├── repositories/');
  print('│   └── usecases/');
  print('└── presentation/');
  print('    ├── cubit/');
  print('    ├── pages/');
  print('    └── widgets/');
}

void _createFeatureStructure(String snakeCase, String pascalCase) {
  final directories = [
    'lib/features/$snakeCase/data/datasources',
    'lib/features/$snakeCase/data/models',
    'lib/features/$snakeCase/data/repositories',
    'lib/features/$snakeCase/domain/entities',
    'lib/features/$snakeCase/domain/repositories',
    'lib/features/$snakeCase/domain/usecases',
    'lib/features/$snakeCase/presentation/cubit',
    'lib/features/$snakeCase/presentation/pages',
    'lib/features/$snakeCase/presentation/widgets',
  ];
  
  for (final dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
}

void _createFeatureFiles(String snakeCase, String pascalCase) {
  // Entity
  final entityFile = File('lib/features/$snakeCase/domain/entities/${snakeCase}_entity.dart');
  entityFile.writeAsStringSync('''
// 🎯 ${pascalCase} Entity
import 'package:equatable/equatable.dart';

class ${pascalCase}Entity extends Equatable {
  final String id;
  final String name;
  
  const ${pascalCase}Entity({
    required this.id,
    required this.name,
  });
  
  @override
  List<Object> get props => [id, name];
}
''');
  print('📄 Created: lib/features/$snakeCase/domain/entities/${snakeCase}_entity.dart');
  
  // Model
  final modelFile = File('lib/features/$snakeCase/data/models/${snakeCase}_model.dart');
  modelFile.writeAsStringSync('''
// 📊 ${pascalCase} Model
import '../../domain/entities/${snakeCase}_entity.dart';

class ${pascalCase}Model extends ${pascalCase}Entity {
  const ${pascalCase}Model({
    required String id,
    required String name,
  }) : super(id: id, name: name);
  
  factory ${pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return ${pascalCase}Model(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/data/models/${snakeCase}_model.dart');
  
  // Repository
  final repositoryFile = File('lib/features/$snakeCase/domain/repositories/${snakeCase}_repository.dart');
  repositoryFile.writeAsStringSync('''
// 📚 ${pascalCase} Repository
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/${snakeCase}_entity.dart';

abstract class ${pascalCase}Repository {
  Future<Either<Failure, ${pascalCase}Entity>> get${pascalCase}(String id);
}
''');
  print('📄 Created: lib/features/$snakeCase/domain/repositories/${snakeCase}_repository.dart');
  
  // Repository Implementation
  final repositoryImplFile = File('lib/features/$snakeCase/data/repositories/${snakeCase}_repository_impl.dart');
  repositoryImplFile.writeAsStringSync('''
// 🔧 ${pascalCase} Repository Implementation
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/${snakeCase}_entity.dart';
import '../../domain/repositories/${snakeCase}_repository.dart';
import '../datasources/${snakeCase}_remote_datasource.dart';

class ${pascalCase}RepositoryImpl implements ${pascalCase}Repository {
  final ${pascalCase}RemoteDataSource remoteDataSource;
  
  ${pascalCase}RepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, ${pascalCase}Entity>> get${pascalCase}(String id) async {
    try {
      final ${snakeCase} = await remoteDataSource.get${pascalCase}(id);
      return Right(${snakeCase});
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/data/repositories/${snakeCase}_repository_impl.dart');
  
  // Remote Data Source
  final remoteDataSourceFile = File('lib/features/$snakeCase/data/datasources/${snakeCase}_remote_datasource.dart');
  remoteDataSourceFile.writeAsStringSync('''
// 🌐 ${pascalCase} Remote Data Source
import '../../domain/entities/${snakeCase}_entity.dart';

abstract class ${pascalCase}RemoteDataSource {
  Future<${pascalCase}Entity> get${pascalCase}(String id);
}

class ${pascalCase}RemoteDataSourceImpl implements ${pascalCase}RemoteDataSource {
  @override
  Future<${pascalCase}Entity> get${pascalCase}(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/data/datasources/${snakeCase}_remote_datasource.dart');
  
  // Use Case
  final useCaseFile = File('lib/features/$snakeCase/domain/usecases/get_${snakeCase}.dart');
  useCaseFile.writeAsStringSync('''
// 🎯 Get ${pascalCase} Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/${snakeCase}_repository.dart';
import '../entities/${snakeCase}_entity.dart';

class Get${pascalCase} implements UseCase<${pascalCase}Entity, String> {
  final ${pascalCase}Repository repository;
  
  Get${pascalCase}(this.repository);
  
  @override
  Future<Either<Failure, ${pascalCase}Entity>> call(String params) async {
    return repository.get${pascalCase}(params);
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/domain/usecases/get_${snakeCase}.dart');
  
  // Cubit
  final cubitFile = File('lib/features/$snakeCase/presentation/cubit/${snakeCase}_cubit.dart');
  cubitFile.writeAsStringSync('''
// 🎯 ${pascalCase} Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/${snakeCase}_entity.dart';
import '../../domain/usecases/get_${snakeCase}.dart';
import '../../../../core/errors/failures.dart';

part '${snakeCase}_state.dart';

class ${pascalCase}Cubit extends Cubit<${pascalCase}State> {
  final Get${pascalCase} get${pascalCase};
  
  ${pascalCase}Cubit({required this.get${pascalCase}}) : super(${pascalCase}Initial());
  
  Future<void> fetch${pascalCase}(String id) async {
    emit(${pascalCase}Loading());
    final result = await get${pascalCase}(id);
    result.fold(
      (failure) => emit(${pascalCase}Error(failure.message)),
      (${pascalCase.toLowerCase()}) => emit(${pascalCase}Loaded(${pascalCase.toLowerCase()})),
    );
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/presentation/cubit/${snakeCase}_cubit.dart');
  
  // Cubit State
  final cubitStateFile = File('lib/features/$snakeCase/presentation/cubit/${snakeCase}_state.dart');
  cubitStateFile.writeAsStringSync('''
// 🎯 ${pascalCase} Cubit State
part of '${snakeCase}_cubit.dart';

abstract class ${pascalCase}State {}

class ${pascalCase}Initial extends ${pascalCase}State {}

class ${pascalCase}Loading extends ${pascalCase}State {}

class ${pascalCase}Loaded extends ${pascalCase}State {
  final ${pascalCase}Entity ${pascalCase.toLowerCase()};
  ${pascalCase}Loaded(this.${pascalCase.toLowerCase()});
}

class ${pascalCase}Error extends ${pascalCase}State {
  final String message;
  ${pascalCase}Error(this.message);
}
''');
  print('📄 Created: lib/features/$snakeCase/presentation/cubit/${snakeCase}_state.dart');
  
  // Page
  final pageFile = File('lib/features/$snakeCase/presentation/pages/${snakeCase}_page.dart');
  pageFile.writeAsStringSync('''
// 📱 ${pascalCase} Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubit/${snakeCase}_cubit.dart';
import '../../../../core/services/locator_service.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../domain/usecases/get_$snakeCase.dart';
class ${pascalCase}Page extends StatelessWidget {
  const ${pascalCase}Page({Key? key}) : super(key: key);

  static const String routeName = '/$snakeCase';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${pascalCase}Cubit(
        get${pascalCase}: getIt<Get${pascalCase}>(),
      )..fetch${pascalCase}('1'), // Fetch initial data
      child: Scaffold(
        appBar: AppBar(
          title: Text('${pascalCase}'),
        ),
        body: BlocBuilder<${pascalCase}Cubit, ${pascalCase}State>(
          builder: (context, state) {
            if (state is ${pascalCase}Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ${pascalCase}Loaded) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Text(
                      state.${pascalCase.toLowerCase()}.name,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => context.go('/'),
                      child: Text(AppLocalizations.of(context)!.backToHome),
                    ),
                  ],
                ),
              );
            } else if (state is ${pascalCase}Error) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/presentation/pages/${snakeCase}_page.dart');
  
  // Widget
  final widgetFile = File('lib/features/$snakeCase/presentation/widgets/${snakeCase}_widget.dart');
  widgetFile.writeAsStringSync('''
// 🎨 ${pascalCase} Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${pascalCase}Widget extends StatelessWidget {
  const ${pascalCase}Widget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Text(
        '${pascalCase} Widget',
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/presentation/widgets/${snakeCase}_widget.dart');
}

void _updateAppRouter(String snakeCase, String pascalCase) {
  final routerFile = File('lib/app_router.dart');
  if (!routerFile.existsSync()) return;
  
  final content = routerFile.readAsStringSync();
  
  // Add new route
  final newRoute = '''
      GoRoute(
        path: '/$snakeCase',
        builder: (context, state) => const ${pascalCase}Page(),
      ),
''';
final newImport = "import 'features/$snakeCase/presentation/pages/${snakeCase}_page.dart';";

  final updatedImports = content.replaceFirst(
    'import \'package:go_router/go_router.dart\';',
    '$newImport\n    import \'package:go_router/go_router.dart\';'
  );
  // Insert new route before closing bracket
  final updatedContent = content.replaceFirst(
    '    ],',
    '$newRoute    ],',
  );
  
  
  routerFile.writeAsStringSync(updatedContent);
  routerFile.writeAsStringSync(updatedImports);
  print('📄 Updated: lib/app_router.dart');
}

void _updateDependencyInjection(String snakeCase, String pascalCase) {
  final diFile = File('lib/dependency_injection.dart');
  if (!diFile.existsSync()) return;
  
  final content = diFile.readAsStringSync();
  
  // Add feature initialization
  final newImport = "import 'features/$snakeCase/${snakeCase}_injection.dart';";
  final newInit = "  await init${pascalCase}Feature();";
  
  // Check if import already exists
  if (!content.contains(newImport)) {
    final updatedContent = content.replaceFirst(
      'import \'package:get_it/get_it.dart\';',
      '$newImport\n  import \'package:get_it/get_it.dart\';',
    );
    diFile.writeAsStringSync(updatedContent);
  }
  
  // Check if init already exists
  if (!content.contains(newInit)) {
    final updatedContent = diFile.readAsStringSync();
    final finalContent = updatedContent.replaceFirst(
      '// Example:',
      '$newInit\n  // Example:',
    );
    diFile.writeAsStringSync(finalContent);
  }
  
  // Create feature injection file
  final injectionFile = File('lib/features/$snakeCase/${snakeCase}_injection.dart');
  injectionFile.writeAsStringSync('''
// 🔄 ${pascalCase} Feature Injection
import 'package:get_it/get_it.dart';
import 'data/datasources/${snakeCase}_remote_datasource.dart';
import 'data/repositories/${snakeCase}_repository_impl.dart';
import 'domain/repositories/${snakeCase}_repository.dart';
import 'domain/usecases/get_${snakeCase}.dart';
import 'presentation/cubit/${snakeCase}_cubit.dart';
import '../../core/services/locator_service.dart';

Future<void> init${pascalCase}Feature() async {
  // Data sources
  getIt.registerFactory<${pascalCase}RemoteDataSource>(
    () => ${pascalCase}RemoteDataSourceImpl(),
  );
  
  // Repositories
  getIt.registerFactory<${pascalCase}Repository>(
    () => ${pascalCase}RepositoryImpl(
      remoteDataSource: getIt<${pascalCase}RemoteDataSource>(),
    ),
  );
  
  // Use cases
  getIt.registerFactory<Get${pascalCase}>(
    () => Get${pascalCase}(
      getIt<${pascalCase}Repository>(),
    ),
  );
  
  // Cubit
  getIt.registerFactory<${pascalCase}Cubit>(
    () => ${pascalCase}Cubit(
      get${pascalCase}: getIt<Get${pascalCase}>(),
    ),
  );
}
''');
  print('📄 Created: lib/features/$snakeCase/${snakeCase}_injection.dart');
}

String _toSnakeCase(String input) {
  return input
    .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
    .replaceFirst(RegExp(r'^_'), '');
}

String _toPascalCase(String input) {
  return input
    .split('_')
    .map((word) => word[0].toUpperCase() + word.substring(1))
    .join();
}