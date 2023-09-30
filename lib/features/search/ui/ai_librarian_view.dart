import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:astrolex/app/theme.dart';
import 'package:astrolex/features/search/models/assistant_message.dart';
import 'package:astrolex/features/search/ui/widgets/chat_bubble.dart';

import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class AiLibrarianView extends StatefulWidget {
  AiLibrarianView({Key? key}) : super(key: key);

  @override
  _AiLibrarianViewState createState() => _AiLibrarianViewState();
}

class _AiLibrarianViewState extends State<AiLibrarianView> {
  Future<AssistantMessage> getLlmAdvice() async {
    String actionResponse = await searchService.getQuestion();

    // find first bullet point and use that as the new search term
    String searchTerm = await searchService.getSearchTerm(actionResponse);

    return AssistantMessage(
      summary: actionResponse,
      searchTerms: [searchTerm],
      type: 'question',
    );
  }

  @override
  void initState() {
    super.initState();
    if (searchService.searchTerm.value != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(authenticationService.id)
          .collection('research')
          .doc(searchService.researchId.value)
          .collection('messages')
          .add(
              AssistantMessage(date: DateTime.now(), summary: 'Initializing research assistant. \n\nGoal: ${searchService.researchGoal}\n\nSearch: ${searchService.searchTerm.value!}', type: 'system')
                  .toJson())
          .whenComplete(() {
        searchService.searchTermAction(searchService.searchTerm.value!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AI Librarian"),
            Text(searchService.researchId.value!, style: context.bodySmall),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: .7,
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        ListTile(
                          title: Text('How to use the AI Librarian', style: context.headlineSmall),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(color: context.primaryContainer, borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              const Text("OpenAlex Content"),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.secondaryContainer.withRed(70),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        IconButton.outlined(
                                          tooltip: 'Summarize Abstract and Find Related Works',
                                          onPressed: () {},
                                          icon: const Icon(Icons.add),
                                        ),
                                        gap4,
                                        const Expanded(child: Text('Summarize Work Abstract')),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gap16,
                        DecoratedBox(
                            decoration: BoxDecoration(
                              color: context.background.withBlue(150),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Text("Follow-up Questions"),
                                Text(
                                  'Tap to generate AI response to Question',
                                  style: context.bodySmall,
                                )
                              ],
                            )),
                        gap16,
                        DecoratedBox(
                            decoration: BoxDecoration(
                              color: context.background.withGreen(50),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Text('Search Term'),
                                Text(
                                  'Tap to search OpenAlex works for this term',
                                  style: context.bodySmall,
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(authenticationService.id)
              .collection('research')
              .doc(searchService.researchId.value)
              .collection('messages')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            }

            List<AssistantMessage> chatMessages = snapshot.data!.docs.map((e) => AssistantMessage.fromJson(e.data())).toList();

            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              controller: ScrollController(),
              reverse: true,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                AssistantMessage message = AssistantMessage.fromJson(snapshot.data!.docs[index].data());

                String id = snapshot.data!.docs[index].id;
                return Column(
                  children: [
                    ChatBubble(key: ValueKey(id), message: message),
                    ValueListenableBuilder(
                      valueListenable: searchService.loading,
                      builder: (context, value, child) {
                        if (value && index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 16, width: 16, child: CircularProgressIndicator()),
                                gap16,
                                ValueListenableBuilder(
                                    valueListenable: searchService.systemMessage,
                                    builder: (context, message, child) {
                                      return Text(message ?? 'Loading...', style: context.bodySmall);
                                    }),
                              ],
                            ).animate(effects: [const FadeEffect()]),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  ],
                );
              },
            );
          }),
    );
  }
}

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool shouldRetain;

  const PositionRetainedScrollPhysics({super.parent, this.shouldRetain = true});

  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
      shouldRetain: shouldRetain,
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;

    if (oldPosition.pixels > oldPosition.minScrollExtent && diff > 0 && shouldRetain) {
      return position + diff;
    } else {
      return position;
    }
  }
}

class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
