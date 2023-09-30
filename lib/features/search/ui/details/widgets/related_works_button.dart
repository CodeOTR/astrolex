import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';

class RelatedWorksButton extends StatelessWidget {
  const RelatedWorksButton({Key? key, required this.work}) : super(key: key);

  final Work work;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          router.push(RelatedWorksRoute(work: work));
        },
        child: const Row(
          children: [
            Text('Related Works'),
          ],
        ));
  }
}
