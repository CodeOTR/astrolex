// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AiLibrarianRoute.name: (routeData) {
      final args = routeData.argsAs<AiLibrarianRouteArgs>(
          orElse: () => const AiLibrarianRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AiLibrarianView(key: args.key),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatView(),
      );
    },
    ConceptDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ConceptDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConceptDetailsView(
          key: args.key,
          conceptId: args.conceptId,
        ),
      );
    },
    ConceptWorksRoute.name: (routeData) {
      final args = routeData.argsAs<ConceptWorksRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConceptWorksView(
          key: args.key,
          conceptId: args.conceptId,
        ),
      );
    },
    FeedbackRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FeedbackView(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>(
          orElse: () => const ForgotPasswordRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForgotPasswordView(
          key: args.key,
          email: args.email,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    NewFeedbackRoute.name: (routeData) {
      final args = routeData.argsAs<NewFeedbackRouteArgs>(
          orElse: () => const NewFeedbackRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewFeedbackView(key: args.key),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingView(),
      );
    },
    PastResearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PastResearchView(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterView(),
      );
    },
    RelatedWorksRoute.name: (routeData) {
      final args = routeData.argsAs<RelatedWorksRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RelatedWorksView(
          key: args.key,
          work: args.work,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchView(
          key: args.key,
          query: args.query,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsView(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInView(),
      );
    },
    WorkDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<WorkDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkDetailsView(
          key: args.key,
          workId: args.workId,
        ),
      );
    },
  };
}

/// generated route for
/// [AiLibrarianView]
class AiLibrarianRoute extends PageRouteInfo<AiLibrarianRouteArgs> {
  AiLibrarianRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AiLibrarianRoute.name,
          args: AiLibrarianRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AiLibrarianRoute';

  static const PageInfo<AiLibrarianRouteArgs> page =
      PageInfo<AiLibrarianRouteArgs>(name);
}

class AiLibrarianRouteArgs {
  const AiLibrarianRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AiLibrarianRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ChatView]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConceptDetailsView]
class ConceptDetailsRoute extends PageRouteInfo<ConceptDetailsRouteArgs> {
  ConceptDetailsRoute({
    Key? key,
    required String conceptId,
    List<PageRouteInfo>? children,
  }) : super(
          ConceptDetailsRoute.name,
          args: ConceptDetailsRouteArgs(
            key: key,
            conceptId: conceptId,
          ),
          initialChildren: children,
        );

  static const String name = 'ConceptDetailsRoute';

  static const PageInfo<ConceptDetailsRouteArgs> page =
      PageInfo<ConceptDetailsRouteArgs>(name);
}

class ConceptDetailsRouteArgs {
  const ConceptDetailsRouteArgs({
    this.key,
    required this.conceptId,
  });

  final Key? key;

  final String conceptId;

  @override
  String toString() {
    return 'ConceptDetailsRouteArgs{key: $key, conceptId: $conceptId}';
  }
}

/// generated route for
/// [ConceptWorksView]
class ConceptWorksRoute extends PageRouteInfo<ConceptWorksRouteArgs> {
  ConceptWorksRoute({
    Key? key,
    required String conceptId,
    List<PageRouteInfo>? children,
  }) : super(
          ConceptWorksRoute.name,
          args: ConceptWorksRouteArgs(
            key: key,
            conceptId: conceptId,
          ),
          initialChildren: children,
        );

  static const String name = 'ConceptWorksRoute';

  static const PageInfo<ConceptWorksRouteArgs> page =
      PageInfo<ConceptWorksRouteArgs>(name);
}

class ConceptWorksRouteArgs {
  const ConceptWorksRouteArgs({
    this.key,
    required this.conceptId,
  });

  final Key? key;

  final String conceptId;

  @override
  String toString() {
    return 'ConceptWorksRouteArgs{key: $key, conceptId: $conceptId}';
  }
}

/// generated route for
/// [FeedbackView]
class FeedbackRoute extends PageRouteInfo<void> {
  const FeedbackRoute({List<PageRouteInfo>? children})
      : super(
          FeedbackRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgotPasswordView]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    Key? key,
    String? email,
    List<PageRouteInfo>? children,
  }) : super(
          ForgotPasswordRoute.name,
          args: ForgotPasswordRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const PageInfo<ForgotPasswordRouteArgs> page =
      PageInfo<ForgotPasswordRouteArgs>(name);
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({
    this.key,
    this.email,
  });

  final Key? key;

  final String? email;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewFeedbackView]
class NewFeedbackRoute extends PageRouteInfo<NewFeedbackRouteArgs> {
  NewFeedbackRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NewFeedbackRoute.name,
          args: NewFeedbackRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NewFeedbackRoute';

  static const PageInfo<NewFeedbackRouteArgs> page =
      PageInfo<NewFeedbackRouteArgs>(name);
}

class NewFeedbackRouteArgs {
  const NewFeedbackRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NewFeedbackRouteArgs{key: $key}';
  }
}

/// generated route for
/// [OnboardingView]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PastResearchView]
class PastResearchRoute extends PageRouteInfo<void> {
  const PastResearchRoute({List<PageRouteInfo>? children})
      : super(
          PastResearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'PastResearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileView]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterView]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RelatedWorksView]
class RelatedWorksRoute extends PageRouteInfo<RelatedWorksRouteArgs> {
  RelatedWorksRoute({
    Key? key,
    required Work work,
    List<PageRouteInfo>? children,
  }) : super(
          RelatedWorksRoute.name,
          args: RelatedWorksRouteArgs(
            key: key,
            work: work,
          ),
          initialChildren: children,
        );

  static const String name = 'RelatedWorksRoute';

  static const PageInfo<RelatedWorksRouteArgs> page =
      PageInfo<RelatedWorksRouteArgs>(name);
}

class RelatedWorksRouteArgs {
  const RelatedWorksRouteArgs({
    this.key,
    required this.work,
  });

  final Key? key;

  final Work work;

  @override
  String toString() {
    return 'RelatedWorksRouteArgs{key: $key, work: $work}';
  }
}

/// generated route for
/// [SearchView]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    Key? key,
    required String query,
    List<PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            query: query,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<SearchRouteArgs> page = PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.query,
  });

  final Key? key;

  final String query;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, query: $query}';
  }
}

/// generated route for
/// [SettingsView]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInView]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkDetailsView]
class WorkDetailsRoute extends PageRouteInfo<WorkDetailsRouteArgs> {
  WorkDetailsRoute({
    Key? key,
    required String workId,
    List<PageRouteInfo>? children,
  }) : super(
          WorkDetailsRoute.name,
          args: WorkDetailsRouteArgs(
            key: key,
            workId: workId,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkDetailsRoute';

  static const PageInfo<WorkDetailsRouteArgs> page =
      PageInfo<WorkDetailsRouteArgs>(name);
}

class WorkDetailsRouteArgs {
  const WorkDetailsRouteArgs({
    this.key,
    required this.workId,
  });

  final Key? key;

  final String workId;

  @override
  String toString() {
    return 'WorkDetailsRouteArgs{key: $key, workId: $workId}';
  }
}
