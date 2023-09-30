import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/features/home/ui/home/widgets/drawer.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();

  bool assisted = true;

  int index = 0;

  void setIndex(int val) {
    setState(() => index = val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // App Logo and Name
              const Spacer(flex: 2),
              ClipOval(child: Image.asset('assets/images/logo.png', height: 100)), // Assuming you have an image named 'astrolex_logo.png' in the 'assets' folder
              const Text(
                "AstroLex",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              // Search Field
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Enter a research topic or keyword...",
                  hintStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white60),
                ),
                onSubmitted: (value) async {
                  if (!assisted) {
                    router.push(SearchRoute(query: value));
                  } else {
                    searchService.clearAll();
                    searchService.setSearchTerm(value);

                    DocumentReference researchRef = FirebaseFirestore.instance.collection('users').doc(authenticationService.id).collection('research').doc();

                    await researchRef.set({
                      'id': researchRef.id,
                      'goal': searchService.researchGoal,
                      'searchTerm': searchService.searchTerm.value,
                      'date': DateTime.now(),
                    });

                    searchService.setResearchId(researchRef.id);
                    router.push(AiLibrarianRoute());
                  }
                },
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    assisted ? 'Assisted' : 'Manual',
                    style: context.bodySmall,
                  ),
                  Switch(
                    value: assisted,
                    onChanged: (value) {
                      setState(() {
                        assisted = value;
                      });
                    },
                  )
                ],
              ),

              const Spacer(flex: 1),
              // Brief Tagline
              const Text(
                "Discover the universe of research.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              gap8,
              Flexible(
                child: TextButton(
                  child: const Text('Past Research'),
                  onPressed: () {
                    router.push(const PastResearchRoute());
                  },
                ),
              ),
              const Spacer(flex: 3),
              // Optional: Add any additional buttons or links here
            ],
          ),
        ),
      ),
    );
  }
}
