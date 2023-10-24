import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:astrolex/app/get_it.dart';
import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/app/theme.dart';
import 'package:astrolex/features/shared/utils/navigation/basic_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await authenticationService.initialize();
  await analyticsService.initialize();
  GetIt.instance.registerSingleton(AppRouter());

  lightLogoColorScheme = await ColorScheme.fromImageProvider(
      provider: const AssetImage('assets/images/logo.png'),
      brightness: Brightness.light);
  darkLogoColorScheme = await ColorScheme.fromImageProvider(
      provider: const AssetImage('assets/images/logo.png'),
      brightness: Brightness.dark);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingsService.themeMode,
        builder: (context, mode, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: mode,
            routerConfig: router.config(
              navigatorObservers: () => [
                BasicObserver(),
              ],
            ),
          );
        });
  }
}
