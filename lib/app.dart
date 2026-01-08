import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinder_world/core/localization/app_localizations.dart' as custom_localizations;
import 'package:kinder_world/core/theme/app_theme.dart';
import 'package:kinder_world/core/storage/secure_storage.dart';
import 'package:kinder_world/core/network/network_service.dart';
import 'package:kinder_world/router.dart';
import 'package:logger/logger.dart';

// Providers
final secureStorageProvider = Provider<SecureStorage>((ref) {
  throw UnimplementedError('secureStorageProvider must be overridden');
});

final loggerProvider = Provider<Logger>((ref) {
  throw UnimplementedError('loggerProvider must be overridden');
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final logger = ref.watch(loggerProvider);
  return NetworkService(
    secureStorage: secureStorage,
    logger: logger,
  );
});

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

class KinderWorldApp extends ConsumerWidget {
  const KinderWorldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    
    return MaterialApp.router(
      title: 'Kinder World',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: AppTheme.lightTheme(isChildFriendly: true),
      darkTheme: AppTheme.darkTheme(isChildFriendly: true),
      themeMode: themeMode,
      
      // Localization
      localizationsDelegates: [
        custom_localizations.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: locale,
      
      // Router
      routerConfig: ref.watch(routerProvider),
      
      // Builder for app-level configurations
      builder: (context, child) {
        // Force text direction based on locale
        final isRTL = locale.languageCode == 'ar';
        
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}