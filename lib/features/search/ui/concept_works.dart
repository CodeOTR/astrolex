import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:astrolex/features/search/ui/librarian_button.dart';
import 'package:astrolex/features/search/ui/widgets/work_card.dart';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';
import 'package:openalex/openalex.dart';

@RoutePage()
class ConceptWorksView extends StatelessWidget {
  const ConceptWorksView({Key? key, required this.conceptId}) : super(key: key);

  final String conceptId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MetaWorks?>(
        future: OpenAlex().getWorks(queryFilter: {WorkFilter.concepts: conceptId}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(appBar: AppBar(title: const Text('Works related to Concept')), body: const Center(child: CircularProgressIndicator()), floatingActionButton: const LibrarianButton(searchTerm: '',));
          }

          if (snapshot.data == null) {
            Scaffold(appBar: AppBar(title: const Text('Concept Not Found')), body: const Center(child: CircularProgressIndicator()), floatingActionButton: const LibrarianButton(searchTerm: '',));
          }

          List<Work> works = snapshot.data?.works ?? [];
          return Scaffold(
              appBar: AppBar(
                title: Text('Works related to ${searchService.concept?.displayName ?? 'Unknown Concept'}', style: context.titleMedium.primary),
              ),
              body: ListView.builder(
                itemCount: works.length,
                itemBuilder: (context, index) {
                  Work work = works[index];

                  return WorkCard(work: work);
                },
              ),
              floatingActionButton:  LibrarianButton(
                searchTerm: searchService.concept?.displayName ?? '',
              ));
        });
  }
}
