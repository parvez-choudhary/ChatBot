import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ChatBot());
}

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  String answer='';
  String input='tell me about yourself';
  String errorMessage='';
  String searchApiurl='http://api.brainshop.ai/get?bid=165937&key=RIRIJxQD88DiUyO7&uid=[uid]&msg=';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      fetchdata(input);
  }
  void fetchdata( String input) async{
    try {
      var searchResults = await http.get(Uri.parse(searchApiurl + input));
      var result = json.decode(searchResults.body);
      setState(() {
        answer= result["cnt"];
        errorMessage='';
      });
    }
    catch(error){
      setState(() {
        errorMessage="sorry!!we don't have this location data";
      });
    }
  }

   void onTextFieldSumbitted(String input) async {

    fetchdata(input);

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      home: Container(
        decoration:  const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/clear.png'),
              fit: BoxFit.cover,

          ),
        ),

        //Center( child: CircularProgressIndicator()):
             child: Scaffold(
               backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Chat Bot'),

            ),
               body: SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Center(
                       child: Container(
                         width: 300,
                         height: 100,
                         //alignment: MainAxisAlignment.spaceBetween,

                         //color: Colors.orange,
                         child:  Center(
                           child: TextField(
                             onSubmitted: (input)  {
                               onTextFieldSumbitted(input);
                             },
                             style: TextStyle(color: Colors.yellowAccent,fontSize: 25),
                             decoration: InputDecoration(
                               hintText: 'Ask me anything',
                               hintStyle: TextStyle(color: Colors.yellowAccent,fontSize: 20),
                               prefixIcon: Icon(Icons.message,color: Colors.white,),
                             ),


                           ),
                         ),
                       ),
                     ),
                     Center(
                       child: Container(
                         width: 300,

                         child: Text(answer,style: TextStyle(color: Colors.black,fontSize: 20),),
                       ),
                     ),
                   ],
                 ),
               ),
    )
    )
    );
  }
}
