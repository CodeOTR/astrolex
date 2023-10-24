import 'package:astrolex/features/home/ui/past_research/past_research_view.dart';
import 'package:astrolex/features/search/ui/ai_librarian_view.dart';
import 'package:astrolex/features/search/ui/concept_works.dart';
import 'package:astrolex/features/search/ui/details/concept_details_view.dart';
import 'package:astrolex/features/search/ui/details/related_works_view.dart';
import 'package:astrolex/features/search/ui/details/work_details.dart';
import 'package:astrolex/features/search/ui/search_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:astrolex/features/authentication/ui/forgot_password_view.dart';
import 'package:astrolex/features/authentication/ui/profile_view.dart';
import 'package:astrolex/features/authentication/ui/register_view.dart';
import 'package:astrolex/features/authentication/ui/sign_in_view.dart';
import 'package:astrolex/features/home/ui/home/home_view.dart';

import 'package:astrolex/features/home/ui/onboarding/onboarding_view.dart';
import 'package:astrolex/features/settings/ui/settings/settings_view.dart';
import 'package:astrolex/features/shared/utils/navigation/auth_guard.dart';
import 'package:openalex/models/models.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: ('View,Route'))
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard()]),
        AutoRoute(page: OnboardingRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: ConceptDetailsRoute.page),
        AutoRoute(page: ConceptWorksRoute.page),
        AutoRoute(page: WorkDetailsRoute.page),
        AutoRoute(page: AiLibrarianRoute.page),
        AutoRoute(page: RelatedWorksRoute.page),
        AutoRoute(page: PastResearchRoute.page),
      ];
}
