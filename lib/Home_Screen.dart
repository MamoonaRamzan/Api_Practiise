import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostModel.dart';
// ignore: camel_case_types
class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}
class _Home_screenState extends State<Home_screen> {
  List<PostModel> postList=[];
Future<List<PostModel>> getPostApi ()async{
  final respone=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  var data=jsonDecode(respone.body.toString());
  if(respone.statusCode==200) {
    postList.clear();
    for (Map i in data) {
      postList.add(PostModel.fromJson(i));
    }
    return postList;
  }
  else{
   return postList;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Practise"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
                builder: (context,snapshpot) {
                  if (!snapshpot.hasData) {
                    return Center(child: Text("Loading......"));
                  }
                  else {
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(postList[index].title.toString()),
                              SizedBox(height: 5,),
                              Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(postList[index].body.toString()),
                            ],
                          ),
                        ),
                      );
                    });
                  }
                }
                ),
          ),
        ],
      ),
    );
  }
}
