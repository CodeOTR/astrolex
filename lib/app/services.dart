import 'package:astrolex/features/search/services/search_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astrolex/app/get_it.dart';
import 'package:astrolex/app/router.dart';
import 'package:astrolex/features/authentication/services/authentication_service/fast_authentication_service.dart';
import 'package:astrolex/features/authentication/services/user_service/fast_user_service.dart';
import 'package:astrolex/features/monitoring/services/fast_analytics_service.dart';
import 'package:astrolex/features/monitoring/services/fast_crash_service.dart';
import 'package:astrolex/features/settings/services/settings_service.dart';
import 'package:astrolex/features/shared/services/connector_service/fast_connector_service.dart';

AppRouter get router => getIt.get<AppRouter>();

FastAnalyticsService get analyticsService => getIt.get<FastAnalyticsService>();

FastAuthenticationService get authenticationService => getIt.get<FastAuthenticationService>();

FastConnectorService get connectorService => getIt.get<FastConnectorService>();

FastCrashService get crashService => getIt.get<FastCrashService>();

FastUserService get userService => getIt.get<FastUserService>();

SearchService get searchService => getIt.get<SearchService>();

SettingsService get settingsService => getIt.get<SettingsService>();

SharedPreferences get sharedPrefs => getIt.get<SharedPreferences>();
