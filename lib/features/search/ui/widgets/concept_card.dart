import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';

class ConceptCard extends StatelessWidget {
  final Concept concept;

  const ConceptCard({super.key, required this.concept});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
          searchService.setConcept(concept);
          searchService.addConcept(concept);
          router.push(ConceptDetailsRoute(conceptId: concept.id!));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Concept Title
              Text(
                concept.displayName ?? "Unknown Concept",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Concept Description
              Text(
                concept.description ?? "Description not available",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Works Count
              if (concept.worksCount != null) Text("Works Count: ${concept.worksCount}"),
              // Cited By Count
              if (concept.citedByCount != null) Text("Cited By Count: ${concept.citedByCount}"),
              // ... you can continue displaying other relevant info similarly
            ],
          ),
        ),
      ),
    );
  }
}
