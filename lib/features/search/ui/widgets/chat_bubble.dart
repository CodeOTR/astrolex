import 'package:astrolex/app/constants.dart';
import 'package:astrolex/app/router.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/app/text_theme.dart';
import 'package:astrolex/app/theme.dart';
import 'package:astrolex/features/search/models/assistant_message.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatBubble extends StatelessWidget {
  final AssistantMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: message.type == 'system'
            ? context.tertiaryContainer
            : message.type == 'ai'
                ? context.secondaryContainer.withAlpha(200)
                : context.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (message.type ?? '').toUpperCase(),
            style: context.bodySmall,
          ),
          SelectableText(message.summary ?? '',
              // Additional styling if required
              style: context.bodyLarge, onTap: () {
            // Handle tap if necessary
          }, contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar(
              anchors: editableTextState.contextMenuAnchors,
              // Build the default buttons, but make them look custom.
              // Note that in a real project you may want to build
              // different buttons depending on the platform.
              children: [
                    TextSelectionToolbarTextButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      onPressed: () {
                        searchService.searchTermAction(editableTextState.textEditingValue.selection.textInside(editableTextState.textEditingValue.text));
                        debugPrint(editableTextState.textEditingValue.selection.textInside(editableTextState.textEditingValue.text));
                      },
                      child: const Text('Search'),
                    ),
                    TextSelectionToolbarTextButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: editableTextState.textEditingValue.text));
                      },
                      child: const Text('Copy'),
                    ),
                  ],

            );
          }),
          gap16,
          if (message.works != null && message.works!.isNotEmpty)
            Column(
                children: [
                  ...message.works!.map((work) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: context.secondaryContainer.withRed(70),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
gap8,
                          Expanded(
                              child: Text(
                            work.title ?? '',
                            style: context.bodySmall,
                          )),
                          if(message.type == 'openalex')IconButton.outlined(
                            tooltip: 'Summarize and Find Related Works',
                            onPressed: () async {
                              await searchService.summarizeAction(work);
                              await searchService.relatedWorkAction(work);
                            }, icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      router.push(WorkDetailsRoute(workId: work.id!));
                    },
                  ),
                ),
              );
            }).toList()]),
          if (message.questions != null && message.questions!.isNotEmpty)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              gap8,
              Text(
                'Questions',
                style: context.bodySmall,
              ),
              ...message.questions!.mapIndexed((index, e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: context.background.withBlue(150),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              e ?? '',
                              style: context.bodySmall,
                            )),
                          ],
                        ),
                      ),
                      onTap: () async {
                        await searchService.questionAction(e);
                      },
                    ),
                  ).animate(effects: [
                    ScaleEffect(
                      delay: Duration(milliseconds: 100 * index),
                    )
                  ]),
                );
              }).toList()
            ]),
          if (message.searchTerms != null && message.searchTerms!.isNotEmpty)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              gap8,
              Text(
                'Search Terms',
                style: context.bodySmall,
              ),
              Wrap(
                spacing: 8,
                children: message.searchTerms!.mapIndexed((index, e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: context.background.withGreen(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            e,
                            style: context.bodySmall,
                          ),
                        ),
                        onLongPress: () async {
                          await searchService.relatedConceptsAction(e);
                        },
                        onTap: () async {
                          await searchService.searchTermAction(e);
                        },
                      ),
                    ).animate(effects: [
                      ScaleEffect(
                        delay: Duration(milliseconds: 100 * index),
                      )
                    ]),
                  );
                }).toList(),
              )

            ]),
          if (message.concepts != null && message.concepts!.isNotEmpty)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              gap8,
              Row(
                children: [
                  Text(
                    'Concepts',
                    style: context.bodySmall,
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                children: message.concepts!.mapIndexed((index, e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: context.background.withRed(80),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            e.displayName ?? '',
                            style: context.bodySmall,
                          ),
                        ),

                        onTap: () async {
                          await searchService.searchTermAction(e.displayName ?? '');
                        },
                      ),
                    ).animate(effects: [
                      ScaleEffect(
                        delay: Duration(milliseconds: 100 * index),
                      )
                    ]),
                  );
                }).toList(),
              )

            ]),
        ],
      ),
    );
  }
}
