import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:astrolex/features/search/ui/details/widgets/related_concepts.dart';
import 'package:astrolex/features/search/ui/details/widgets/seminal_papers_button.dart';
import 'package:astrolex/features/search/ui/details/widgets/trend_chart.dart';
import 'package:astrolex/features/search/ui/details/widgets/trend_indicator.dart';
import 'package:astrolex/features/search/ui/librarian_button.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';
import 'package:openalex/openalex.dart';
// Import your extensions

@RoutePage()
class ConceptDetailsView extends StatelessWidget {
  final String conceptId;

  const ConceptDetailsView({super.key, required this.conceptId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Concept?>(
        future: OpenAlex().getConcept(conceptId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(appBar: AppBar(title: const Text('Concept Details')), body: const Center(child: CircularProgressIndicator()), floatingActionButton: const LibrarianButton(searchTerm: '',));
          }

          if (snapshot.data == null) {
            return Scaffold(appBar: AppBar(title: const Text('Concept Details')), body: const Center(child: Text('Concept not found')), floatingActionButton: const LibrarianButton(searchTerm: '',));
          }

          Concept concept = snapshot.data!;

          return Scaffold(
              appBar: AppBar(
                title: Text('${concept.displayName}', style: context.titleMedium.primary),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(concept.description ?? 'No description available.'),

                      if (concept.imageUrl != null)
                        ...[Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Image.network(concept.imageUrl!),
                        )],
                      gap16,
                      // Trending vs. Stagnant Topics using countsByYear
                      Text(
                        "Publication Trends",
                        style: context.headlineMedium.primary,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200, // Adjust based on your needs
                        child: Card(
                          elevation: 4.0,
                          child: TrendChart(countsByYear: concept.countsByYear), // Placeholder for chart
                        ),
                      ),
                      TrendIndicator(countsByYear: concept.countsByYear!), // Placeholder for trend indicator

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cited By Count: ${concept.citedByCount ?? 0}'),
                      ),
                      SeminalPapersButton(conceptId: conceptId),
                      const SizedBox(height: 20),
                      // Associated Terminology from relatedConcepts
                      Text(
                        "Associated Terminology",
                        style: context.headlineMedium.primary,
                      ),
                      const SizedBox(height: 10),
                      RelatedConcepts(relatedConcepts: concept.relatedConcepts),
                    ],
                  ),
                ),
              ),
              floatingActionButton:  LibrarianButton(searchTerm: concept.displayName ?? '',));
        });
  }
}

