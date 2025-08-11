
import 'dart:io';
import 'package:yaml/yaml.dart' as yaml;
import 'package:path/path.dart' as path;
  import 'package:yaml_writer/yaml_writer.dart';

void main() {
  print('🚀 Advanced Flutter Project Structure Generator v2.0');
  print('===============================================');
  
  // Check if we're in a Flutter project
  if (!_isFlutterProject()) {
    print('❌ Error: Not a Flutter project directory. Please run this in a Flutter project root.');
    exit(1);
  }
  
  while (true) {
    print('\n📋 Choose an option:');
    print('1. Create complete project structure');
    print('2. Add a new feature');
    print('3. Add a new service');
    print('4. Generate boilerplate code');
    print('5. Configure dependencies');
    print('6. Exit');
    
    stdout.write('\nEnter your choice (1-6): ');
    final choice = stdin.readLineSync();
    
    switch (choice) {
      case '1':
        _createCompleteStructure();
        break;
      case '2':
        _addNewFeature();
        break;
      case '3':
        _addNewService();
        break;
      case '4':
        _generateBoilerplate();
        break;
      case '5':
        _configureDependencies();
        break;
      case '6':
        print('\n👋 Goodbye!');
        exit(0);
      default:
        print('\n❌ Invalid choice. Please try again.');
    }
  }
}

bool _isFlutterProject() {
  return File('pubspec.yaml').existsSync();
}

void _createCompleteStructure() {
  print('\n🏗️ Creating complete Flutter project structure...');
  
  // Ask for project configuration
  stdout.write('🔤 Enter project name (e.g., my_app): ');
  final projectName = stdin.readLineSync()?.trim() ?? 'my_app';
  
  stdout.write('🌐 Enable localization? (y/n): ');
  final enableLocalization = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
  stdout.write('🎨 Enable theming? (y/n): ');
  final enableTheming = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
  stdout.write('📊 Enable analytics? (y/n): ');
  final enableAnalytics = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
  stdout.write('🔐 Enable authentication? (y/n): ');
  final enableAuth = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
  // Create lib directory if it doesn't exist
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    libDir.createSync();
    print('📁 Created: lib/');
  }
  
  // Create core structure
  _createCoreStructure(enableLocalization, enableTheming, enableAnalytics);
  
  // Create features directory
  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    featuresDir.createSync();
    print('📁 Created: lib/features/');
  }
  
  // Create main.dart
  _createMainFile(projectName, enableLocalization, enableTheming, enableAnalytics);

  // Create app_router.dart
  _createAppRouter();
  
  // Create dependency injection setup
  _createDependencyInjection();
  
  // Create theme service if enabled
  if (enableTheming) {
    _createThemeService();
  }
  
  // Create localization setup if enabled
  if (enableLocalization) {
    _createLocalizationSetup();
    _createLocalizationAssets();
  }
  
  // Create analytics service if enabled
  if (enableAnalytics) {
    _createAnalyticsService();
  }
  
  // Create auth feature if enabled
  if (enableAuth) {
    _createAuthFeature();
  }
  
  // Create settings feature
  _createSettingsFeature(enableLocalization, enableTheming);
  
  // Create README file
  _createProjectReadme(projectName, enableLocalization, enableTheming, enableAnalytics, enableAuth);
  
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
  if (enableTheming) print('│   ├── theme/');
  if (enableLocalization) print('│   ├── l10n/');
  if (enableAnalytics) print('│   ├── analytics/');
  print('├── features/');
  if (enableAuth) print('│   └── auth/');
  print('│   └── settings/');
  print('├── main.dart');
  print('├── app_router.dart');
  print('└── dependency_injection.dart');
  if (enableLocalization) {
    print('assets/');
    print('└── l10n/');
    print('    ├── en.json');
    print('    └── ar.json');
  }
}

void _createCoreStructure(bool enableLocalization, bool enableTheming, bool enableAnalytics) {
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
  ];
  
  if (enableTheming) coreDirs.add('lib/core/theme');
  if (enableLocalization) coreDirs.add('lib/core/l10n');
  if (enableAnalytics) coreDirs.add('lib/core/analytics');
  
  for (final dir in coreDirs) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
  
  // Create core files
  _createCoreFiles(enableLocalization, enableTheming, enableAnalytics);
}

void _createCoreFiles(bool enableLocalization, bool enableTheming, bool enableAnalytics) {
  // errors/exceptions.dart
  final exceptionsFile = File('lib/core/errors/exceptions.dart');
  exceptionsFile.writeAsStringSync('''
// 🚨 Custom Exceptions
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;
  
  const ServerException(this.message, {this.statusCode, this.data});
  
  @override
  String toString() => 'ServerException: \$message (Status: \$statusCode)';
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
  
  @override
  String toString() => 'CacheException: \$message';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  
  @override
  String toString() => 'NetworkException: \$message';
}

class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException(this.message);
  
  @override
  String toString() => 'AuthenticationException: \$message';
}

class AuthorizationException implements Exception {
  final String message;
  const AuthorizationException(this.message);
  
  @override
  String toString() => 'AuthorizationException: \$message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? errors;
  
  const ValidationException(this.message, {this.errors});
  
  @override
  String toString() => 'ValidationException: \$message';
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
  final int? statusCode;
  
  const Failure(this.message, {this.statusCode});
  
  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode}) : super(message, statusCode: statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;
  
  const ValidationFailure(String message, {this.errors}) : super(message);
  
  @override
  List<Object?> get props => [message, statusCode, errors];
}
''');
  print('📄 Created: lib/core/errors/failures.dart');
  
  // network/network_info.dart
  final networkInfoFile = File('lib/core/network/network_info.dart');
  networkInfoFile.writeAsStringSync('''
// 🌐 Network Information
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get connectivityStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  final Connectivity connectivity;
  
  NetworkInfoImpl(this.connectionChecker, this.connectivity);
  
  @override
  Future<bool> get isConnected async => connectionChecker.hasConnection;
  
  @override
  Stream<ConnectivityResult> get connectivityStream => connectivity.onConnectivityChanged;
}
''');
  print('📄 Created: lib/core/network/network_info.dart');
  
  // network/api_client.dart
  final apiClientFile = File('lib/core/network/api_client.dart');
  apiClientFile.writeAsStringSync('''
// 🌐 API Client
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../errors/exceptions.dart';
import '../utils/constants.dart';

class ApiClient {
  final Dio _dio;
  
  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: AppConstants.apiTimeout,
    receiveTimeout: AppConstants.apiTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  )) {
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add logging in debug mode
          if (kDebugMode) {
            print('REQUEST[\${options.method}] => PATH: \${options.path}');
            print('HEADERS: \${options.headers}');
            print('DATA: \${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Add logging in debug mode
          if (kDebugMode) {
            print('RESPONSE[\${response.statusCode}] => PATH: \${response.requestOptions.path}');
            print('DATA: \${response.data}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          // Handle errors
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            throw NetworkException('No internet connection');
          } else if (error.response?.statusCode == 401) {
            throw AuthenticationException('Unauthorized');
          } else if (error.response?.statusCode == 403) {
            throw AuthorizationException('Forbidden');
          } else if (error.response?.statusCode == 422) {
            throw ValidationException(
              'Validation error',
              errors: Map<String, List<String>>.from(
                error.response?.data['errors'] ?? {},
              ),
            );
          } else {
            throw ServerException(
              'Server error',
              statusCode: error.response?.statusCode,
              data: error.response?.data,
            );
          }
        },
      ),
    );
  }
  
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
  
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
''');
  print('📄 Created: lib/core/network/api_client.dart');
  
  // utils/constants.dart
  final constantsFile = File('lib/core/utils/constants.dart');
  constantsFile.writeAsStringSync('''
// 🔧 App Constants
class AppConstants {
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int defaultPageSize = 20;
  static const List<String> supportedLocales = ['en', 'ar'];
  
  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'language';
  
  // API endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String userProfileEndpoint = '/user/profile';
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
  static const Color errorColor = Color(0xFFB00020);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFFC107);
  
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: Colors.white,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 16.sp),
      titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
    ),
  );
  
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: Colors.black,
      surface: Colors.grey[900]!,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 16.sp),
      titleLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
    ),
  );
}
''');
  print('📄 Created: lib/core/utils/themes.dart');
  
  // utils/extensions.dart
  final extensionsFile = File('lib/core/utils/extensions.dart');
  extensionsFile.writeAsStringSync('''
// 🔧 Extensions
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
  
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
  
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
  
  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}

extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }
  
  String get capitalizeFirstOfEach {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$',
    );
    return emailRegExp.hasMatch(this);
  }
  
  bool get isValidPassword {
    return length >= 6;
  }
  
  String formatDate({String format = 'yyyy-MM-dd'}) {
    try {
      final date = DateTime.parse(this);
      return DateFormat(format).format(date);
    } catch (e) {
      return this;
    }
  }
}

extension DateTimeExtensions on DateTime {
  String format({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(this);
  }
}
''');
  print('📄 Created: lib/core/utils/extensions.dart');
  
  // widgets/custom_button.dart
  final buttonFile = File('lib/core/widgets/custom_button.dart');
  buttonFile.writeAsStringSync('''
// 🔘 Custom Button
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType buttonType;
  final Widget? icon;
  final double? width;
  final double? height;
  
  const CustomButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.buttonType = ButtonType.primary,
    this.icon,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final button = _buildButton(context);
    
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    
    return button;
  }
  
  Widget _buildButton(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildButtonContent(),
        );
      case ButtonType.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildButtonContent(),
        );
    }
  }
  
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            buttonType == ButtonType.outline || buttonType == ButtonType.text
                ? Theme.of(Get.context!).colorScheme.primary
                : Colors.white,
          ),
        ),
      );
    }
    
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      );
    }
    
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp),
    );
  }
}
''');
  print('📄 Created: lib/core/widgets/custom_button.dart');
  
  // widgets/custom_text_field.dart
  final textFieldFile = File('lib/core/widgets/custom_text_field.dart');
  textFieldFile.writeAsStringSync('''
// 📝 Custom Text Field
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextFieldType { text, email, password, number, phone }

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextFieldType textFieldType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final bool autofocus;
  final FocusNode? focusNode;
  
  const CustomTextField({
    this.labelText,
    this.hintText,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.textFieldType = TextFieldType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.autofocus = false,
    this.focusNode,
    Key? key,
  }) : super(key: key);
  
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = widget.controller ?? TextEditingController();
    
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }
  
  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: _getKeyboardType(),
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: _buildSuffixIcon(),
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
  
  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType!;
    }
    
    switch (widget.textFieldType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.text:
      default:
        return TextInputType.text;
    }
  }
  
  Widget? _buildSuffixIcon() {
    if (widget.textFieldType == TextFieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    
    return widget.suffixIcon;
  }
}
''');
  print('📄 Created: lib/core/widgets/custom_text_field.dart');
  
  // widgets/loading_widget.dart
  final loadingWidgetFile = File('lib/core/widgets/loading_widget.dart');
  loadingWidgetFile.writeAsStringSync('''
// ⏳ Loading Widget
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  
  const LoadingWidget({
    this.message,
    this.color,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
''');
  print('📄 Created: lib/core/widgets/loading_widget.dart');
  
  // widgets/error_widget.dart
  final errorWidgetFile = File('lib/core/widgets/error_widget.dart');
  errorWidgetFile.writeAsStringSync('''
// ❌ Error Widget
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;
  
  const ErrorWidget({
    required this.message,
    this.onRetry,
    this.retryText,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(retryText ?? 'Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
''');
  print('📄 Created: lib/core/widgets/error_widget.dart');
  
  // services/navigation_service.dart
  final navigationFile = File('lib/core/services/navigation_service.dart');
  navigationFile.writeAsStringSync('''
// 🧭 Navigation Service
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  BuildContext get context => navigatorKey.currentContext!;
  
  void push(String location, {Object? extra}) {
    GoRouter.of(context).push(location, extra: extra);
  }
  
  void go(String location, {Object? extra}) {
    GoRouter.of(context).go(location, extra: extra);
  }
  
  void pop() {
    navigatorKey.currentState!.pop();
  }
  
  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }
  
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
  
  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  
  Future<T?> showDialog<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }
  
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
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
import '../network/api_client.dart';
${enableTheming ? "import '../theme/theme_cubit.dart';" : ""}
${enableAnalytics ? "import '../analytics/analytics_service.dart';" : ""}

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // External
  // getIt.registerLazySingleton(() => InternetConnectionChecker());
  // getIt.registerLazySingleton(() => Connectivity());
  // getIt.registerLazySingleton(() => SharedPreferences.getInstance());
  
  // Core
  // getIt.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(
  //     getIt<InternetConnectionChecker>(),
  //     getIt<Connectivity>(),
  //   ),
  // );
  
  // getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  
  // Services
  ${enableTheming ? "getIt.registerFactory<ThemeCubit>(() => ThemeCubit());" : ""}
  ${enableAnalytics ? "getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());" : ""}
}
''');
  print('📄 Created: lib/core/services/locator_service.dart');
  
  // services/storage_service.dart
  final storageServiceFile = File('lib/core/services/storage_service.dart');
  storageServiceFile.writeAsStringSync('''
// 💾 Storage Service
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _prefs;
  
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // Generic methods
  Future<bool> set<T>(String key, T value) async {
    switch (T) {
      case String:
        return await _prefs.setString(key, value as String);
      case int:
        return await _prefs.setInt(key, value as int);
      case bool:
        return await _prefs.setBool(key, value as bool);
      case double:
        return await _prefs.setDouble(key, value as double);
      case List<String>:
        return await _prefs.setStringList(key, value as List<String>);
      default:
        throw Exception('Unsupported type');
    }
  }
  
  T? get<T>(String key) {
    switch (T) {
      case String:
        return _prefs.getString(key) as T?;
      case int:
        return _prefs.getInt(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case List<String>:
        return _prefs.getStringList(key) as T?;
      default:
        return null;
    }
  }
  
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  Future<bool> clear() async {
    return await _prefs.clear();
  }
  
  // Convenience methods
  Future<bool> setString(String key, String value) => set<String>(key, value);
  String? getString(String key) => get<String>(key);
  
  Future<bool> setInt(String key, int value) => set<int>(key, value);
  int? getInt(String key) => get<int>(key);
  
  Future<bool> setBool(String key, bool value) => set<bool>(key, value);
  bool? getBool(String key) => get<bool>(key);
  
  Future<bool> setDouble(String key, double value) => set<double>(key, value);
  double? getDouble(String key) => get<double>(key);
  
  Future<bool> setStringList(String key, List<String> value) => set<List<String>>(key, value);
  List<String>? getStringList(String key) => get<List<String>>(key);
}
''');
  print('📄 Created: lib/core/services/storage_service.dart');
  
  // usecases/usecase.dart
  final usecaseFile = File('lib/core/usecases/usecase.dart');
  usecaseFile.writeAsStringSync('''
// 🎯 Base Use Case
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class Params {
  final Map<String, dynamic> data;
  
  Params(this.data);
  
  T? get<T>(String key) => data[key] as T?;
  
  void set<T>(String key, T value) => data[key] = value;
}
''');
  print('📄 Created: lib/core/usecases/usecase.dart');
  
  // common/app_colors.dart
  final colorsFile = File('lib/core/common/app_colors.dart');
  colorsFile.writeAsStringSync('''
// 🎨 App Colors
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  
  // Additional colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  
  // Grayscale
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
}
''');
  print('📄 Created: lib/core/common/app_colors.dart');
  
  // common/app_text_styles.dart
  final textStylesFile = File('lib/core/common/app_text_styles.dart');
  textStylesFile.writeAsStringSync('''
// 📝 App Text Styles
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle headline4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle headline5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle headline6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
  );
  
  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );
}
''');
  print('📄 Created: lib/core/common/app_text_styles.dart');
}

void _createThemeService() {
  print('\n🎨 Creating theme service...');
  
  // theme_cubit.dart
  final themeCubitFile = File('lib/core/theme/theme_cubit.dart');
  themeCubitFile.writeAsStringSync('''
// 🎨 Theme Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/storage_service.dart';

enum AppTheme { light, dark, system }

class ThemeCubit extends Cubit<AppTheme> {
  final StorageService storageService;
  
  ThemeCubit({required this.storageService}) : super(AppTheme.system) {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    final themeIndex = storageService.getInt('theme_mode') ?? 2; // Default to system
    emit(AppTheme.values[themeIndex]);
  }
  
  Future<void> setTheme(AppTheme theme) async {
    emit(theme);
    await storageService.setInt('theme_mode', theme.index);
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
import 'package:flutter/services.dart';
import 'dart:convert';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
      
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  
  final Map<String, String> _localizedStrings;
  
  AppLocalizations(this._localizedStrings);
  
  // Common strings
  String get appName => _localizedStrings['app_name'] ?? 'Flutter App';
  String get welcome => _localizedStrings['welcome'] ?? 'Welcome';
  String get loading => _localizedStrings['loading'] ?? 'Loading...';
  String get error => _localizedStrings['error'] ?? 'Error';
  String get retry => _localizedStrings['retry'] ?? 'Retry';
  String get cancel => _localizedStrings['cancel'] ?? 'Cancel';
  String get confirm => _localizedStrings['confirm'] ?? 'Confirm';
  String get ok => _localizedStrings['ok'] ?? 'OK';
  String get yes => _localizedStrings['yes'] ?? 'Yes';
  String get no => _localizedStrings['no'] ?? 'No';
  
  // Settings
  String get settings => _localizedStrings['settings'] ?? 'Settings';
  String get theme => _localizedStrings['theme'] ?? 'Theme';
  String get language => _localizedStrings['language'] ?? 'Language';
  String get lightTheme => _localizedStrings['light_theme'] ?? 'Light';
  String get darkTheme => _localizedStrings['dark_theme'] ?? 'Dark';
  String get systemTheme => _localizedStrings['system_theme'] ?? 'System';
  String get english => _localizedStrings['english'] ?? 'English';
  String get arabic => _localizedStrings['arabic'] ?? 'Arabic';
  
  // Navigation
  String get backToHome => _localizedStrings['back_to_home'] ?? 'Back to Home';
  String get home => _localizedStrings['home'] ?? 'Home';
  String get profile => _localizedStrings['profile'] ?? 'Profile';
  
  // Auth
  String get login => _localizedStrings['login'] ?? 'Login';
  String get register => _localizedStrings['register'] ?? 'Register';
  String get logout => _localizedStrings['logout'] ?? 'Logout';
  String get email => _localizedStrings['email'] ?? 'Email';
  String get password => _localizedStrings['password'] ?? 'Password';
  String get confirmPassword => _localizedStrings['confirm_password'] ?? 'Confirm Password';
  String get forgotPassword => _localizedStrings['forgot_password'] ?? 'Forgot Password?';
  String get invalidEmail => _localizedStrings['invalid_email'] ?? 'Please enter a valid email';
  String get invalidPassword => _localizedStrings['invalid_password'] ?? 'Password must be at least 6 characters';
  String get passwordsDoNotMatch => _localizedStrings['passwords_do_not_match'] ?? 'Passwords do not match';
  
  // Validation
  String get requiredField => _localizedStrings['required_field'] ?? 'This field is required';
  String get invalidInput => _localizedStrings['invalid_input'] ?? 'Invalid input';
  
  // Errors
  String get networkError => _localizedStrings['network_error'] ?? 'Network error. Please check your connection.';
  String get serverError => _localizedStrings['server_error'] ?? 'Server error. Please try again later.';
  String get unauthorizedError => _localizedStrings['unauthorized_error'] ?? 'Unauthorized. Please login again.';
  String get forbiddenError => _localizedStrings['forbidden_error'] ?? 'You don\'t have permission to access this resource.';
  String get notFoundError => _localizedStrings['not_found_error'] ?? 'Resource not found.';
  String get unknownError => _localizedStrings['unknown_error'] ?? 'An unknown error occurred.';
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
      'assets/l10n/\${locale.languageCode}.json',
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
  
  // language_cubit.dart
  final languageCubitFile = File('lib/core/l10n/language_cubit.dart');
  languageCubitFile.writeAsStringSync('''
// 🌐 Language Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LanguageCubit extends Cubit<Locale> {
  final StorageService storageService;
  
  LanguageCubit({required this.storageService}) 
    : super(const Locale('en')) {
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final languageCode = storageService.getString('language') ?? 'en';
    emit(Locale(languageCode));
  }
  
  Future<void> changeLanguage(String languageCode) async {
    emit(Locale(languageCode));
    await storageService.setString('language', languageCode);
  }
}
''');
  print('📄 Created: lib/core/l10n/language_cubit.dart');
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
  "loading": "Loading...",
  "error": "Error",
  "retry": "Retry",
  "cancel": "Cancel",
  "confirm": "Confirm",
  "ok": "OK",
  "yes": "Yes",
  "no": "No",
  "settings": "Settings",
  "theme": "Theme",
  "language": "Language",
  "light_theme": "Light",
  "dark_theme": "Dark",
  "system_theme": "System",
  "english": "English",
  "arabic": "Arabic",
  "back_to_home": "Back to Home",
  "home": "Home",
  "profile": "Profile",
  "login": "Login",
  "register": "Register",
  "logout": "Logout",
  "email": "Email",
  "password": "Password",
  "confirm_password": "Confirm Password",
  "forgot_password": "Forgot Password?",
  "invalid_email": "Please enter a valid email",
  "invalid_password": "Password must be at least 6 characters",
  "passwords_do_not_match": "Passwords do not match",
  "required_field": "This field is required",
  "invalid_input": "Invalid input",
  "network_error": "Network error. Please check your connection.",
  "server_error": "Server error. Please try again later.",
  "unauthorized_error": "Unauthorized. Please login again.",
  "forbidden_error": "You don't have permission to access this resource.",
  "not_found_error": "Resource not found.",
  "unknown_error": "An unknown error occurred."
}
''');
  print('📄 Created: assets/l10n/en.json');
  
  // ar.json
  final arJsonFile = File('assets/l10n/ar.json');
  arJsonFile.writeAsStringSync('''
{
  "app_name": "تطبيق فلاتر",
  "welcome": "مرحبا",
  "loading": "جاري التحميل...",
  "error": "خطأ",
  "retry": "إعادة المحاولة",
  "cancel": "إلغاء",
  "confirm": "تأكيد",
  "ok": "موافق",
  "yes": "نعم",
  "no": "لا",
  "settings": "الإعدادات",
  "theme": "السمة",
  "language": "اللغة",
  "light_theme": "فاتح",
  "dark_theme": "داكن",
  "system_theme": "النظام",
  "english": "الإنجليزية",
  "arabic": "العربية",
  "back_to_home": "العودة للرئيسية",
  "home": "الرئيسية",
  "profile": "الملف الشخصي",
  "login": "تسجيل الدخول",
  "register": "إنشاء حساب",
  "logout": "تسجيل الخروج",
  "email": "البريد الإلكتروني",
  "password": "كلمة المرور",
  "confirm_password": "تأكيد كلمة المرور",
  "forgot_password": "نسيت كلمة المرور؟",
  "invalid_email": "يرجى إدخال بريد إلكتروني صحيح",
  "invalid_password": "كلمة المرور يجب أن تكون 6 أحرف على الأقل",
  "passwords_do_not_match": "كلمتا المرور غير متطابقتين",
  "required_field": "هذا الحقل مطلوب",
  "invalid_input": "إدخال غير صحيح",
  "network_error": "خطأ في الشبكة. يرجى التحقق من اتصالك.",
  "server_error": "خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقاً.",
  "unauthorized_error": "غير مصرح. يرجى تسجيل الدخول مرة أخرى.",
  "forbidden_error": "ليس لديك إذن للوصول إلى هذا المورد.",
  "not_found_error": "المورد غير موجود.",
  "unknown_error": "حدث خطأ غير معروف."
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

void _createAnalyticsService() {
  print('\n📊 Creating analytics service...');
  
  // analytics_service.dart
  final analyticsServiceFile = File('lib/core/analytics/analytics_service.dart');
  analyticsServiceFile.writeAsStringSync('''
// 📊 Analytics Service
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  
  factory AnalyticsService() {
    return _instance;
  }
  
  AnalyticsService._internal();
  
  late FirebaseAnalytics _analytics;
  late FirebaseAnalyticsObserver _observer;
  
  FirebaseAnalyticsObserver get observer => _observer;
  
  Future<void> init() async {
    _analytics = FirebaseAnalytics.instance;
    _observer = FirebaseAnalyticsObserver(analytics: _analytics);
    await _analytics.setAnalyticsCollectionEnabled(true);
  }
  
  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }
  
  Future<void> logLogin({String? loginMethod}) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }
  
  Future<void> logSignUp({String? signUpMethod}) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod);
  }
  
  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
  
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
  }
  
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }
  
  Future<void> setCurrentScreen({
    required String screenName,
    String screenClassOverride = 'Flutter',
  }) async {
    await _analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClassOverride,
    );
  }
  
  void sendScreenView(BuildContext context) {
    _observer.observer(
      RouteSettings(name: ModalRoute.of(context)!.settings.name),
      Route<dynamic>(
        settings: RouteSettings(name: ModalRoute.of(context)!.settings.name),
      ),
    );
  }
}
''');
  print('📄 Created: lib/core/analytics/analytics_service.dart');
}

void _createAuthFeature() {
  print('\n🔐 Creating auth feature...');
  
  // Create auth directory
  final authDir = Directory('lib/features/auth');
  if (!authDir.existsSync()) {
    authDir.createSync(recursive: true);
    print('📁 Created: lib/features/auth/');
  }
  
  // Create auth structure
  final authDirs = [
    'lib/features/auth/data/datasources',
    'lib/features/auth/data/models',
    'lib/features/auth/data/repositories',
    'lib/features/auth/domain/entities',
    'lib/features/auth/domain/repositories',
    'lib/features/auth/domain/usecases',
    'lib/features/auth/presentation/cubit',
    'lib/features/auth/presentation/pages',
    'lib/features/auth/presentation/widgets',
  ];
  
  for (final dir in authDirs) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
  
  // Create auth files
  _createAuthFiles();
  
  // Update app router
  _updateAppRouterForAuth();
  
  // Update dependency injection
  _updateDependencyInjectionForAuth();
}

void _createAuthFiles() {
  // Entity
  final userEntityFile = File('lib/features/auth/domain/entities/user_entity.dart');
  userEntityFile.writeAsStringSync('''
// 👤 User Entity
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object> get props => [id, name, email, isActive, createdAt, updatedAt];
}
''');
  print('📄 Created: lib/features/auth/domain/entities/user_entity.dart');
  
  // Model
  final userModelFile = File('lib/features/auth/data/models/user_model.dart');
  userModelFile.writeAsStringSync('''
// 👤 User Model
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? avatar,
    bool isActive = true,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatar: avatar,
          isActive: isActive,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
''');
  print('📄 Created: lib/features/auth/data/models/user_model.dart');
  
  // Login Request Model
  final loginRequestModelFile = File('lib/features/auth/data/models/login_request_model.dart');
  loginRequestModelFile.writeAsStringSync('''
// 🔑 Login Request Model
class LoginRequestModel {
  final String email;
  final String password;
  
  const LoginRequestModel({
    required this.email,
    required this.password,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
''');
  print('📄 Created: lib/features/auth/data/models/login_request_model.dart');
  
  // Register Request Model
  final registerRequestModelFile = File('lib/features/auth/data/models/register_request_model.dart');
  registerRequestModelFile.writeAsStringSync('''
// 📝 Register Request Model
class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  
  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }
}
''');
  print('📄 Created: lib/features/auth/data/models/register_request_model.dart');
  
  // Auth Response Model
  final authResponseModelFile = File('lib/features/auth/data/models/auth_response_model.dart');
  authResponseModelFile.writeAsStringSync('''
// 🔐 Auth Response Model
import 'user_model.dart';

class AuthResponseModel {
  final UserModel user;
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  
  const AuthResponseModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });
  
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
    };
  }
}
''');
  print('📄 Created: lib/features/auth/data/models/auth_response_model.dart');
  
  // Auth Repository
  final authRepositoryFile = File('lib/features/auth/domain/repositories/auth_repository.dart');
  authRepositoryFile.writeAsStringSync('''
// 🔐 Auth Repository
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/params/login_params.dart';
import '../usecases/params/register_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, UserEntity>> register(RegisterParams params);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, String>> refreshToken();
  Future<Either<Failure, bool>> forgotPassword(String email);
  Future<Either<Failure, bool>> resetPassword(String token, String password, String confirmPassword);
}
''');
  print('📄 Created: lib/features/auth/domain/repositories/auth_repository.dart');
  
  // Auth Repository Implementation
  final authRepositoryImplFile = File('lib/features/auth/data/repositories/auth_repository_impl.dart');
  authRepositoryImplFile.writeAsStringSync('''
// 🔐 Auth Repository Implementation
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/params/login_params.dart';
import '../../domain/usecases/params/register_params.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/auth_response_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final request = LoginRequestModel(
        email: params.email,
        password: params.password,
      );
      
      final response = await remoteDataSource.login(request);
      await localDataSource.saveAuthData(response);
      
      return Right(response.user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    try {
      final request = RegisterRequestModel(
        name: params.name,
        email: params.email,
        password: params.password,
        confirmPassword: params.confirmPassword,
      );
      
      final response = await remoteDataSource.register(request);
      await localDataSource.saveAuthData(response);
      
      return Right(response.user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, errors: e.errors));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearAuthData();
      
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();
      
      if (user != null) {
        return Right(user);
      } else {
        return Left(const AuthenticationFailure('No user found'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final isAuthenticated = await localDataSource.hasToken();
      
      return Right(isAuthenticated);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> refreshToken() async {
    try {
      final token = await localDataSource.refreshToken();
      
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> resetPassword(String token, String password, String confirmPassword) async {
    try {
      await remoteDataSource.resetPassword(token, password, confirmPassword);
      
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, errors: e.errors));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
''');
  print('📄 Created: lib/features/auth/data/repositories/auth_repository_impl.dart');
  
  // Auth Remote Data Source
  final authRemoteDataSourceFile = File('lib/features/auth/data/datasources/auth_remote_datasource.dart');
  authRemoteDataSourceFile.writeAsStringSync('''
// 🌐 Auth Remote Data Source
import '../../../../core/network/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/auth_response_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel request);
  Future<AuthResponseModel> register(RegisterRequestModel request);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String password, String confirmPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  
  const AuthRemoteDataSourceImpl({required this.apiClient});
  
  @override
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final response = await apiClient.post(
      '/auth/login',
      data: request.toJson(),
    );
    
    return AuthResponseModel.fromJson(response.data);
  }
  
  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    final response = await apiClient.post(
      '/auth/register',
      data: request.toJson(),
    );
    
    return AuthResponseModel.fromJson(response.data);
  }
  
  @override
  Future<void> logout() async {
    await apiClient.post('/auth/logout');
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    await apiClient.post(
      '/auth/forgot-password',
      data: {'email': email},
    );
  }
  
  @override
  Future<void> resetPassword(String token, String password, String confirmPassword) async {
    await apiClient.post(
      '/auth/reset-password',
      data: {
        'token': token,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
  }
}
''');
  print('📄 Created: lib/features/auth/data/datasources/auth_remote_datasource.dart');
  
  // Auth Local Data Source
  final authLocalDataSourceFile = File('lib/features/auth/data/datasources/auth_local_datasource.dart');
  authLocalDataSourceFile.writeAsStringSync('''
// 💾 Auth Local Data Source
import '../../../../core/services/storage_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(AuthResponseModel authResponse);
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<void> saveUser(UserModel user);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<UserModel?> getCurrentUser();
  Future<bool> hasToken();
  Future<String> refreshToken();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService storageService;
  
  const AuthLocalDataSourceImpl({required this.storageService});
  
  @override
  Future<void> saveAuthData(AuthResponseModel authResponse) async {
    await saveAccessToken(authResponse.accessToken);
    await saveRefreshToken(authResponse.refreshToken);
    await saveUser(authResponse.user);
  }
  
  @override
  Future<void> saveAccessToken(String token) async {
    final result = await storageService.setString('access_token', token);
    if (!result) {
      throw CacheException('Failed to save access token');
    }
  }
  
  @override
  Future<void> saveRefreshToken(String token) async {
    final result = await storageService.setString('refresh_token', token);
    if (!result) {
      throw CacheException('Failed to save refresh token');
    }
  }
  
  @override
  Future<void> saveUser(UserModel user) async {
    final result = await storageService.setString('user_data', user.toJson().toString());
    if (!result) {
      throw CacheException('Failed to save user data');
    }
  }
  
  @override
  Future<String?> getAccessToken() async {
    return storageService.getString('access_token');
  }
  
  @override
  Future<String?> getRefreshToken() async {
    return storageService.getString('refresh_token');
  }
  
  @override
  Future<UserModel?> getCurrentUser() async {
    final userJson = storageService.getString('user_data');
    if (userJson == null) return null;
    
    try {
      final userMap = Map<String, dynamic>.from(
        Map<String, dynamic>.from(userJson),
      );
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw CacheException('Failed to parse user data');
    }
  }
  
  @override
  Future<bool> hasToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
  
  @override
  Future<String> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw AuthenticationException('No refresh token available');
    }
    
    // TODO: Implement token refresh logic
    // This would typically involve making an API call to refresh the token
    throw UnimplementedError();
  }
  
  @override
  Future<void> clearAuthData() async {
    await storageService.remove('access_token');
    await storageService.remove('refresh_token');
    await storageService.remove('user_data');
  }
}
''');
  print('📄 Created: lib/features/auth/data/datasources/auth_local_datasource.dart');
  
  // Login Params
  final loginParamsFile = File('lib/features/auth/domain/usecases/params/login_params.dart');
  loginParamsFile.writeAsStringSync('''
// 🔑 Login Params
class LoginParams {
  final String email;
  final String password;
  
  const LoginParams({
    required this.email,
    required this.password,
  });
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/params/login_params.dart');
  
  // Register Params
  final registerParamsFile = File('lib/features/auth/domain/usecases/params/register_params.dart');
  registerParamsFile.writeAsStringSync('''
// 📝 Register Params
class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/params/register_params.dart');
  
  // Login Use Case
  final loginUseCaseFile = File('lib/features/auth/domain/usecases/login_usecase.dart');
  loginUseCaseFile.writeAsStringSync('''
// 🔑 Login Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';
import 'params/login_params.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  
  const LoginUseCase(this.repository);
  
  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return repository.login(params);
  }
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/login_usecase.dart');
  
  // Register Use Case
  final registerUseCaseFile = File('lib/features/auth/domain/usecases/register_usecase.dart');
  registerUseCaseFile.writeAsStringSync('''
// 📝 Register Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';
import 'params/register_params.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;
  
  const RegisterUseCase(this.repository);
  
  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return repository.register(params);
  }
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/register_usecase.dart');
  
  // Logout Use Case
  final logoutUseCaseFile = File('lib/features/auth/domain/usecases/logout_usecase.dart');
  logoutUseCaseFile.writeAsStringSync('''
// 🚪 Logout Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  
  const LogoutUseCase(this.repository);
  
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.logout();
  }
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/logout_usecase.dart');
  
  // Get Current User Use Case
  final getCurrentUserUseCaseFile = File('lib/features/auth/domain/usecases/get_current_user_usecase.dart');
  getCurrentUserUseCaseFile.writeAsStringSync('''
// 👤 Get Current User Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  
  const GetCurrentUserUseCase(this.repository);
  
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return repository.getCurrentUser();
  }
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/get_current_user_usecase.dart');
  
  // Is Authenticated Use Case
  final isAuthenticatedUseCaseFile = File('lib/features/auth/domain/usecases/is_authenticated_usecase.dart');
  isAuthenticatedUseCaseFile.writeAsStringSync('''
// 🔐 Is Authenticated Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class IsAuthenticatedUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  
  const IsAuthenticatedUseCase(this.repository);
  
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.isAuthenticated();
  }
}
''');
  print('📄 Created: lib/features/auth/domain/usecases/is_authenticated_usecase.dart');
  
  // Auth Cubit
  final authCubitFile = File('lib/features/auth/presentation/cubit/auth_cubit.dart');
  authCubitFile.writeAsStringSync('''
// 🔐 Auth Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/is_authenticated_usecase.dart';
import '../../domain/usecases/params/login_params.dart';
import '../../domain/usecases/params/register_params.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsAuthenticatedUseCase isAuthenticatedUseCase;
  
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.isAuthenticatedUseCase,
  }) : super(const AuthInitial()) {
    _checkAuthStatus();
  }
  
  Future<void> _checkAuthStatus() async {
    emit(const AuthLoading());
    
    final isAuthenticatedResult = await isAuthenticatedUseCase(NoParams());
    
    isAuthenticatedResult.fold(
      (failure) => emit(AuthUnauthenticated()),
      (isAuthenticated) async {
        if (isAuthenticated) {
          await _loadCurrentUser();
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }
  
  Future<void> _loadCurrentUser() async {
    final userResult = await getCurrentUserUseCase(NoParams());
    
    userResult.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(Authenticated(user)),
    );
  }
  
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    
    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
      ),
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }
  
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(const AuthLoading());
    
    final result = await registerUseCase(
      RegisterParams(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }
  
  Future<void> logout() async {
    emit(const AuthLoading());
    
    final result = await logoutUseCase(NoParams());
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
  
  void clearError() {
    emit(const AuthInitial());
  }
}
''');
  print('📄 Created: lib/features/auth/presentation/cubit/auth_cubit.dart');
  
  // Auth State
  final authStateFile = File('lib/features/auth/presentation/cubit/auth_state.dart');
  authStateFile.writeAsStringSync('''
// 🔐 Auth State
part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final UserEntity user;
  
  const Authenticated(this.user);
  
  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);
  
  @override
  List<Object> get props => [message];
}
''');
  print('📄 Created: lib/features/auth/presentation/cubit/auth_state.dart');
  
  // Login Page
  final loginPageFile = File('lib/features/auth/presentation/pages/login_page.dart');
  loginPageFile.writeAsStringSync('''
// 🔑 Login Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:formz/formz.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/extensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  static const String routeName = '/login';
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/');
          } else if (state is AuthError) {
            context.showSnackBar(state.message, backgroundColor: Colors.red);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.login,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    controller: _emailController,
                    labelText: l10n.email,
                    hintText: 'example@email.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.requiredField;
                      }
                      if (!value.isValidEmail) {
                        return l10n.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: l10n.password,
                    hintText: '••••••••',
                    textFieldType: TextFieldType.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.requiredField;
                      }
                      if (!value.isValidPassword) {
                        return l10n.invalidPassword;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push('/forgot-password');
                      },
                      child: Text(l10n.forgotPassword),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: l10n.login,
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.register),
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text(l10n.register),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/auth/presentation/pages/login_page.dart');
  
  // Register Page
  final registerPageFile = File('lib/features/auth/presentation/pages/register_page.dart');
  registerPageFile.writeAsStringSync('''
// 📝 Register Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/extensions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  
  static const String routeName = '/register';
  
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/');
          } else if (state is AuthError) {
            context.showSnackBar(state.message, backgroundColor: Colors.red);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.register,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      controller: _nameController,
                      labelText: 'Name',
                      hintText: 'John Doe',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.requiredField;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _emailController,
                      labelText: l10n.email,
                      hintText: 'example@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.requiredField;
                        }
                        if (!value.isValidEmail) {
                          return l10n.invalidEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: l10n.password,
                      hintText: '••••••••',
                      textFieldType: TextFieldType.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.requiredField;
                        }
                        if (!value.isValidPassword) {
                          return l10n.invalidPassword;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: l10n.confirmPassword,
                      hintText: '••••••••',
                      textFieldType: TextFieldType.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.requiredField;
                        }
                        if (value != _passwordController.text) {
                          return l10n.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: l10n.register,
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().register(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword: _confirmPasswordController.text,
                                  );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            context.push('/login');
                          },
                          child: Text(l10n.login),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/auth/presentation/pages/register_page.dart');
  
  // Forgot Password Page
  final forgotPasswordPageFile = File('lib/features/auth/presentation/pages/forgot_password_page.dart');
  forgotPasswordPageFile.writeAsStringSync('''
// 🔑 Forgot Password Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/extensions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  
  static const String routeName = '/forgot-password';
  
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isEmailSent = false;
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.forgotPassword),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            context.showSnackBar(state.message, backgroundColor: Colors.red);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!_isEmailSent) ...[
                    Text(
                      l10n.forgotPassword,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Enter your email address and we\'ll send you a link to reset your password.',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      controller: _emailController,
                      labelText: l10n.email,
                      hintText: 'example@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.requiredField;
                        }
                        if (!value.isValidEmail) {
                          return l10n.invalidEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: 'Send Reset Link',
                          isLoading: state is AuthLoading,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // In a real app, you would call the forgotPassword use case here
                              // For now, we'll just simulate it
                              setState(() {
                                _isEmailSent = true;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ] else ...[
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 80.sp,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Email Sent!',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'We\'ve sent a password reset link to your email address.',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      text: 'Back to Login',
                      onPressed: () {
                        context.push('/login');
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/auth/presentation/pages/forgot_password_page.dart');
  
  // Auth Injection
  final authInjectionFile = File('lib/features/auth/auth_injection.dart');
  authInjectionFile.writeAsStringSync('''
// 🔐 Auth Feature Injection
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/services/storage_service.dart';
import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_current_user_usecase.dart';
import '../domain/usecases/is_authenticated_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../presentation/cubit/auth_cubit.dart';

Future<void> initAuthFeature() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Core
  getIt.registerLazySingleton<StorageService>(() => StorageService()..init());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  
  // Data sources
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );
  
  getIt.registerFactory<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storageService: getIt<StorageService>()),
  );
  
  // Repositories
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );
  
  // Use cases
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<IsAuthenticatedUseCase>(
    () => IsAuthenticatedUseCase(getIt<AuthRepository>()),
  );
  
  // Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      isAuthenticatedUseCase: getIt<IsAuthenticatedUseCase>(),
    ),
  );
}
''');
  print('📄 Created: lib/features/auth/auth_injection.dart');
}

void _updateAppRouterForAuth() {
  final routerFile = File('lib/app_router.dart');
  if (!routerFile.existsSync()) return;
  
  final content = routerFile.readAsStringSync();
  
  // Check if auth routes already exist
  if (content.contains('LoginPage')) {
    return;
  }
  
  // Add auth routes
  final authRoutes = '''
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
''';
  
  // Add import
  final updatedContent = content.replaceFirst(
    'import \'package:go_router/go_router.dart\';',
    'import \'package:go_router/go_router.dart\';\nimport \'package:your_app/features/auth/presentation/pages/login_page.dart\';\nimport \'package:your_app/features/auth/presentation/pages/register_page.dart\';\nimport \'package:your_app/features/auth/presentation/pages/forgot_password_page.dart\';',
  );
  
  // Insert new routes before closing bracket
  final finalContent = updatedContent.replaceFirst(
    '    ],',
    '$authRoutes    ],',
  );
  
  routerFile.writeAsStringSync(finalContent);
  print('📄 Updated: lib/app_router.dart with auth routes');
}

void _updateDependencyInjectionForAuth() {
  final diFile = File('lib/dependency_injection.dart');
  if (!diFile.existsSync()) return;
  
  final content = diFile.readAsStringSync();
  
  // Add auth import and initialization
  if (!content.contains('initAuthFeature')) {
    final updatedContent = content.replaceFirst(
      'Future<void> initializeDependencies() async {\n  await setupLocator();',
      'Future<void> initializeDependencies() async {\n  await setupLocator();\n\n  // Register features\n  await initAuthFeature();',
    );
    
    diFile.writeAsStringSync(updatedContent);
    print('📄 Updated: lib/dependency_injection.dart with auth feature');
  }
}

void _createSettingsFeature(bool enableLocalization, bool enableTheming) {
  print('\n⚙️ Creating settings feature...');
  
  // Create settings directory
  final settingsDir = Directory('lib/features/settings');
  if (!settingsDir.existsSync()) {
    settingsDir.createSync(recursive: true);
    print('📁 Created: lib/features/settings/');
  }
  
  // Create settings structure
  final settingsDirs = [
    'lib/features/settings/presentation/cubit',
    'lib/features/settings/presentation/pages',
  ];
  
  for (final dir in settingsDirs) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
  
  // Create settings files
  _createSettingsFiles(enableLocalization, enableTheming);
  
  // Update app router
  _updateAppRouterForSettings();
  
  // Update dependency injection
  _updateDependencyInjectionForSettings();
}

void _createSettingsFiles(bool enableLocalization, bool enableTheming) {
  // settings_cubit.dart
  final settingsCubitFile = File('lib/features/settings/presentation/cubit/settings_cubit.dart');
  settingsCubitFile.writeAsStringSync('''
// ⚙️ Settings Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
${enableTheming ? "import '../../../../core/theme/theme_cubit.dart';" : ""}
${enableLocalization ? "import '../../../../core/l10n/language_cubit.dart';" : ""}

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  ${enableTheming ? "final ThemeCubit themeCubit;" : ""}
  ${enableLocalization ? "final LanguageCubit languageCubit;" : ""}
  
  SettingsCubit({
    ${enableTheming ? "required this.themeCubit," : ""}
    ${enableLocalization ? "required this.languageCubit," : ""}
  }) : super(SettingsInitial()) {
    _loadSettings();
  }
  
  void _loadSettings() {
    ${enableTheming ? "emit(state.copyWith(themeMode: themeCubit.state));" : ""}
    ${enableLocalization ? "emit(state.copyWith(locale: languageCubit.state));" : ""}
  }
  
  ${enableTheming ? """
  Future<void> setTheme(AppTheme theme) async {
    await themeCubit.setTheme(theme);
    emit(state.copyWith(themeMode: theme));
  }
  """ : ""}
  
  ${enableLocalization ? """
  Future<void> setLanguage(String languageCode) async {
    await languageCubit.changeLanguage(languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }
  """ : ""}
}
''');
  print('📄 Created: lib/features/settings/presentation/cubit/settings_cubit.dart');
  
  // settings_state.dart
  final settingsStateFile = File('lib/features/settings/presentation/cubit/settings_state.dart');
  settingsStateFile.writeAsStringSync('''
// ⚙️ Settings State
part of 'settings_cubit.dart';
${enableTheming ? "import '../../../../core/theme/theme_cubit.dart';" : ""}
${enableLocalization ? "import 'package:flutter/material.dart';" : ""}

class SettingsState extends Equatable {
  ${enableTheming ? "final AppTheme? themeMode;" : ""}
  ${enableLocalization ? "final Locale? locale;" : ""}
  
  const SettingsState({
    ${enableTheming ? "this.themeMode," : ""}
    ${enableLocalization ? "this.locale," : ""}
  });
  
  SettingsState copyWith({
    ${enableTheming ? "AppTheme? themeMode," : ""}
    ${enableLocalization ? "Locale? locale," : ""}
  }) {
    return SettingsState(
      ${enableTheming ? "themeMode: themeMode ?? this.themeMode," : ""}
      ${enableLocalization ? "locale: locale ?? this.locale," : ""}
    );
  }
  
  @override
  List<Object?> get props => [
    ${enableTheming ? "themeMode," : ""}
    ${enableLocalization ? "locale," : ""}
  ];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}
''');
  print('📄 Created: lib/features/settings/presentation/cubit/settings_state.dart');
  
  // settings_page.dart
  final settingsPageFile = File('lib/features/settings/presentation/pages/settings_page.dart');
  settingsPageFile.writeAsStringSync('''
// 📱 Settings Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../../../../core/l10n/app_localizations.dart';
${enableTheming ? "import '../../../../core/theme/theme_cubit.dart';" : ""}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  
  static const String routeName = '/settings';
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocProvider(
      create: (context) => SettingsCubit(
        ${enableTheming ? "themeCubit: context.read<ThemeCubit>()," : ""}
        ${enableLocalization ? "languageCubit: context.read<LanguageCubit>()," : ""}
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.settings),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                ${enableTheming ? """
                _buildSectionTitle(context, l10n.theme),
                _buildThemeOptions(context, state),
                SizedBox(height: 24.h),
                """ : ""}
                ${enableLocalization ? """
                _buildSectionTitle(context, l10n.language),
                _buildLanguageOptions(context, state),
                SizedBox(height: 24.h),
                """ : ""}
                _buildSectionTitle(context, 'About'),
                _buildAboutCard(context),
              ],
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  ${enableTheming ? """
  Widget _buildThemeOptions(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: Column(
        children: [
          RadioListTile<AppTheme>(
            title: Text(l10n.lightTheme),
            value: AppTheme.light,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setTheme(value!);
            },
          ),
          RadioListTile<AppTheme>(
            title: Text(l10n.darkTheme),
            value: AppTheme.dark,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setTheme(value!);
            },
          ),
          RadioListTile<AppTheme>(
            title: Text(l10n.systemTheme),
            value: AppTheme.system,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setTheme(value!);
            },
          ),
        ],
      ),
    );
  }
  """ : ""}
  
  ${enableLocalization ? """
  Widget _buildLanguageOptions(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(l10n.english),
            trailing: Radio<String>(
              value: 'en',
              groupValue: state.locale?.languageCode,
              onChanged: (value) {
                context.read<SettingsCubit>().setLanguage(value!);
              },
            ),
            onTap: () {
              context.read<SettingsCubit>().setLanguage('en');
            },
          ),
          ListTile(
            title: Text(l10n.arabic),
            trailing: Radio<String>(
              value: 'ar',
              groupValue: state.locale?.languageCode,
              onChanged: (value) {
                context.read<SettingsCubit>().setLanguage(value!);
              },
            ),
            onTap: () {
              context.read<SettingsCubit>().setLanguage('ar');
            },
          ),
        ],
      ),
    );
  }
  """ : ""}
  
  Widget _buildAboutCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: ListTile(
        title: Text(l10n.appName),
        subtitle: Text('Version 1.0.0'),
        trailing: Icon(Icons.info_outline),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/settings/presentation/pages/settings_page.dart');
  
  // settings_injection.dart
  final settingsInjectionFile = File('lib/features/settings/settings_injection.dart');
  settingsInjectionFile.writeAsStringSync('''
// ⚙️ Settings Feature Injection
import 'package:get_it/get_it.dart';
${enableTheming ? "import '../../core/theme/theme_cubit.dart';" : ""}
${enableLocalization ? "import '../../core/l10n/language_cubit.dart';" : ""}
import 'presentation/cubit/settings_cubit.dart';

Future<void> initSettingsFeature() async {
  // Cubit
  getIt.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      ${enableTheming ? "themeCubit: getIt<ThemeCubit>()," : ""}
      ${enableLocalization ? "languageCubit: getIt<LanguageCubit>()," : ""}
    ),
  );
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
      '// Register features',
      '// Register features\n  await initSettingsFeature();',
    );
    
    diFile.writeAsStringSync(updatedContent);
    print('📄 Updated: lib/dependency_injection.dart with settings feature');
  }
}

void _createMainFile(String projectName, bool enableLocalization, bool enableTheming, bool enableAnalytics) {
  final mainFile = File('lib/main.dart');
  mainFile.writeAsStringSync('''
// 🚀 App Entry Point
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
${enableLocalization ? "import 'package:flutter_localizations/flutter_localizations.dart';" : ""}
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
${enableAnalytics ? "import 'package:firebase_core/firebase_core.dart';" : ""}
import 'app_router.dart';
import 'core/services/locator_service.dart';
import 'core/services/navigation_service.dart';
${enableTheming ? "import 'core/theme/theme_cubit.dart';" : ""}
${enableLocalization ? "import 'core/l10n/app_localizations.dart';" : ""}
${enableLocalization ? "import 'core/l10n/language_cubit.dart';" : ""}
${enableAnalytics ? "import 'core/analytics/analytics_service.dart';" : ""}
import 'dependency_injection.dart';
${enableTheming ? "import 'core/utils/themes.dart';" : ""}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  ${enableAnalytics ? "await Firebase.initializeApp();" : ""}
  
  await setupLocator();
  await initializeDependencies();
  
  ${enableAnalytics ? "final analyticsService = getIt<AnalyticsService>();\n  await analyticsService.init();" : ""}
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ${enableTheming ? "BlocProvider(create: (context) => getIt<ThemeCubit>())," : ""}
        ${enableLocalization ? "BlocProvider(create: (context) => getIt<LanguageCubit>())," : ""}
      ],
      child: ${enableTheming ? "BlocBuilder<ThemeCubit, AppTheme>(" : ""}(
        ${enableTheming ? "builder: (context, themeMode) {" : ""}
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                title: '$projectName',
                ${enableTheming ? """
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: _getThemeMode(themeMode),
                """ : ""}
                ${enableLocalization ? """
                locale: context.watch<LanguageCubit>().state,
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
                """ : ""}
                ${enableAnalytics ? "navigatorObservers: [getIt<AnalyticsService>().observer]," : ""}
              );
            },
          );
        ${enableTheming ? "}," : ""}
      ${enableTheming ? ")" : ""},
    );
  }
  
  ${enableTheming ? """
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
  """ : ""}
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
import 'core/services/navigation_service.dart';
import 'core/services/locator_service.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: getIt<NavigationService>().navigatorKey,
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
  
  // Register features
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
  
  stdout.write('🔤 Enter feature display name (e.g., User Profile): ');
  final featureDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(featureName);
  
  stdout.write('📊 Include API integration? (y/n): ');
  final includeApi = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
  stdout.write('💾 Include local storage? (y/n): ');
  final includeStorage = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
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
  _createFeatureStructure(snakeCase, pascalCase, includeApi, includeStorage);
  
  // Create feature files
  _createFeatureFiles(snakeCase, pascalCase, featureDisplayName, includeApi, includeStorage);
  
  // Update app router
  _updateAppRouter(snakeCase, pascalCase);
  
  // Update dependency injection
  _updateDependencyInjection(snakeCase, pascalCase);
  
  print('\n✅ Feature "$featureName" created successfully!');
  print('\n📁 Feature structure:');
  print('lib/features/$snakeCase/');
  print('├── data/');
  if (includeApi) print('│   ├── datasources/');
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

void _createFeatureStructure(String snakeCase, String pascalCase, bool includeApi, bool includeStorage) {
  final directories = [
    'lib/features/$snakeCase/data/models',
    'lib/features/$snakeCase/data/repositories',
    'lib/features/$snakeCase/domain/entities',
    'lib/features/$snakeCase/domain/repositories',
    'lib/features/$snakeCase/domain/usecases',
    'lib/features/$snakeCase/presentation/cubit',
    'lib/features/$snakeCase/presentation/pages',
    'lib/features/$snakeCase/presentation/widgets',
  ];
  
  if (includeApi) {
    directories.add('lib/features/$snakeCase/data/datasources');
  }
  
  if (includeStorage) {
    directories.add('lib/features/$snakeCase/data/datasources');
  }
  
  for (final dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('📁 Created: $dir/');
  }
}

void _createFeatureFiles(String snakeCase, String pascalCase, String featureDisplayName, bool includeApi, bool includeStorage) {
  // Entity
  final entityFile = File('lib/features/$snakeCase/domain/entities/${snakeCase}_entity.dart');
  entityFile.writeAsStringSync('''
// 🎯 ${pascalCase} Entity
import 'package:equatable/equatable.dart';

class ${pascalCase}Entity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const ${pascalCase}Entity({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object> get props => [id, name, createdAt, updatedAt];
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
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
  
  factory ${pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return ${pascalCase}Model(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  ${pascalCase}Entity toEntity() {
    return ${pascalCase}Entity(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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
  Future<Either<Failure, List<${pascalCase}Entity>>> get${pascalCase}s();
  Future<Either<Failure, ${pascalCase}Entity>> get${pascalCase}(String id);
  Future<Either<Failure, ${pascalCase}Entity>> create${pascalCase}(${pascalCase}Entity ${snakeCase});
  Future<Either<Failure, ${pascalCase}Entity>> update${pascalCase}(${pascalCase}Entity ${snakeCase});
  Future<Either<Failure, bool>> delete${pascalCase}(String id);
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
${includeApi ? "import '../datasources/${snakeCase}_remote_datasource.dart';" : ""}
${includeStorage ? "import '../datasources/${snakeCase}_local_datasource.dart';" : ""}

class ${pascalCase}RepositoryImpl implements ${pascalCase}Repository {
  ${includeApi ? "final ${pascalCase}RemoteDataSource remoteDataSource;" : ""}
  ${includeStorage ? "final ${pascalCase}LocalDataSource localDataSource;" : ""}
  
  const ${pascalCase}RepositoryImpl({
    ${includeApi ? "required this.remoteDataSource," : ""}
    ${includeStorage ? "required this.localDataSource," : ""}
  });
  
  @override
  Future<Either<Failure, List<${pascalCase}Entity>>> get${pascalCase}s() async {
    try {
      ${includeApi ? """
      final ${snakeCase}s = await remoteDataSource.get${pascalCase}s();
      return Right(${snakeCase}s.map((model) => model.toEntity()).toList());
      """ : """
      // TODO: Implement get${pascalCase}s logic
      throw UnimplementedError();
      """}
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, ${pascalCase}Entity>> get${pascalCase}(String id) async {
    try {
      ${includeApi ? """
      final ${snakeCase} = await remoteDataSource.get${pascalCase}(id);
      return Right(${snakeCase}.toEntity());
      """ : """
      // TODO: Implement get${pascalCase} logic
      throw UnimplementedError();
      """}
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, ${pascalCase}Entity>> create${pascalCase}(${pascalCase}Entity ${snakeCase}) async {
    try {
      ${includeApi ? """
      final model = ${pascalCase}Model(
        id: ${snakeCase}.id,
        name: ${snakeCase}.name,
        description: ${snakeCase}.description,
        createdAt: ${snakeCase}.createdAt,
        updatedAt: ${snakeCase}.updatedAt,
      );
      
      final created${pascalCase} = await remoteDataSource.create${pascalCase}(model);
      return Right(created${pascalCase}.toEntity());
      """ : """
      // TODO: Implement create${pascalCase} logic
      throw UnimplementedError();
      """}
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, ${pascalCase}Entity>> update${pascalCase}(${pascalCase}Entity ${snakeCase}) async {
    try {
      ${includeApi ? """
      final model = ${pascalCase}Model(
        id: ${snakeCase}.id,
        name: ${snakeCase}.name,
        description: ${snakeCase}.description,
        createdAt: ${snakeCase}.createdAt,
        updatedAt: ${snakeCase}.updatedAt,
      );
      
      final updated${pascalCase} = await remoteDataSource.update${pascalCase}(model);
      return Right(updated${pascalCase}.toEntity());
      """ : """
      // TODO: Implement update${pascalCase} logic
      throw UnimplementedError();
      """}
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> delete${pascalCase}(String id) async {
    try {
      ${includeApi ? """
      await remoteDataSource.delete${pascalCase}(id);
      return const Right(true);
      """ : """
      // TODO: Implement delete${pascalCase} logic
      throw UnimplementedError();
      """}
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/data/repositories/${snakeCase}_repository_impl.dart');
  
  if (includeApi) {
    // Remote Data Source
    final remoteDataSourceFile = File('lib/features/$snakeCase/data/datasources/${snakeCase}_remote_datasource.dart');
    remoteDataSourceFile.writeAsStringSync('''
// 🌐 ${pascalCase} Remote Data Source
import '../../../../core/network/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/${snakeCase}_model.dart';

abstract class ${pascalCase}RemoteDataSource {
  Future<List<${pascalCase}Model>> get${pascalCase}s();
  Future<${pascalCase}Model> get${pascalCase}(String id);
  Future<${pascalCase}Model> create${pascalCase}(${pascalCase}Model ${snakeCase});
  Future<${pascalCase}Model> update${pascalCase}(${pascalCase}Model ${snakeCase});
  Future<void> delete${pascalCase}(String id);
}

class ${pascalCase}RemoteDataSourceImpl implements ${pascalCase}RemoteDataSource {
  final ApiClient apiClient;
  
  const ${pascalCase}RemoteDataSourceImpl({required this.apiClient});
  
  @override
  Future<List<${pascalCase}Model>> get${pascalCase}s() async {
    final response = await apiClient.get('/${snakeCase}s');
    
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ${pascalCase}Model.fromJson(json)).toList();
  }
  
  @override
  Future<${pascalCase}Model> get${pascalCase}(String id) async {
    final response = await apiClient.get('/${snakeCase}s/\$id');
    
    return ${pascalCase}Model.fromJson(response.data);
  }
  
  @override
  Future<${pascalCase}Model> create${pascalCase}(${pascalCase}Model ${snakeCase}) async {
    final response = await apiClient.post(
      '/${snakeCase}s',
      data: ${snakeCase}.toJson(),
    );
    
    return ${pascalCase}Model.fromJson(response.data);
  }
  
  @override
  Future<${pascalCase}Model> update${pascalCase}(${pascalCase}Model ${snakeCase}) async {
    final response = await apiClient.put(
      '/${snakeCase}s/\${${snakeCase}.id}',
      data: ${snakeCase}.toJson(),
    );
    
    return ${pascalCase}Model.fromJson(response.data);
  }
  
  @override
  Future<void> delete${pascalCase}(String id) async {
    await apiClient.delete('/${snakeCase}s/\$id');
  }
}
''');
    print('📄 Created: lib/features/$snakeCase/data/datasources/${snakeCase}_remote_datasource.dart');
  }
  
  if (includeStorage) {
    // Local Data Source
    final localDataSourceFile = File('lib/features/$snakeCase/data/datasources/${snakeCase}_local_datasource.dart');
    localDataSourceFile.writeAsStringSync('''
// 💾 ${pascalCase} Local Data Source
import '../../../../core/services/storage_service.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/${snakeCase}_model.dart';

abstract class ${pascalCase}LocalDataSource {
  Future<List<${pascalCase}Model>> getCached${pascalCase}s();
  Future<void> cache${pascalCase}s(List<${pascalCase}Model> ${snakeCase}s);
  Future<${pascalCase}Model?> getCached${pascalCase}(String id);
  Future<void> cache${pascalCase}(${pascalCase}Model ${snakeCase});
  Future<void> removeCached${pascalCase}(String id);
  Future<void> clearCached${pascalCase}s();
}

class ${pascalCase}LocalDataSourceImpl implements ${pascalCase}LocalDataSource {
  final StorageService storageService;
  
  const ${pascalCase}LocalDataSourceImpl({required this.storageService});
  
  @override
  Future<List<${pascalCase}Model>> getCached${pascalCase}s() async {
    final ${snakeCase}sJson = storageService.getStringList('${snakeCase}s');
    if (${snakeCase}sJson == null || ${snakeCase}sJson.isEmpty) {
      throw CacheException('No cached ${snakeCase}s found');
    }
    
    try {
      return ${snakeCase}sJson
          .map((json) => ${pascalCase}Model.fromJson(
                Map<String, dynamic>.from(
                  Map<String, dynamic>.from(json),
                ),
              ))
          .toList();
    } catch (e) {
      throw CacheException('Failed to parse cached ${snakeCase}s');
    }
  }
  
  @override
  Future<void> cache${pascalCase}s(List<${pascalCase}Model> ${snakeCase}s) async {
    final result = await storageService.setStringList(
      '${snakeCase}s',
      ${snakeCase}s.map((${snakeCase}) => ${snakeCase}.toJson().toString()).toList(),
    );
    
    if (!result) {
      throw CacheException('Failed to cache ${snakeCase}s');
    }
  }
  
  @override
  Future<${pascalCase}Model?> getCached${pascalCase}(String id) async {
    final ${snakeCase}Json = storageService.getString('${snakeCase}_\$id');
    if (${snakeCase}Json == null) return null;
    
    try {
      final ${snakeCase}Map = Map<String, dynamic>.from(
        Map<String, dynamic>.from(${snakeCase}Json),
      );
      return ${pascalCase}Model.fromJson(${snakeCase}Map);
    } catch (e) {
      throw CacheException('Failed to parse cached ${snakeCase}');
    }
  }
  
  @override
  Future<void> cache${pascalCase}(${pascalCase}Model ${snakeCase}) async {
    final result = await storageService.setString(
      '${snakeCase}_\${${snakeCase}.id}',
      ${snakeCase}.toJson().toString(),
    );
    
    if (!result) {
      throw CacheException('Failed to cache ${snakeCase}');
    }
  }
  
  @override
  Future<void> removeCached${pascalCase}(String id) async {
    await storageService.remove('${snakeCase}_\$id');
  }
  
  @override
  Future<void> clearCached${pascalCase}s() async {
    await storageService.remove('${snakeCase}s');
  }
}
''');
    print('📄 Created: lib/features/$snakeCase/data/datasources/${snakeCase}_local_datasource.dart');
  }
  
  // Use Cases
  final getpascalCasesUseCaseFile = File('lib/features/$snakeCase/domain/usecases/get_${snakeCase}s_usecase.dart');
  getpascalCasesUseCaseFile.writeAsStringSync('''
// 🎯 Get ${pascalCase}s Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/${snakeCase}_repository.dart';
import '../entities/${snakeCase}_entity.dart';

class Get${pascalCase}sUseCase implements UseCase<List<${pascalCase}Entity>, NoParams> {
  final ${pascalCase}Repository repository;
  
  const Get${pascalCase}sUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<${pascalCase}Entity>>> call(NoParams params) async {
    return repository.get${pascalCase}s();
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/domain/usecases/get_${snakeCase}s_usecase.dart');

  final getpascalCaseUseCaseFile = File('lib/features/$snakeCase/domain/usecases/get_${snakeCase}_usecase.dart');
  getpascalCaseUseCaseFile.writeAsStringSync('''
// 🎯 Get ${pascalCase} Use Case
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/${snakeCase}_repository.dart';
import '../entities/${snakeCase}_entity.dart';

class Get${pascalCase}UseCase implements UseCase<${pascalCase}Entity, String> {
  final ${pascalCase}Repository repository;
  
  const Get${pascalCase}UseCase(this.repository);
  
  @override
  Future<Either<Failure, ${pascalCase}Entity>> call(String id) async {
    return repository.get${pascalCase}(id);
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/domain/usecases/get_${snakeCase}_usecase.dart');
  
  // Cubit
  final cubitFile = File('lib/features/$snakeCase/presentation/cubit/${snakeCase}_cubit.dart');
  cubitFile.writeAsStringSync('''
// 🎯 ${pascalCase} Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/${snakeCase}_entity.dart';
import '../../domain/usecases/get_${snakeCase}_usecase.dart';
import '../../domain/usecases/get_${snakeCase}s_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

part '${snakeCase}_state.dart';

class ${pascalCase}Cubit extends Cubit<${pascalCase}State> {
  final Get${pascalCase}UseCase get${pascalCase};
  final Get${pascalCase}sUseCase get${pascalCase}s;
  
  ${pascalCase}Cubit({
    required this.get${pascalCase},
    required this.get${pascalCase}s,
  }) : super(${pascalCase}Initial()) {
    load${pascalCase}s();
  }
  
  Future<void> load${pascalCase}s() async {
    emit(${pascalCase}Loading());
    
    final result = await get${pascalCase}s(NoParams());
    
    result.fold(
      (failure) => emit(${pascalCase}Error(failure.message)),
      (${snakeCase}s) => emit(${pascalCase}sLoaded(${snakeCase}s)),
    );
  }
  
  Future<void> load${pascalCase}(String id) async {
    emit(${pascalCase}Loading());
    
    final result = await get${pascalCase}(id);
    
    result.fold(
      (failure) => emit(${pascalCase}Error(failure.message)),
      (${snakeCase}) => emit(${pascalCase}Loaded(${snakeCase})),
    );
  }
  
  void refresh${pascalCase}s() {
    load${pascalCase}s();
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
  
  @override
  List<Object> get props => [${pascalCase.toLowerCase()}];
}

class ${pascalCase}sLoaded extends ${pascalCase}State {
  final List<${pascalCase}Entity> ${snakeCase}s;
  
  ${pascalCase}sLoaded(this.${snakeCase}s);
  
  @override
  List<Object> get props => [${snakeCase}s];
}

class ${pascalCase}Error extends ${pascalCase}State {
  final String message;
  
  ${pascalCase}Error(this.message);
  
  @override
  List<Object> get props => [message];
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
import '../cubit/${snakeCase}_state.dart';
import '../../../../core/services/locator_service.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../domain/usecases/get_${snakeCase}_usecase.dart';
import '../../domain/usecases/get_${snakeCase}s_usecase.dart';

class ${pascalCase}Page extends StatelessWidget {
  const ${pascalCase}Page({Key? key}) : super(key: key);
  
  static const String routeName = '/$snakeCase';
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${pascalCase}Cubit(
        get${pascalCase}: getIt<Get${pascalCase}UseCase>(),
        get${pascalCase}s: getIt<Get${pascalCase}sUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$featureDisplayName'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<${pascalCase}Cubit>().refresh${pascalCase}s();
              },
            ),
          ],
        ),
        body: BlocBuilder<${pascalCase}Cubit, ${pascalCase}State>(
          builder: (context, state) {
            if (state is ${pascalCase}Loading) {
              return const LoadingWidget();
            } else if (state is ${pascalCase}sLoaded) {
              return _build${pascalCase}sList(context, state.${snakeCase}s);
            } else if (state is ${pascalCase}Loaded) {
              return _build${pascalCase}Detail(context, state.${pascalCase.toLowerCase()});
            } else if (state is ${pascalCase}Error) {
              return ErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<${pascalCase}Cubit>().refresh${pascalCase}s();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
  
  Widget _build${pascalCase}sList(BuildContext context, List<${pascalCase}Entity> ${snakeCase}s) {
    if (${snakeCase}s.isEmpty) {
      return Center(
        child: Text(
          'No ${snakeCase}s found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    
    return RefreshIndicator(
      onRefresh: () async {
        context.read<${pascalCase}Cubit>().refresh${pascalCase}s();
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: ${snakeCase}s.length,
        itemBuilder: (context, index) {
          final ${snakeCase} = ${snakeCase}s[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16.h),
            child: ListTile(
              title: Text(${snakeCase}.name),
              subtitle: ${snakeCase}.description != null ? Text(${snakeCase}.description!) : null,
              onTap: () {
                context.read<${pascalCase}Cubit>().load${pascalCase}(${snakeCase}.id);
              },
            ),
          );
        },
      ),
    );
  }
  
  Widget _build${pascalCase}Detail(BuildContext context, ${pascalCase}Entity ${snakeCase}) {
    final l10n = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ${snakeCase}.name,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (${snakeCase}.description != null) ...[
            SizedBox(height: 16.h),
            Text(
              ${snakeCase}.description!,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
          SizedBox(height: 24.h),
          Text(
            'Created: ${snakeCase}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Updated: ${snakeCase}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<${pascalCase}Cubit>().refresh${pascalCase}s();
            },
            child: Text(l10n.backToHome),
          ),
        ],
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
import '../../domain/entities/${snakeCase}_entity.dart';

class ${pascalCase}Widget extends StatelessWidget {
  final ${pascalCase}Entity ${pascalCase.toLowerCase()};
  final VoidCallback? onTap;
  
  const ${pascalCase}Widget({
    required this.${pascalCase.toLowerCase()},
    this.onTap,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ${pascalCase.toLowerCase()}.name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (${pascalCase.toLowerCase()}.description != null) ...[
                SizedBox(height: 8.h),
                Text(
                  ${pascalCase.toLowerCase()}.description!,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
''');
  print('📄 Created: lib/features/$snakeCase/presentation/widgets/${snakeCase}_widget.dart');
  
  // Feature Injection
  final injectionFile = File('lib/features/$snakeCase/${snakeCase}_injection.dart');
  injectionFile.writeAsStringSync('''
// 🔄 ${pascalCase} Feature Injection
import 'package:get_it/get_it.dart';
${includeApi ? "import '../../core/network/api_client.dart';" : ""}
${includeStorage ? "import '../../core/services/storage_service.dart';" : ""}
${includeApi ? "import '../data/datasources/${snakeCase}_remote_datasource.dart';" : ""}
${includeStorage ? "import '../data/datasources/${snakeCase}_local_datasource.dart';" : ""}
import '../data/repositories/${snakeCase}_repository_impl.dart';
import '../domain/repositories/${snakeCase}_repository.dart';
import '../domain/usecases/get_${snakeCase}_usecase.dart';
import '../domain/usecases/get_${snakeCase}s_usecase.dart';
import '../presentation/cubit/${snakeCase}_cubit.dart';

Future<void> init${pascalCase}Feature() async {
  ${includeApi ? """
  // Data sources
  getIt.registerFactory<${pascalCase}RemoteDataSource>(
    () => ${pascalCase}RemoteDataSourceImpl(
      apiClient: getIt<ApiClient>(),
    ),
  );
  """ : ""}
  
  ${includeStorage ? """
  getIt.registerFactory<${pascalCase}LocalDataSource>(
    () => ${pascalCase}LocalDataSourceImpl(
      storageService: getIt<StorageService>(),
    ),
  );
  """ : ""}
  
  // Repositories
  getIt.registerFactory<${pascalCase}Repository>(
    () => ${pascalCase}RepositoryImpl(
      ${includeApi ? "remoteDataSource: getIt<${pascalCase}RemoteDataSource>()," : ""}
      ${includeStorage ? "localDataSource: getIt<${pascalCase}LocalDataSource>()," : ""}
    ),
  );
  
  // Use cases
  getIt.registerFactory<Get${pascalCase}UseCase>(
    () => Get${pascalCase}UseCase(
      getIt<${pascalCase}Repository>(),
    ),
  );
  
  getIt.registerFactory<Get${pascalCase}sUseCase>(
    () => Get${pascalCase}sUseCase(
      getIt<${pascalCase}Repository>(),
    ),
  );
  
  // Cubit
  getIt.registerFactory<${pascalCase}Cubit>(
    () => ${pascalCase}Cubit(
      get${pascalCase}: getIt<Get${pascalCase}UseCase>(),
      get${pascalCase}s: getIt<Get${pascalCase}sUseCase>(),
    ),
  );
}
''');
  print('📄 Created: lib/features/$snakeCase/${snakeCase}_injection.dart');
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
  
  // Add import
  final updatedContent = content.replaceFirst(
    'import \'package:go_router/go_router.dart\';',
    'import \'package:go_router/go_router.dart\';\nimport \'package:your_app/features/$snakeCase/presentation/pages/${snakeCase}_page.dart\';',
  );
  
  // Insert new route before closing bracket
  final finalContent = updatedContent.replaceFirst(
    '    ],',
    '$newRoute    ],',
  );
  
  routerFile.writeAsStringSync(finalContent);
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
      '$newImport\nimport \'package:get_it/get_it.dart\';',
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
}

void _addNewService() {
  print('\n🔧 Available services:');
  print('1. Analytics Service');
  print('2. Notification Service');
  print('3. Payment Service');
  print('4. Storage Service');
  print('5. Custom Service');
  
  stdout.write('\nEnter your choice (1-5): ');
  final choice = stdin.readLineSync();
  
  switch (choice) {
    case '1':
      _createAnalyticsService();
      break;
    case '2':
      _createNotificationService();
      break;
    case '3':
      _createPaymentService();
      break;
    case '4':
      _createStorageService();
      break;
    case '5':
      _createCustomService();
      break;
    default:
      print('❌ Invalid choice. Please try again.');
  }
}

void _createNotificationService() {
  print('\n🔔 Creating notification service...');
  
  // Create notification service directory
  final notificationDir = Directory('lib/core/services/notification');
  if (!notificationDir.existsSync()) {
    notificationDir.createSync(recursive: true);
    print('📁 Created: lib/core/services/notification/');
  }
  
  // notification_service.dart
  final notificationServiceFile = File('lib/core/services/notification/notification_service.dart');
  notificationServiceFile.writeAsStringSync('''
// 🔔 Notification Service
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  
  factory NotificationService() {
    return _instance;
  }
  
  NotificationService._internal();
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
  
  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    tz.initializeTimeZones();
    
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }
  
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
  
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }
  
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
''');
  print('📄 Created: lib/core/services/notification/notification_service.dart');
  
  // Update locator service
  _updateLocatorForNotificationService();
  
  print('\n✅ Notification service created successfully!');
}

void _updateLocatorForNotificationService() {
  final locatorFile = File('lib/core/services/locator_service.dart');
  if (!locatorFile.existsSync()) return;
  
  final content = locatorFile.readAsStringSync();
  
  // Add notification service import and registration
  if (!content.contains('NotificationService')) {
    final updatedContent = content.replaceFirst(
      'final getIt = GetIt.instance;',
      'import \'notification/notification_service.dart\';\n\nfinal getIt = GetIt.instance;',
    );
    
    locatorFile.writeAsStringSync(updatedContent);
    
    final finalContent = locatorFile.readAsStringSync().replaceFirst(
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());',
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());\n  getIt.registerLazySingleton<NotificationService>(() => NotificationService());',
    );
    
    locatorFile.writeAsStringSync(finalContent);
    print('📄 Updated: lib/core/services/locator_service.dart');
  }
}

void _createPaymentService() {
  print('\n💳 Creating payment service...');
  
  // Create payment service directory
  final paymentDir = Directory('lib/core/services/payment');
  if (!paymentDir.existsSync()) {
    paymentDir.createSync(recursive: true);
    print('📁 Created: lib/core/services/payment/');
  }
  
  // payment_service.dart
  final paymentServiceFile = File('lib/core/services/payment/payment_service.dart');
  paymentServiceFile.writeAsStringSync('''
// 💳 Payment Service
import 'dart:async';
import 'package:flutter/material.dart';

enum PaymentStatus { success, failed, cancelled }

class PaymentResult {
  final PaymentStatus status;
  final String? transactionId;
  final String? errorMessage;
  
  PaymentResult({
    required this.status,
    this.transactionId,
    this.errorMessage,
  });
}

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  
  factory PaymentService() {
    return _instance;
  }
  
  PaymentService._internal();
  
  Future<PaymentResult> makePayment({
    required double amount,
    required String currency,
    String? description,
  }) async {
    try {
      // TODO: Implement actual payment logic
      // This would typically involve integrating with a payment provider like Stripe, PayPal, etc.
      
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, randomly succeed or fail
      final isSuccess = DateTime.now().millisecond % 2 == 0;
      
      if (isSuccess) {
        return PaymentResult(
          status: PaymentStatus.success,
          transactionId: 'txn_\${DateTime.now().millisecondsSinceEpoch}',
        );
      } else {
        return PaymentResult(
          status: PaymentStatus.failed,
          errorMessage: 'Payment failed. Please try again.',
        );
      }
    } catch (e) {
      return PaymentResult(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }
  
  Future<PaymentResult> makeSubscriptionPayment({
    required double amount,
    required String currency,
    required String subscriptionId,
    String? description,
  }) async {
    try {
      // TODO: Implement subscription payment logic
      
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, randomly succeed or fail
      final isSuccess = DateTime.now().millisecond % 2 == 0;
      
      if (isSuccess) {
        return PaymentResult(
          status: PaymentStatus.success,
          transactionId: 'sub_\${DateTime.now().millisecondsSinceEpoch}',
        );
      } else {
        return PaymentResult(
          status: PaymentStatus.failed,
          errorMessage: 'Subscription payment failed. Please try again.',
        );
      }
    } catch (e) {
      return PaymentResult(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }
  
  Future<bool> cancelSubscription(String subscriptionId) async {
    try {
      // TODO: Implement subscription cancellation logic
      
      // Simulate cancellation
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, randomly succeed or fail
      return DateTime.now().millisecond % 2 == 0;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> validatePayment(String transactionId) async {
    try {
      // TODO: Implement payment validation logic
      
      // Simulate validation
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, randomly return true or false
      return DateTime.now().millisecond % 2 == 0;
    } catch (e) {
      return false;
    }
  }
}
''');
  print('📄 Created: lib/core/services/payment/payment_service.dart');
  
  // Update locator service
  _updateLocatorForPaymentService();
  
  print('\n✅ Payment service created successfully!');
}

void _updateLocatorForPaymentService() {
  final locatorFile = File('lib/core/services/locator_service.dart');
  if (!locatorFile.existsSync()) return;
  
  final content = locatorFile.readAsStringSync();
  
  // Add payment service import and registration
  if (!content.contains('PaymentService')) {
    final updatedContent = content.replaceFirst(
      'final getIt = GetIt.instance;',
      'import \'payment/payment_service.dart\';\n\nfinal getIt = GetIt.instance;',
    );
    
    locatorFile.writeAsStringSync(updatedContent);
    
    final finalContent = locatorFile.readAsStringSync().replaceFirst(
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());',
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());\n  getIt.registerLazySingleton<PaymentService>(() => PaymentService());',
    );
    
    locatorFile.writeAsStringSync(finalContent);
    print('📄 Updated: lib/core/services/locator_service.dart');
  }
}

void _createStorageService() {
  print('\n💾 Creating storage service...');
  
  // Create storage service directory
  final storageDir = Directory('lib/core/services/storage');
  if (!storageDir.existsSync()) {
    storageDir.createSync(recursive: true);
    print('📁 Created: lib/core/services/storage/');
  }
  
  // secure_storage_service.dart
  final secureStorageServiceFile = File('lib/core/services/storage/secure_storage_service.dart');
  secureStorageServiceFile.writeAsStringSync('''
// 🔐 Secure Storage Service
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const SecureStorageService _instance = SecureStorageService._internal();
  
  factory SecureStorageService() {
    return _instance;
  }
  
  SecureStorageService._internal();
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Generic methods
  Future<void> set<T>(String key, T value) async {
    switch (T) {
      case String:
        await _secureStorage.write(key: key, value: value as String);
        break;
      case int:
        await _secureStorage.write(key: key, value: value.toString());
        break;
      case bool:
        await _secureStorage.write(key: key, value: value.toString());
        break;
      case double:
        await _secureStorage.write(key: key, value: value.toString());
        break;
      default:
        throw Exception('Unsupported type');
    }
  }
  
  Future<T?> get<T>(String key) async {
    final value = await _secureStorage.read(key: key);
    if (value == null) return null;
    
    switch (T) {
      case String:
        return value as T;
      case int:
        return int.tryParse(value) as T?;
      case bool:
        return (value.toLowerCase() == 'true') as T;
      case double:
        return double.tryParse(value) as T?;
      default:
        return null;
    }
  }
  
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }
  
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
  
  // Convenience methods
  Future<void> setString(String key, String value) => set<String>(key, value);
  Future<String?> getString(String key) => get<String>(key);
  
  Future<void> setInt(String key, int value) => set<int>(key, value);
  Future<int?> getInt(String key) => get<int>(key);
  
  Future<void> setBool(String key, bool value) => set<bool>(key, value);
  Future<bool?> getBool(String key) => get<bool>(key);
  
  Future<void> setDouble(String key, double value) => set<double>(key, value);
  Future<double?> getDouble(String key) => get<double>(key);
  
  // Auth specific methods
  Future<void> saveAuthToken(String token) async {
    await setString('auth_token', token);
  }
  
  Future<String?> getAuthToken() async {
    return getString('auth_token');
  }
  
  Future<void> saveRefreshToken(String token) async {
    await setString('refresh_token', token);
  }
  
  Future<String?> getRefreshToken() async {
    return getString('refresh_token');
  }
  
  Future<void> saveUserCredentials(String username, String password) async {
    await setString('username', username);
    await setString('password', password);
  }
  
  Future<Map<String, String?>> getUserCredentials() async {
    final username = await getString('username');
    final password = await getString('password');
    return {'username': username, 'password': password};
  }
  
  Future<void> clearAuthData() async {
    await remove('auth_token');
    await remove('refresh_token');
    await remove('username');
    await remove('password');
  }
}
''');
  print('📄 Created: lib/core/services/storage/secure_storage_service.dart');
  
  // file_storage_service.dart
  final fileStorageServiceFile = File('lib/core/services/storage/file_storage_service.dart');
  fileStorageServiceFile.writeAsStringSync('''
// 📁 File Storage Service
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileStorageService {
  static const FileStorageService _instance = FileStorageService._internal();
  
  factory FileStorageService() {
    return _instance;
  }
  
  FileStorageService._internal();
  
  Future<Directory> get _appDirectory async {
    return await getApplicationDocumentsDirectory();
  }
  
  Future<String> get _appPath async {
    final directory = await _appDirectory;
    return directory.path;
  }
  
  Future<File> _getFile(String fileName) async {
    final dir = await _appDirectory;
    return File('\${dir.path}/\$fileName');
  }
  
  Future<File> writeToFile(String fileName, String content) async {
    final file = await _getFile(fileName);
    return file.writeAsString(content);
  }
  
  Future<String> readFromFile(String fileName) async {
    try {
      final file = await _getFile(fileName);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
  
  Future<bool> deleteFile(String fileName) async {
    try {
      final file = await _getFile(fileName);
      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> fileExists(String fileName) async {
    final file = await _getFile(fileName);
    return file.exists();
  }
  
  Future<List<String>> listFiles({String? extension}) async {
    final dir = await _appDirectory;
    final files = await dir.list().where((entity) => entity is File).cast<File>().toList();
    
    if (extension != null) {
      return files
          .where((file) => path.extension(file.path) == extension)
          .map((file) => path.basename(file.path))
          .toList();
    }
    
    return files.map((file) => path.basename(file.path)).toList();
  }
  
  Future<void> clearFiles() async {
    final dir = await _appDirectory;
    final files = await dir.list().where((entity) => entity is File).cast<File>().toList();
    
    for (final file in files) {
      await file.delete();
    }
  }
}
''');
  print('📄 Created: lib/core/services/storage/file_storage_service.dart');
  
  // Update locator service
  _updateLocatorForStorageService();
  
  print('\n✅ Storage service created successfully!');
}

void _updateLocatorForStorageService() {
  final locatorFile = File('lib/core/services/locator_service.dart');
  if (!locatorFile.existsSync()) return;
  
  final content = locatorFile.readAsStringSync();
  
  // Add storage service imports and registration
  if (!content.contains('SecureStorageService')) {
    final updatedContent = content.replaceFirst(
      'final getIt = GetIt.instance;',
      'import \'storage/secure_storage_service.dart\';\nimport \'storage/file_storage_service.dart\';\n\nfinal getIt = GetIt.instance;',
    );
    
    locatorFile.writeAsStringSync(updatedContent);
    
    final finalContent = locatorFile.readAsStringSync().replaceFirst(
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());',
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());\n  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());\n  getIt.registerLazySingleton<FileStorageService>(() => FileStorageService());',
    );
    
    locatorFile.writeAsStringSync(finalContent);
    print('📄 Updated: lib/core/services/locator_service.dart');
  }
}

void _createCustomService() {
  stdout.write('\n🔧 Enter service name (e.g., location_service): ');
  final serviceName = stdin.readLineSync()?.trim() ?? '';
  
  if (serviceName.isEmpty) {
    print('❌ Service name cannot be empty!');
    return;
  }
  
  stdout.write('🔤 Enter service display name (e.g., Location Service): ');
  final serviceDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(serviceName);
  
  final snakeCase = _toSnakeCase(serviceName);
  final pascalCase = _toPascalCase(serviceName);
  
  print('\n🔨 Creating service: $serviceName');
  
  // Create service directory
  final serviceDir = Directory('lib/core/services/$snakeCase');
  if (!serviceDir.existsSync()) {
    serviceDir.createSync(recursive: true);
    print('📁 Created: lib/core/services/$snakeCase/');
  }
  
  // Create service file
  final serviceFile = File('lib/core/services/$snakeCase/${snakeCase}_service.dart');
  serviceFile.writeAsStringSync('''
// 🔧 $serviceDisplayName
import 'package:flutter/material.dart';

class $pascalCase {
  static final $pascalCase _instance = $pascalCase._internal();
  
  factory $pascalCase() {
    return _instance;
  }
  
  $pascalCase._internal();
  
  Future<void> init() async {
    // TODO: Initialize your service
  }
  
  // TODO: Add your service methods here
}
''');
  print('📄 Created: lib/core/services/$snakeCase/${snakeCase}_service.dart');
  
  // Update locator service
  _updateLocatorForCustomService(snakeCase, pascalCase);
  
  print('\n✅ Service "$serviceName" created successfully!');
}

void _updateLocatorForCustomService(String snakeCase, String pascalCase) {
  final locatorFile = File('lib/core/services/locator_service.dart');
  if (!locatorFile.existsSync()) return;
  
  final content = locatorFile.readAsStringSync();
  
  // Add custom service import and registration
  if (!content.contains(pascalCase)) {
    final updatedContent = content.replaceFirst(
      'final getIt = GetIt.instance;',
      'import \'$snakeCase/${snakeCase}_service.dart\';\n\nfinal getIt = GetIt.instance;',
    );
    
    locatorFile.writeAsStringSync(updatedContent);
    
    final finalContent = locatorFile.readAsStringSync().replaceFirst(
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());',
      'getIt.registerFactory<ThemeCubit>(() => ThemeCubit());\n  getIt.registerLazySingleton<$pascalCase>(() => $pascalCase());',
    );
    
    locatorFile.writeAsStringSync(finalContent);
    print('📄 Updated: lib/core/services/locator_service.dart');
  }
}

void _generateBoilerplate() {
  print('\n📝 Available boilerplate code:');
  print('1. BLoC Pattern');
  print('2. Repository Pattern');
  print('3. API Integration');
  print('4. Form Validation');
  print('5. Custom Widget');
  
  stdout.write('\nEnter your choice (1-5): ');
  final choice = stdin.readLineSync();
  
  switch (choice) {
    case '1':
      _generateBlocBoilerplate();
      break;
    case '2':
      _generateRepositoryBoilerplate();
      break;
    case '3':
      _generateApiBoilerplate();
      break;
    case '4':
      _generateFormValidationBoilerplate();
      break;
    case '5':
      _generateCustomWidgetBoilerplate();
      break;
    default:
      print('❌ Invalid choice. Please try again.');
  }
}

void _generateBlocBoilerplate() {
  stdout.write('\n📝 Enter BLoC name (e.g., user_profile): ');
  final blocName = stdin.readLineSync()?.trim() ?? '';
  
  if (blocName.isEmpty) {
    print('❌ BLoC name cannot be empty!');
    return;
  }
  
  stdout.write('🔤 Enter BLoC display name (e.g., User Profile): ');
  final blocDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(blocName);
  
  final snakeCase = _toSnakeCase(blocName);
  final pascalCase = _toPascalCase(blocName);
  
  print('\n🔨 Creating BLoC: $blocName');
  
  // Create BLoC directory
  final blocDir = Directory('lib/core/bloc/$snakeCase');
  if (!blocDir.existsSync()) {
    blocDir.createSync(recursive: true);
    print('📁 Created: lib/core/bloc/$snakeCase/');
  }
  
  // Create BLoC files
  _createBlocFiles(snakeCase, pascalCase, blocDisplayName);
  
  print('\n✅ BLoC "$blocName" created successfully!');
}

void _createBlocFiles(String snakeCase, String pascalCase, String blocDisplayName) {
  // BLoC file
  final blocFile = File('lib/core/bloc/$snakeCase/${snakeCase}_bloc.dart');
  blocFile.writeAsStringSync('''
// 🎯 $pascalCase BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '${snakeCase}_event.dart';
part '${snakeCase}_state.dart';

class ${pascalCase}Bloc extends Bloc<${pascalCase}Event, ${pascalCase}State> {
  ${pascalCase}Bloc() : super(const ${pascalCase}Initial()) {
    on<Load${pascalCase}>(_onLoad${pascalCase});
    on<Refresh${pascalCase}>(_onRefresh${pascalCase});
  }
  
  Future<void> _onLoad${pascalCase}(
    Load${pascalCase} event,
    Emitter<${pascalCase}State> emit,
  ) async {
    emit(const ${pascalCase}Loading());
    
    try {
      // TODO: Implement loading logic
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      emit(const ${pascalCase}Loaded());
    } catch (e) {
      emit(${pascalCase}Error(e.toString()));
    }
  }
  
  Future<void> _onRefresh${pascalCase}(
    Refresh${pascalCase} event,
    Emitter<${pascalCase}State> emit,
  ) async {
    // TODO: Implement refresh logic
    add(Load${pascalCase}());
  }
}
''');
  print('📄 Created: lib/core/bloc/$snakeCase/${snakeCase}_bloc.dart');
  
  // Event file
  final eventFile = File('lib/core/bloc/$snakeCase/${snakeCase}_event.dart');
  eventFile.writeAsStringSync('''
// 🎯 $pascalCase Event
part of '${snakeCase}_bloc.dart';

abstract class ${pascalCase}Event extends Equatable {
  const ${pascalCase}Event();
  
  @override
  List<Object> get props => [];
}

class Load${pascalCase} extends ${pascalCase}Event {}

class Refresh${pascalCase} extends ${pascalCase}Event {}
''');
  print('📄 Created: lib/core/bloc/$snakeCase/${snakeCase}_event.dart');
  
  // State file
  final stateFile = File('lib/core/bloc/$snakeCase/${snakeCase}_state.dart');
  stateFile.writeAsStringSync('''
// 🎯 $pascalCase State
part of '${snakeCase}_bloc.dart';

abstract class ${pascalCase}State extends Equatable {
  const ${pascalCase}State();
  
  @override
  List<Object> get props => [];
}

class ${pascalCase}Initial extends ${pascalCase}State {}

class ${pascalCase}Loading extends ${pascalCase}State {}

class ${pascalCase}Loaded extends ${pascalCase}State {}

class ${pascalCase}Error extends ${pascalCase}State {
  final String message;
  
  const ${pascalCase}Error(this.message);
  
  @override
  List<Object> get props => [message];
}
''');
  print('📄 Created: lib/core/bloc/$snakeCase/${snakeCase}_state.dart');
}

void _generateRepositoryBoilerplate() {
  stdout.write('\n📝 Enter repository name (e.g., user_profile): ');
  final repoName = stdin.readLineSync()?.trim() ?? '';
  
  if (repoName.isEmpty) {
    print('❌ Repository name cannot be empty!');
    return;
  }
  
  stdout.write('🔤 Enter repository display name (e.g., User Profile): ');
  final repoDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(repoName);
  
  final snakeCase = _toSnakeCase(repoName);
  final pascalCase = _toPascalCase(repoName);
  
  print('\n🔨 Creating Repository: $repoName');
  
  // Create repository directory
  final repoDir = Directory('lib/core/repositories/$snakeCase');
  if (!repoDir.existsSync()) {
    repoDir.createSync(recursive: true);
    print('📁 Created: lib/core/repositories/$snakeCase/');
  }
  
  // Create repository files
  _createRepositoryFiles(snakeCase, pascalCase, repoDisplayName);
  
  print('\n✅ Repository "$repoName" created successfully!');
}

void _createRepositoryFiles(String snakeCase, String pascalCase, String repoDisplayName) {
  // Repository interface
  final repoInterfaceFile = File('lib/core/repositories/$snakeCase/${snakeCase}_repository.dart');
  repoInterfaceFile.writeAsStringSync('''
// 📚 $pascalCase Repository
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

abstract class ${pascalCase}Repository {
  // TODO: Add your repository methods here
  Future<Either<Failure, bool>> performAction();
}
''');
  print('📄 Created: lib/core/repositories/$snakeCase/${snakeCase}_repository.dart');
  
  // Repository implementation
  final repoImplFile = File('lib/core/repositories/$snakeCase/${snakeCase}_repository_impl.dart');
  repoImplFile.writeAsStringSync('''
// 🔧 $pascalCase Repository Implementation
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '${snakeCase}_repository.dart';

class ${pascalCase}RepositoryImpl implements ${pascalCase}Repository {
  // TODO: Add your dependencies here
  
  ${pascalCase}RepositoryImpl();
  
  @override
  Future<Either<Failure, bool>> performAction() async {
    try {
      // TODO: Implement repository logic
      
      // Simulate operation
      await Future.delayed(const Duration(seconds: 1));
      
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
''');
  print('📄 Created: lib/core/repositories/$snakeCase/${snakeCase}_repository_impl.dart');
}

void _generateApiBoilerplate() {
  stdout.write('\n📝 Enter API name (e.g., user_profile): ');
  final apiName = stdin.readLineSync()?.trim() ?? '';
  
  if (apiName.isEmpty) {
    print('❌ API name cannot be empty!');
    return;
  }
  
  stdout.write('🔤 Enter API display name (e.g., User Profile): ');
  final apiDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(apiName);
  
  stdout.write('🌐 Enter API endpoint (e.g., /user-profile): ');
  final apiEndpoint = stdin.readLineSync()?.trim() ?? '/$apiName';
  
  final snakeCase = _toSnakeCase(apiName);
  final pascalCase = _toPascalCase(apiName);
  
  print('\n🔨 Creating API: $apiName');
  
  // Create API directory
  final apiDir = Directory('lib/core/api/$snakeCase');
  if (!apiDir.existsSync()) {
    apiDir.createSync(recursive: true);
    print('📁 Created: lib/core/api/$snakeCase/');
  }
  
  // Create API files
  _createApiFiles(snakeCase, pascalCase, apiDisplayName, apiEndpoint);
  
  print('\n✅ API "$apiName" created successfully!');
}

void _createApiFiles(String snakeCase, String pascalCase, String apiDisplayName, String apiEndpoint) {
  // API service
  final apiServiceFile = File('lib/core/api/$snakeCase/${snakeCase}_api_service.dart');
  apiServiceFile.writeAsStringSync('''
// 🌐 $pascalCase API Service
import '../../../core/network/api_client.dart';
import '../../../core/errors/exceptions.dart';

class ${pascalCase}ApiService {
  final ApiClient apiClient;
  
  ${pascalCase}ApiService({required this.apiClient});
  
  // TODO: Add your API methods here
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await apiClient.get('$apiEndpoint');
      return response.data;
    } on ServerException catch (e) {
      throw ServerException(
        'Failed to fetch $apiDisplayName data',
        statusCode: e.statusCode,
        data: e.data,
      );
    } on NetworkException catch (e) {
      throw NetworkException('Network error while fetching $apiDisplayName data');
    } catch (e) {
      throw ServerException('Unexpected error while fetching $apiDisplayName data');
    }
  }
  
  Future<Map<String, dynamic>> createData(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post(
        '$apiEndpoint',
        data: data,
      );
      return response.data;
    } on ServerException catch (e) {
      throw ServerException(
        'Failed to create $apiDisplayName data',
        statusCode: e.statusCode,
        data: e.data,
      );
    } on NetworkException catch (e) {
      throw NetworkException('Network error while creating $apiDisplayName data');
    } catch (e) {
      throw ServerException('Unexpected error while creating $apiDisplayName data');
    }
  }
  
  Future<Map<String, dynamic>> updateData(String id, Map<String, dynamic> data) async {
    try {
      final response = await apiClient.put(
        '$apiEndpoint/\$id',
        data: data,
      );
      return response.data;
    } on ServerException catch (e) {
      throw ServerException(
        'Failed to update $apiDisplayName data',
        statusCode: e.statusCode,
        data: e.data,
      );
    } on NetworkException catch (e) {
      throw NetworkException('Network error while updating $apiDisplayName data');
    } catch (e) {
      throw ServerException('Unexpected error while updating $apiDisplayName data');
    }
  }
  
  Future<void> deleteData(String id) async {
    try {
      await apiClient.delete('$apiEndpoint/\$id');
    } on ServerException catch (e) {
      throw ServerException(
        'Failed to delete $apiDisplayName data',
        statusCode: e.statusCode,
        data: e.data,
      );
    } on NetworkException catch (e) {
      throw NetworkException('Network error while deleting $apiDisplayName data');
    } catch (e) {
      throw ServerException('Unexpected error while deleting $apiDisplayName data');
    }
  }
}
''');
  print('📄 Created: lib/core/api/$snakeCase/${snakeCase}_api_service.dart');
  
  // API model
  final apiModelFile = File('lib/core/api/$snakeCase/${snakeCase}_model.dart');
  apiModelFile.writeAsStringSync('''
// 📊 $pascalCase Model
import 'package:equatable/equatable.dart';

class ${pascalCase}Model extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const ${pascalCase}Model({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory ${pascalCase}Model.fromJson(Map<String, dynamic> json) {
    return ${pascalCase}Model(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  @override
  List<Object> get props => [id, name, createdAt, updatedAt];
}
''');
  print('📄 Created: lib/core/api/$snakeCase/${snakeCase}_model.dart');
}

void _generateFormValidationBoilerplate() {
  stdout.write('\n📝 Enter form name (e.g., login_form): ');
  final formName = stdin.readLineSync()?.trim() ?? '';
  
  if (formName.isEmpty) {
    print('❌ Form name cannot be empty!');
    return;
  }
  
  stdout.write('🔤 Enter form display name (e.g., Login Form): ');
  final formDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(formName);
  
  final snakeCase = _toSnakeCase(formName);
  final pascalCase = _toPascalCase(formName);
  
  print('\n🔨 Creating Form Validation: $formName');
  
  // Create form directory
  final formDir = Directory('lib/core/forms/$snakeCase');
  if (!formDir.existsSync()) {
    formDir.createSync(recursive: true);
    print('📁 Created: lib/core/forms/$snakeCase/');
  }
  
  // Create form files
  _createFormValidationFiles(snakeCase, pascalCase, formDisplayName);
  
  print('\n✅ Form Validation "$formName" created successfully!');
}

void _createFormValidationFiles(String snakeCase, String pascalCase, String formDisplayName) {
  // Form model
  final formModelFile = File('lib/core/forms/$snakeCase/${snakeCase}_form_model.dart');
  formModelFile.writeAsStringSync('''
// 📝 $pascalCase Form Model
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

// TODO: Define your form inputs here
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);
  
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\$',
  );
  
  @override
  EmailValidationError? validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

enum EmailValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);
  
  @override
  PasswordValidationError? validator(String value) {
    return value.length >= 6 ? null : PasswordValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class ${pascalCase}FormModel extends Equatable {
  const ${pascalCase}FormModel({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  });
  
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  
  ${pascalCase}FormModel copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return ${pascalCase}FormModel(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object> get props => [email, password, status];
}
''');
  print('📄 Created: lib/core/forms/$snakeCase/${snakeCase}_form_model.dart');
  
  // Form submission
  final formSubmissionFile = File('lib/core/forms/$snakeCase/${snakeCase}_form_submission.dart');
  formSubmissionFile.writeAsStringSync('''
// 📝 $pascalCase Form Submission
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';

abstract class ${pascalCase}FormSubmission {
  Future<Either<Failure, bool>> submit({
    required String email,
    required String password,
  });
}

class Mock${pascalCase}FormSubmission implements ${pascalCase}FormSubmission {
  @override
  Future<Either<Failure, bool>> submit({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement actual form submission logic
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, randomly succeed or fail
      final isSuccess = DateTime.now().millisecond % 2 == 0;
      
      if (isSuccess) {
        return const Right(true);
      } else {
        return Left(ServerFailure('Submission failed. Please try again.'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
''');
  print('📄 Created: lib/core/forms/$snakeCase/${snakeCase}_form_submission.dart');
  
  // Form cubit
  final formCubitFile = File('lib/core/forms/$snakeCase/${snakeCase}_form_cubit.dart');
  formCubitFile.writeAsStringSync('''
// 📝 $pascalCase Form Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import '${snakeCase}_form_model.dart';
import '${snakeCase}_form_submission.dart';

class ${pascalCase}FormCubit extends Cubit<${pascalCase}FormModel> {
  ${pascalCase}FormCubit() : super(const ${pascalCase}FormModel());
  
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: FormzSubmissionStatus.initial,
    ));
  }
  
  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: FormzSubmissionStatus.initial,
    ));
  }
  
  Future<void> formSubmitted(${pascalCase}FormSubmission submission) async {
    if (!state.isValid) return;
    
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    
    try {
      await submission.submit(
        email: state.email.value,
        password: state.password.value,
      );
      
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
''');
  print('📄 Created: lib/core/forms/$snakeCase/${snakeCase}_form_cubit.dart');
}

void _generateCustomWidgetBoilerplate() {
  stdout.write('\n📝 Enter widget name (e.g., custom_button): ');
  final widgetName = stdin.readLineSync()?.trim() ?? '';
  
  if (widgetName.isEmpty) {
    print('❌ Widget name cannot be empty!');
    return;
  }
  
  stdout.write('🔤 Enter widget display name (e.g., Custom Button): ');
  final widgetDisplayName = stdin.readLineSync()?.trim() ?? _toPascalCase(widgetName);
  
  stdout.write('🎨 Is widget stateless? (y/n): ');
  final isStateless = stdin.readLineSync()?.trim().toLowerCase() == 'y';
  
  final snakeCase = _toSnakeCase(widgetName);
  final pascalCase = _toPascalCase(widgetName);
  
  print('\n🔨 Creating Widget: $widgetName');
  
  // Create widget directory
  final widgetDir = Directory('lib/core/widgets/$snakeCase');
  if (!widgetDir.existsSync()) {
    widgetDir.createSync(recursive: true);
    print('📁 Created: lib/core/widgets/$snakeCase/');
  }
  
  // Create widget file
  _createCustomWidgetFile(snakeCase, pascalCase, widgetDisplayName, isStateless);
  
  print('\n✅ Widget "$widgetName" created successfully!');
}

void _createCustomWidgetFile(String snakeCase, String pascalCase, String widgetDisplayName, bool isStateless) {
  final widgetFile = File('lib/core/widgets/$snakeCase/${snakeCase}_widget.dart');
  
  if (isStateless) {
    widgetFile.writeAsStringSync('''
// 🎨 $widgetDisplayName
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class $pascalCase extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  
  const $pascalCase({
    this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Center(
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            foregroundColor ?? Colors.white,
          ),
        ),
      );
    }
    
    if (icon != null && text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(
              color: foregroundColor ?? Colors.white,
              size: 20.sp,
            ),
            child: icon!,
          ),
          SizedBox(width: 8.w),
          Text(
            text!,
            style: TextStyle(
              color: foregroundColor ?? Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else if (icon != null) {
      return IconTheme(
        data: IconThemeData(
          color: foregroundColor ?? Colors.white,
          size: 20.sp,
        ),
        child: icon!,
      );
    } else if (text != null) {
      return Text(
        text!,
        style: TextStyle(
          color: foregroundColor ?? Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
}
''');
  } else {
    widgetFile.writeAsStringSync('''
// 🎨 $widgetDisplayName
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class $pascalCase extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  
  const $pascalCase({
    this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    Key? key,
  }) : super(key: key);
  
  @override
  State<$pascalCase> createState() => _${pascalCase}State();
}

class _${pascalCase}State extends State<$pascalCase> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onPressed != null && !widget.isLoading) {
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
          border: widget.border,
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
            child: Padding(
              padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Center(
                child: _buildContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildContent() {
    if (widget.isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.foregroundColor ?? Colors.white,
          ),
        ),
      );
    }
    
    if (widget.icon != null && widget.text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(
              color: widget.foregroundColor ?? Colors.white,
              size: 20.sp,
            ),
            child: widget.icon!,
          ),
          SizedBox(width: 8.w),
          Text(
            widget.text!,
            style: TextStyle(
              color: widget.foregroundColor ?? Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else if (widget.icon != null) {
      return IconTheme(
        data: IconThemeData(
          color: widget.foregroundColor ?? Colors.white,
          size: 20.sp,
        ),
        child: widget.icon!,
      );
    } else if (widget.text != null) {
      return Text(
        widget.text!,
        style: TextStyle(
          color: widget.foregroundColor ?? Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
}
''');
  }
  
  print('📄 Created: lib/core/widgets/$snakeCase/${snakeCase}_widget.dart');
}

void _configureDependencies() {
  print('\n📦 Configuring dependencies...');
  
  // Read pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('❌ pubspec.yaml not found!');
    return;
  }
  
  String content = pubspecFile.readAsStringSync();
  
  // Parse pubspec.yaml
  final yamlMap = yaml.loadYaml(content) as Map;
  
  // Get current dependencies
  final dependencies = (yamlMap['dependencies'] as Map?)?.cast<String, dynamic>() ?? {};
  final devDependencies = (yamlMap['dev_dependencies'] as Map?)?.cast<String, dynamic>() ?? {};
  
  print('\n📦 Current dependencies:');
  dependencies.forEach((key, value) {
    print('  $key: $value');
  });
  
  print('\n🛠️ Available dependency groups:');
  print('1. Core (bloc, equatable, get_it, go_router, etc.)');
  print('2. Network (dio, connectivity_plus, etc.)');
  print('3. Storage (shared_preferences, flutter_secure_storage, etc.)');
  print('4. UI (flutter_screenutil, lottie, etc.)');
  print('5. Analytics (firebase_analytics, etc.)');
  print('6. All of the above');
  
  stdout.write('\nEnter your choice (1-6): ');
  final choice = stdin.readLineSync();
  
  Map<String, String> newDependencies = {};
  Map<String, String> newDevDependencies = {};
  
  switch (choice) {
    case '1':
      newDependencies = {
        'flutter_bloc': '^8.1.3',
        'equatable': '^2.0.5',
        'get_it': '^7.6.4',
        'go_router': '^10.1.2',
        'dartz': '^0.10.1',
        'formz': '^0.6.1',
        'internet_connection_checker': '^1.0.0+1',
      };
      break;
    case '2':
      newDependencies = {
        'dio': '^5.3.2',
        'connectivity_plus': '^4.0.2',
        'retrofit': '^4.0.3',
        'json_annotation': '^4.8.1',
      };
      newDevDependencies = {
        'json_serializable': '^6.7.1',
        'retrofit_generator': '^7.0.8',
        'build_runner': '^2.4.6',
      };
      break;
    case '3':
      newDependencies = {
        'shared_preferences': '^2.2.1',
        'flutter_secure_storage': '^9.0.0',
        'hive': '^2.2.3',
        'hive_flutter': '^1.1.0',
        'path_provider': '^2.1.1',
      };
      newDevDependencies = {
        'hive_generator': '^2.0.1',
      };
      break;
    case '4':
      newDependencies = {
        'flutter_screenutil': '^5.9.0',
        'lottie': '^2.6.0',
        'flutter_svg': '^2.0.7',
        'cached_network_image': '^3.3.0',
        'shimmer': '^3.0.0',
      };
      break;
    case '5':
      newDependencies = {
        'firebase_core': '^2.24.0',
        'firebase_analytics': '^10.7.0',
        'firebase_crashlytics': '^3.4.4',
        'firebase_performance': '^0.9.3+4',
      };
      break;
    case '6':
      newDependencies = {
        'flutter_bloc': '^8.1.3',
        'equatable': '^2.0.5',
        'get_it': '^7.6.4',
        'go_router': '^10.1.2',
        'dartz': '^0.10.1',
        'formz': '^0.6.1',
        'internet_connection_checker': '^1.0.0+1',
        'dio': '^5.3.2',
        'connectivity_plus': '^4.0.2',
        'retrofit': '^4.0.3',
        'json_annotation': '^4.8.1',
        'shared_preferences': '^2.2.1',
        'flutter_secure_storage': '^9.0.0',
        'hive': '^2.2.3',
        'hive_flutter': '^1.1.0',
        'path_provider': '^2.1.1',
        'flutter_screenutil': '^5.9.0',
        'lottie': '^2.6.0',
        'flutter_svg': '^2.0.7',
        'cached_network_image': '^3.3.0',
        'shimmer': '^3.0.0',
        'firebase_core': '^2.24.0',
        'firebase_analytics': '^10.7.0',
        'firebase_crashlytics': '^3.4.4',
        'firebase_performance': '^0.9.3+4',
      };
      newDevDependencies = {
        'json_serializable': '^6.7.1',
        'retrofit_generator': '^7.0.8',
        'build_runner': '^2.4.6',
        'hive_generator': '^2.0.1',
      };
      break;
    default:
      print('❌ Invalid choice. Please try again.');
      return;
  }
  
  // Add new dependencies
  newDependencies.forEach((key, value) {
    if (!dependencies.containsKey(key)) {
      dependencies[key] = value;
      print('✅ Added dependency: $key: $value');
    } else {
      print('⚠️ Dependency already exists: $key');
    }
  });
  
  newDevDependencies.forEach((key, value) {
    if (!devDependencies.containsKey(key)) {
      devDependencies[key] = value;
      print('✅ Added dev dependency: $key: $value');
    } else {
      print('⚠️ Dev dependency already exists: $key');
    }
  });
  
  // Update pubspec.yaml
  final updatedYamlMap = Map<String, dynamic>.from(yamlMap);
  updatedYamlMap['dependencies'] = dependencies;
  updatedYamlMap['dev_dependencies'] = devDependencies;
  
  // Convert back to YAML string
  // Use yaml_writer package to serialize the updatedYamlMap to YAML string
  // Add dependency: yaml_writer: ^1.0.0 to your pubspec.yaml if not already present

  final yamlWriter = YamlWriter();
  final yamlString = yamlWriter.write(updatedYamlMap);

  // Write to file
  pubspecFile.writeAsStringSync(yamlString);
  
  print('\n✅ Dependencies configured successfully!');
  print('\n📝 Run "flutter pub get" to install the new dependencies.');
}

void _createProjectReadme(String projectName, bool enableLocalization, bool enableTheming, bool enableAnalytics, bool enableAuth) {
  final readmeFile = File('PROJECT_README.md');
  
  readmeFile.writeAsStringSync('''
# $projectName

A Flutter project with clean architecture and best practices.

## Features

- Clean Architecture with BLoC pattern
- Dependency Injection with GetIt
- Routing with GoRouter
${enableTheming ? "- Dark/Light Theme Support" : ""}
${enableLocalization ? "- Internationalization (i18n)" : ""}
${enableAnalytics ? "- Analytics Integration" : ""}
${enableAuth ? "- Authentication Flow" : ""}

## Project Structure

```
lib/
├── core/                  # Core functionality
│   ├── errors/            # Custom exceptions and failures
│   ├── network/           # Network-related code
│   ├── utils/             # Utility functions and constants
│   ├── widgets/           # Reusable widgets
│   ├── services/          # App services
│   ├── usecases/          # Use cases for business logic
│   └── common/            # Common resources
${enableTheming ? "│   └── theme/             # Theme-related code" : ""}
${enableLocalization ? "│   └── l10n/              # Localization" : ""}
${enableAnalytics ? "│   └── analytics/         # Analytics service" : ""}
└── features/              # Feature modules
    ${enableAuth ? "├── auth/              # Authentication feature" : ""}
    └── settings/          # Settings feature
```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

### Core
- flutter_bloc: State management
- equatable: Value equality
- get_it: Service locator
- go_router: Declarative routing
- dartz: Functional programming
- formz: Form input validation

### Network
- dio: HTTP client
- connectivity_plus: Network connectivity
- internet_connection_checker: Internet connection

### Storage
- shared_preferences: Local storage
- flutter_secure_storage: Secure storage

### UI
- flutter_screenutil: Screen adaptation
- lottie: Animation
- cached_network_image: Cached images

${enableAnalytics ? "### Analytics\n- firebase_core: Firebase core\n- firebase_analytics: Firebase analytics\n" : ""}
${enableAuth ? "### Authentication\n- (Add your auth dependencies here)\n" : ""}

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Commit your changes
5. Push to the branch
6. Create a Pull Request

## License

This project is licensed under the MIT License.
''');
  
  print('📄 Created: PROJECT_README.md');
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
