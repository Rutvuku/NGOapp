import 'dart:convert';
import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ngo_app/model/PostModel.dart';
import 'package:ngo_app/screens/home_ngo/create_post.dart';
import 'package:ngo_app/utils/constants.dart';

class NGOHome extends StatefulWidget {
  final String myToken;
  final String userID;
  const NGOHome({Key? key,required this.myToken,required this.userID}) : super(key: key);

  @override
  State<NGOHome> createState() => _NGOHomeState();
}

class _NGOHomeState extends State<NGOHome> {
  Future<List<PostModel>> getPrev()async{
    List<PostModel> prevPosts =[];
    var reqBody = {
      "userId": widget.userID,
    };
    var response = await http.post(Uri.parse("https://ecogather.onrender.com/api/event/getprevposts"),
        headers: {"Content-Type":"application/json",},
        body: jsonEncode(reqBody)
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    // final List<Map<String, dynamic>> jsonData = json.decode(jsonResponse);
    print(jsonResponse);
    jsonResponse['currentPosts'].forEach(
            (value)=>{
          prevPosts.add(PostModel(id: value['_id'], title: value['title'], date: value['date'], time: value['time'], creator: value['creator'], location: value['location'], tagline: value['tagline']))

        }
    );
    // final List<PostModel> postModels = jsonData.map((e) => PostModel.fromJson(e)).toList();
    print("successful");
    return prevPosts;
  }
   Future<List<PostModel>> getCurrent()async{
    List<PostModel> currentPosts =[];
    var reqBody = {
      "userId": widget.userID,
    };
    var response = await http.post(Uri.parse("https://ecogather.onrender.com/api/event/getcurrentpost"),
        headers: {"Content-Type":"application/json",},
        body: jsonEncode(reqBody)
    );
    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);
    // final List<Map<String, dynamic>> jsonData = json.decode(jsonResponse);
    print(jsonResponse);
    jsonResponse['currentPosts'].forEach(
        (value)=>{
          currentPosts.add(PostModel(id: value['_id'], title: value['title'], date: value['date'], time: value['time'], creator: value['creator'], location: value['location'], tagline: value['tagline']))

        }
    );
    // final List<PostModel> postModels = jsonData.map((e) => PostModel.fromJson(e)).toList();
    print("successful");
    return currentPosts;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCurrent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePosts(myToken: widget.myToken, userid: widget.userID)));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(child: Text('Current events'),),
          SingleChildScrollView(
            child: Container(
              height: AppConstants.screenHeight(context)*0.37,
              width: AppConstants.screenWidth(context)*0.8,
              child: FutureBuilder(
                future: getCurrent(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                    List<PostModel> pdata = snapshot.data;
                    return ListView.builder(
                      itemCount: pdata.length,
                        itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: Column(
                          children: [
                            Text(pdata[index].title),
                            Text(pdata[index].location),
                            Text(pdata[index].date),
                            Text(pdata[index].time),

                          ],
                        ),
                      );
                    });
                  }
                },
              ),
            ),
          ),
          Center(child: Text('prev posts'),),
          SingleChildScrollView(

          )
        ],
      ),
    );
  }
}
