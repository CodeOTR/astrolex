import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:astrolex/features/search/ui/details/widgets/related_concepts.dart';
import 'package:astrolex/features/search/ui/details/widgets/related_works_button.dart';
import 'package:astrolex/features/search/ui/librarian_button.dart';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';
import 'package:openalex/openalex.dart';

@RoutePage()
class WorkDetailsView extends StatefulWidget {
  const WorkDetailsView({Key? key, required this.workId}) : super(key: key);

  final String workId;

  @override
  State<WorkDetailsView> createState() => _WorkDetailsViewState();
}

class _WorkDetailsViewState extends State<WorkDetailsView> {
  Future<Work?> getWork() async {
    return await OpenAlex().getWork(widget.workId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Work?>(
        future: getWork(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                appBar: AppBar(title: const Text('Work Details')),
                body: const Center(child: CircularProgressIndicator()),
                floatingActionButton: const LibrarianButton(
                  searchTerm: '',
                ));
          }

          if (snapshot.data == null) {
            return Scaffold(
                appBar: AppBar(title: const Text('Work Not Found')),
                body: const Center(child: CircularProgressIndicator()),
                floatingActionButton: const LibrarianButton(
                  searchTerm: '',
                ));
          }

          Work work = snapshot.data!;
          return Scaffold(
              appBar: AppBar(title: const Text("Work Details")),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(work.title ?? "No Title", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text("DOI: ${work.doi ?? 'N/A'}"),
                      const SizedBox(height: 10),
                      if (work.abstractInvertedIndex != null)
                        Text("Abstract: ${work.abstractInvertedIndex!.entries.map((e) => e.key).toList().join(' ')}"), // Consider converting the abstract inverted index to human-readable text.
                      const SizedBox(height: 10),
                      Text("Publication Date: ${work.publicationDate?.toLocal().toString() ?? 'N/A'}"),
                      const SizedBox(height: 10),
                      ...work.authorships?.map((authorship) => Text(authorship.author?.displayName ?? 'N/A')).toList() ?? [],
                      const SizedBox(height: 10),
                      if (work.isOA == true) const Text("This work is Open Access"),
                      if ((work.referencedWorks != null && work.referencedWorks!.isNotEmpty) || (work.relatedWorks != null && work.relatedWorks!.isNotEmpty)) RelatedWorksButton(work: work),
                      const Divider(),
                      Text(
                        "Associated Terminology",
                        style: context.headlineMedium.primary,
                      ),
                      gap8,
                      RelatedConcepts(relatedConcepts: work.concepts?.map((e) => DehydratedConcept(id: e.id, displayName: e.displayName, level: e.level)).toList()),
                    ],
                  ),
                ),
              ),
              floatingActionButton: LibrarianButton(
                searchTerm: work.title ?? work.concepts?.first.displayName ?? '',
              ));
        });
  }
}
