import 'package:flutter/material.dart';
import 'chatMessage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<ChatMessage> messages = [];

Future<String> getChatbotReply(String userReply) async {
  var response = await http
      .get(Uri.parse(
          "http://api.brainshop.ai/get?bid=167106&key=iABJFJf8sP50MTTg&uid=TimePass&msg=$userReply"))
      .then((value) => value.body)
      .catchError((onError) => onError);
  var data = jsonDecode(response);
  messages
      .add(ChatMessage(messageContent: data["cnt"], messageType: "receiver"));
  return data["cnt"];
}

class ChatScreenPage extends StatefulWidget {
  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  void ScrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> fetchdata(userReply) async {
    final response = await http.get(
        Uri.parse(
            "http://api.brainshop.ai/get?bid=167180&key=3K7RpulBiiTIv3V7&uid=Vipul%20Bajaj&msg=${userReply}"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    final data = json.decode(response.body);

    setState(() {
      messages.add(
          ChatMessage(messageContent: data["cnt"], messageType: "receiver"));
    });

    ScrollToEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade400,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white60,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  child: Icon(
                    Icons.face,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "yana",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              // physics: BouncingScrollPhysics(),
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: messages.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: (messages[index].messageType == "receiver"
                            ? EdgeInsets.only(right: 60.0)
                            : EdgeInsets.only(left: 60.0)),
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey.shade300
                                  : Colors.pink.shade500),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      (messages[index].messageType == "receiver"
                                          ? Colors.black87
                                          : Colors.white)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      ScrollToEnd();
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Write anything...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                    controller: _controller,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_controller.text.length > 0) {
                      setState(() {
                        messages.add(ChatMessage(
                            messageContent: _controller.text,
                            messageType: "sender"));
                        ScrollToEnd();
                      });
                      fetchdata(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                  backgroundColor: Colors.pink,
                  elevation: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
