import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/features/search/models/research.dart';
import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PastResearchView extends StatelessWidget {
  const PastResearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Past Research")),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading past research"));
          }

          List<Research> research = snapshot.data!.docs.map((e) => Research.fromJson(e.data())).toList();

          if(research.isEmpty){
            return const Center(child: Text("No past research"));
          }

          return ListView.builder(
            itemCount: research.length,
            itemBuilder: (context, index) {
              Research researchItem = research[index];
              return ListTile(
                title: Text(researchItem.searchTerm),
                subtitle: Text(researchItem.id),
                onTap: () {
                  searchService.setResearchId(researchItem.id);
                  router.push(AiLibrarianRoute());
                },
              );
            },
          );
        },
      ),
    );
  }
}
