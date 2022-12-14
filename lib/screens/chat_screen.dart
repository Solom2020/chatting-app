import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User signedInUser;
final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextEditinControler = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? text;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messageStreams() async {
    await for (var snapShot in _fireStore.collection('messages').snapshots()) {
      for (var message in snapShot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/chat.png', height: 25),
            const SizedBox(width: 10),
            const Text(
              "Text Me",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                List<MessageView> messageWidgets = [];
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orangeAccent,
                    ),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                for (var message in messages) {
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final currentUser = signedInUser.email;

                  final messageWidget = MessageView(
                      sender: messageSender,
                      text: messageText,
                      isMe: currentUser == messageSender);
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    children: messageWidgets,
                  ),
                );
              },
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextEditinControler,
                      cursorColor: Colors.orange,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here.....',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextEditinControler.clear();
                      _fireStore.collection('messages').add({
                        'text': text,
                        'sender': signedInUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageView extends StatelessWidget {
  const MessageView(
      {Key? key, required this.text, required this.sender, required this.isMe})
      : super(key: key);
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(color: Colors.orange, fontSize: 12),
          ),
          Material(
              borderRadius: BorderRadius.circular(30),
              color: isMe ? Colors.blue : Colors.orange,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(color:isMe? Colors.white:Colors.black, fontSize: 15),
                ),
              )),
        ],
      ),
    );
  }
}
