// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i18;

import '../features/authentication/services/authentication_service/fast_authentication_service.dart'
    as _i5;
import '../features/authentication/services/authentication_service/firebase_authentication_service.dart'
    as _i6;
import '../features/authentication/services/user_service/fast_user_service.dart'
    as _i15;
import '../features/authentication/services/user_service/firebase_user_service.dart'
    as _i16;
import '../features/feedback/services/fast_feedback_service.dart' as _i13;
import '../features/feedback/services/firebase_feedback_service.dart' as _i14;
import '../features/monitoring/services/amplitude_analytics_service.dart'
    as _i4;
import '../features/monitoring/services/crash_service.dart' as _i12;
import '../features/monitoring/services/fast_analytics_service.dart' as _i3;
import '../features/monitoring/services/fast_crash_service.dart' as _i11;
import '../features/search/services/search_service.dart' as _i17;
import '../features/settings/services/settings_service.dart' as _i19;
import '../features/shared/services/connector_service/fast_connector_service.dart'
    as _i9;
import '../features/shared/services/connector_service/firebase_connector_service.dart'
    as _i10;
import '../features/shared/services/modules.dart' as _i20;
import '../modules/chat/services/chat_service.dart' as _i8;
import '../modules/chat/services/fast_chat_service.dart' as _i7;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.FastAnalyticsService>(_i4.AmplitudeAnalyticsService());
  gh.singleton<_i5.FastAuthenticationService>(
      _i6.FirebaseAuthenticationService());
  gh.lazySingleton<_i7.FastChatService>(() => _i8.ChatService());
  gh.factory<_i9.FastConnectorService>(() => _i10.FirebaseConnectorService());
  gh.singleton<_i11.FastCrashService>(_i12.CrashService());
  gh.lazySingleton<_i13.FastFeedbackService>(
      () => _i14.FirebaseFeedbackService());
  gh.lazySingleton<_i15.FastUserService>(() => _i16.FirebaseUserService());
  gh.singleton<_i17.SearchService>(_i17.SearchService());
  await gh.factoryAsync<_i18.SharedPreferences>(
    () => registerModule.sharedPrefs,
    preResolve: true,
  );
  gh.singleton<_i19.SettingsService>(_i19.SettingsService());
  return getIt;
}

class _$RegisterModule extends _i20.RegisterModule {}
