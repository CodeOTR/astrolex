import 'package:flutter/gestures.dart';
import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Knowledge at Your Fingertips',
              textAlign: TextAlign.center,
              style: context.headlineSmall,).animate(effects: [
              const FadeEffect(delay: Duration(milliseconds: 300))
            ]),
            gap16,
             Text(
              'From seminal papers to the latest trends, AstroLex offers insights tailored to your research needs. Stay informed and ahead with our AI-driven analysis.',
              textAlign: TextAlign.center,
              style: context.titleMedium,
            ).animate(effects: [const FadeEffect(delay: Duration(milliseconds: 500))]),
          ],
        ),
      ),
    );
  }
}
