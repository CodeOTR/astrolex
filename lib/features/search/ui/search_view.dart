import 'package:astrolex/features/search/ui/librarian_button.dart';
import 'package:astrolex/features/search/ui/widgets/concept_card.dart';
import 'package:astrolex/features/search/ui/widgets/work_card.dart';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/author/meta_authors.dart';
import 'package:openalex/models/models.dart';
import 'package:openalex/openalex.dart';

@RoutePage()
class SearchView extends StatelessWidget {
  const SearchView({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Search Results'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Concepts'),
                Tab(text: 'Works'),
               //Tab(text: 'Authors'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder<MetaConcepts>(
                  future: OpenAlex().getConcepts(query: query, perPage: 5),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<Concept> concepts = snapshot.data?.concepts ?? [];

                    return concepts.isEmpty
                        ? Center(
                            child: Text('No results found for $query'),
                          )
                        : ListView.builder(
                            itemCount: concepts.length,
                            itemBuilder: (context, index) {
                              return ConceptCard(concept: concepts[index]);
                            },
                          );
                  }),
              FutureBuilder<MetaWorks?>(
                  future: OpenAlex().getWorks(query: query, perPage: 5),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<Work> works = snapshot.data?.works ?? [];

                    return works.isEmpty
                        ? Center(
                            child: Text('No results found for $query'),
                          )
                        : ListView.builder(
                            itemCount: works.length,
                            itemBuilder: (context, index) {
                              return WorkCard(work: works[index]);
                            },
                          );
                  }),
              /*FutureBuilder<MetaAuthors?>(
                  future: OpenAlex().getAuthors(queryFilter: {AuthorFilter.concepts: query}),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<Author> authors = snapshot.data?.authors ?? [];

                    return authors.isEmpty
                        ? Center(
                            child: Text('No results found for $query'),
                          )
                        : ListView.builder(
                            itemCount: authors.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 2,
                                  child: ListTile(
                                      title: Text(authors[index].displayName ?? "No name available."),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Citations: ${authors[index].citedByCount ?? 0}'),
                                          Text('Created Date: ${authors[index].createdDate ?? 'Unknown'}'),
                                        ],
                                      ),
                                      onTap: () {
                                        // searchService.addWork(work);
                                        // work.authorships?.forEach((element) {
                                        //   searchService.addAuthor(element.author?.displayName ?? '', work.citedByCount ?? 0);
                                        // });
                                        // router.push(WorkDetailsRoute(workId: work.id!)
                                      }));
                            },
                          );
                  }),*/
            ],
          ),
          floatingActionButton:  LibrarianButton(searchTerm: query,)),
    );
  }
}
