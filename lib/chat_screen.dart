/// ChatScreen shows a chat interface and handles sending messages to and
/// receiving messages from a chatbot. It initializes a chat session with
/// the Generative AI model, sends user messages to the model to generate
/// responses, and displays the chat history.

import 'package:piet_bot/chat_message.dart';
import 'package:piet_bot/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isListening = false;
  late ChatSession chat;

  /// Initializes a Generative AI model with the specified model name and API key.
  ///
  /// The `GenerativeModel` class is used to interact with a Generative AI model,
  /// such as the 'gemini-pro' model. The model is initialized with the API key
  /// stored in the environment variable `API_KEY`.
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: dotenv.env['API_KEY']!,
  );

  //Function to start the chatbot
  void startBot() async {
    _messages.insert(
      0,
      const ChatMessage(
        isUser: false,
        text: content,
        sender: 'Piot',
      ),
    );
    // Start the chat session
    chat = model.startChat(
      history: [
        // Prompt to initialize the chatbot
        Content.text(prompt),
        // Content of the first message of the chat and one-shot prompt
        Content.model([TextPart(content)])
      ],
    );
    setState(() {});
  }

  /// Initializes the ChatScreen state and starts the chatbot when the widget is created.
  /// The `initState()` method is called when the ChatScreen widget is first created. 
  /// It calls the `startBot()` method to initialize the chatbot and start the chat session.
  @override
  void initState() {
    super.initState();
    startBot();
  }

  // Function to send the message from the text field
  void _sendMessage() async {
    final text = _controller.text;
    _controller.clear();
    _messages.insert(
      0,
      ChatMessage(isUser: true, text: text, sender: "You"),
    );

    setState(() {
      _isListening = !_isListening;
    });
    // Send the message to the chatbot
    final response = await chat.sendMessage(Content.text(text));
    // Get the answer from the chatbot
    final answer = response.text!;
    // Add the answer to the list of messages
    _messages.insert(
      0,
      ChatMessage(
        isUser: false,
        text: answer,
        sender: 'Piot',
      ),
    );
    setState(() {
      _isListening = !_isListening;
    });
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.only(
        //right: 8.0,
        top: 12,
        //left: 10,
        bottom: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "What's up?",
                labelStyle: const TextStyle(color: black),
                floatingLabelStyle: const TextStyle(
                  color: black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: black,
                    width: 5,
                  ),
                ),
                focusColor: black,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: black,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          /// Sends the user's message when the send button is pressed.
          ///
          /// The `_isListening` flag is checked to determine if the button should be enabled.
          /// The `_sendMessage` function is called when the button is pressed, which adds a new
          /// `ChatMessage` to the `_messages` list and updates the `_isListening` flag.
          /// The button is styled with a random color to match the chat theme.
          IconButton(
            onPressed: _isListening ? null : _sendMessage,
            color: getRandomColor(true),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 10,
          left: 10,
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Displays a list of chat messages in a ListView, with the most recent message at the bottom.
              ///
              /// The ListView is built using `ListView.builder`, which allows for efficient rendering of a large
              /// number of messages. The `reverse` property is set to `true` to display the messages in reverse
              /// order, with the most recent message at the bottom.
              ///
              /// If the `_isListening` flag is `true`, a `CircularProgressIndicator` is displayed at the bottom
              /// of the ListView, indicating that the user is currently recording a message.
              ///
              /// The `_messages` list contains the individual `ChatMessage` widgets that are displayed in the
              /// ListView.
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              if (_isListening)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 8,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      color: getRandomColor(true),
                    ),
                  ),
                ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                ),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
