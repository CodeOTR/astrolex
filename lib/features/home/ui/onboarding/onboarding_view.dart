import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/features/home/ui/onboarding/widgets/page_one.dart';
import 'package:astrolex/features/home/ui/onboarding/widgets/page_three.dart';
import 'package:astrolex/features/home/ui/onboarding/widgets/page_two.dart';

@RoutePage()
class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: pageController, children: const [
        PageOne(),
        PageTwo(),
        PageThree(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (pageController.page == 2) {
            router.replace(const HomeRoute());
          } else if (pageController.page == 1) {
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          } else if (pageController.page == 0) {
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
