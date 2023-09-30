import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/work/work.dart';

class WorkCard extends StatelessWidget {
  const WorkCard({Key? key, required this.work}) : super(key: key);

  final Work work;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 2,
      child: ListTile(
        title: Text(work.title ?? "No title available."),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (work.authorships != null && work.authorships!.isNotEmpty) Text('Authors: ${work.authorships!.map((a) => a.author?.displayName ?? '').join(', ')}'),
            Text('Citations: ${work.citedByCount ?? 0}'),
            Text('Publication Year: ${work.publicationYear ?? 'Unknown'}'),
            if ((work.isOA != null && work.isOA!) || (work.bestOALocation != null )) Text('Open Access: ${work.bestOALocation?.landingPageUrl ?? 'Unknown'}', style: const TextStyle(color: Colors.green)),
            Text('License: ${work.license ?? 'Unknown'}'),
            if (work.apcList != null) Text('APC List Price: ${work.apcList!.valueUsd} USD (${work.apcList!.currency})'),
            if (work.apcPaid != null) Text('APC Paid: ${work.apcPaid!.valueUsd} USD (${work.apcPaid!.currency})'),
          ],
        ),
        onTap: (){
          searchService.addWork(work);
          work.authorships?.forEach((element) {
            searchService.addAuthor(element.author?.displayName ?? '', work.citedByCount ?? 0);
          });
          router.push(WorkDetailsRoute(workId: work.id!));
        },
      ),
    );
  }
}
