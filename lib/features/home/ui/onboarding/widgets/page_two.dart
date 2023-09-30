import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Seamless Exploration',
              textAlign: TextAlign.center,
              style: context.headlineSmall,
            ).animate(effects: [
              const FadeEffect(delay: Duration(milliseconds: 300))
            ]),
            gap16,
             Text(
              'Input your research topic or keyword and let AstroLex guide you through relevant concepts, research gaps, and associated terminologies.',
              textAlign: TextAlign.center,
              style: context.titleMedium,
            ).animate(effects: [const FadeEffect(delay: Duration(milliseconds: 500))]),
          ],
        ),
      ),
    );
  }
}
