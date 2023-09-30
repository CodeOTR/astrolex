import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/concept/dehydrated_concept.dart';
import 'package:openalex/models/models.dart';

class RelatedConcepts extends StatefulWidget {
  const RelatedConcepts({Key? key, this.relatedConcepts}) : super(key: key);

  final List<DehydratedConcept>? relatedConcepts;

  @override
  State<RelatedConcepts> createState() => _RelatedConceptsState();
}

class _RelatedConceptsState extends State<RelatedConcepts> {
  int selectedLevel = 5;
  bool isSliderActive = false; // New variable to track switch state

  @override
  Widget build(BuildContext context) {
    if (widget.relatedConcepts == null || widget.relatedConcepts!.isEmpty) {
      return Text("No associated terminology available.", style: context.bodyMedium.secondary);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Filter by Level'),
            Switch(
              value: isSliderActive,
              onChanged: (bool value) {
                setState(() {
                  isSliderActive = value;
                });
              },
            ),
          ],
        ),
        if (isSliderActive)
          Row(
            children: [
              const Text('General'),
              Expanded(
                child: Slider(
                  max: 5,
                  min: 0,
                  activeColor: _getColorForLevel(selectedLevel),
                  thumbColor: _getColorForLevel(selectedLevel),
                  value: selectedLevel.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      selectedLevel = value.toInt();
                    });
                  },
                ),
              ),
              const Text('Specific'),
            ],
          ),
        ...widget.relatedConcepts!.where((element) => isSliderActive ? (element.level ?? 0) == selectedLevel : true).map((concept) {
          return ListTile(
            title: Text(concept.displayName ?? "Unknown", style: context.bodyLarge),
            subtitle: Text(concept.id ?? "No description available.", style: context.bodySmall.secondary),
            // Add onTap or trailing actions if needed
            trailing: CircleAvatar(
              backgroundColor: _getColorForLevel(concept.level ?? 0),
              child: Text(
                (concept.level ?? 0).toString(),
                style: TextStyle(color: _getColorForLevel(concept.level ?? 0).isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              searchService.addConcept(Concept(id: concept.id, displayName: concept.displayName, level: concept.level));
              router.push(ConceptDetailsRoute(conceptId: concept.id!));
            },
          );
        }).toList()
      ],
    );
  }
}

Color _getColorForLevel(int level) {
  switch (level) {
    case 0:
      return Colors.red; // General concepts
    case 1:
      return Colors.orange;
    case 2:
      return Colors.yellow;
    case 3:
      return Colors.green;
    case 4:
      return Colors.blue;
    case 5:
      return Colors.purple; // Specific concepts
    default:
      return Colors.grey; // Fallback for any unexpected levels
  }
}
