import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LibrarianButton extends StatelessWidget {
  const LibrarianButton({Key? key, required this.searchTerm}) : super(key: key);

  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () async {

      searchService.clearAll();
      searchService.setSearchTerm(searchTerm);

      DocumentReference researchRef = FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc();

      await researchRef.set({
        'id': researchRef.id,
        'goal': searchService.researchGoal,
        'searchTerm': searchTerm,
        'date': DateTime.now(),
      });

      searchService.setResearchId(researchRef.id);
      router.push(AiLibrarianRoute());
    },
    child: const Icon(Icons.local_library_rounded),);
  }
}
