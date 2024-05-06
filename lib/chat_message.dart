/// Represents a chat message in the application.
///
/// The [ChatMessage] widget displays a chat message with the sender's name and the message text.
/// The message is displayed differently depending on whether the message is sent by the user or another participant.
///
/// The [text] parameter represents the message text.
/// The [sender] parameter represents the name of the sender.
/// The [isUser] parameter indicates whether the message was sent by the user or Piot.

import 'package:piet_bot/constants.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.text,
    required this.sender,
    required this.isUser,
  });

  final String text;
  final String sender;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    Color color = getRandomColor(false);
    List<Widget> message = [
      Expanded(
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: isUser
                  ? const EdgeInsets.only(left: 16)
                  : const EdgeInsets.only(right: 16),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: black,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: RichText(
                    text: TextSpan(
                      text: text,
                      style: TextStyle(
                        color: color != black
                            ? black
                            : color != white
                                ? white
                                : black,
                        fontFamily: 'Gabarito',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ];
    if (isUser) message = message.reversed.toList();
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: message,
    );
  }
}
