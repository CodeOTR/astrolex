import 'package:astrolex/features/search/ui/widgets/work_card.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';
import 'package:openalex/openalex.dart';

@RoutePage()
class RelatedWorksView extends StatelessWidget {
  const RelatedWorksView({Key? key, required this.work}) : super(key: key);

  final Work work;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Related Works'),
        bottom: const TabBar(
           tabs: [
              Tab(text: "Related Works"),
              Tab(text: "Referenced Works"),
           ],
        ),),
        body: TabBarView(
          children: [FutureBuilder<MetaWorks?>(
            future: OpenAlex().getWorksById(ids:work.relatedWorks ?? []),
            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if(snapshot.data == null) {
                return const Center(child: Text("No Related Works Found"));
              }

              return ListView.builder(
                itemCount: snapshot.data?.works?.length ?? 0,
                itemBuilder: (context, index) {
                  Work work = snapshot.data!.works![index];
                  return WorkCard(work: work);
                },
              );
            },
          ),
            FutureBuilder<MetaWorks?>(
              future: OpenAlex().getWorksById(ids:work.referencedWorks ?? []),
              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if(snapshot.data == null) {
                  return const Center(child: Text("No Referenced Works Found"));
                }

                return ListView.builder(
                  itemCount: snapshot.data?.works?.length ?? 0,
                  itemBuilder: (context, index) {
                    Work work = snapshot.data!.works![index];
                    return WorkCard(work: work);
                  },
                );
              },
            ),],
        )
      ),
    );
  }
}
