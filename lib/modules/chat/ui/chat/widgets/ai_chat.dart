import 'package:flutter/material.dart';
import 'package:astrolex/app/services.dart';
import 'package:astrolex/features/home/models/message.dart';
import 'package:astrolex/modules/chat/ui/chat/widgets/message_bubble.dart';

class AiChat extends StatefulWidget {
  const AiChat({Key? key, required this.loading}) : super(key: key);

  final bool loading;

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: chatService.messages,
        builder: (context, messages, child) {
          return AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: widget.loading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      messages.isEmpty
                          ? const Center(child: Text('No messages'))
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      Message message = messages[index];

                                      return Column(
                                        key: ValueKey(message.id),
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          MessageBubble(message: message),
                                          if (index == 0)
                                            const SizedBox(height: 80),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'Ask a question',
                              fillColor:
                                  Theme.of(context).colorScheme.background,
                              filled: true,
                              suffixIcon: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () async {
                                    await chatService
                                        .submitMessage(messageController.text);
                                    messageController.clear();
                                  },
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}
