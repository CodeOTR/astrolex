import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:flutter/material.dart';

class SeminalPapersButton extends StatelessWidget {
  const SeminalPapersButton({Key? key, required this.conceptId}) : super(key: key);

  final String conceptId;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          router.push(ConceptWorksRoute(conceptId: conceptId));
        },
        child: const Row(
          children: [
            Text('Seminal Papers'),
          ],
        ));
  }
}
