import 'dart:convert';

import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../model/PostModel.dart';
import '../../utils/constants.dart';


class UserHome extends StatefulWidget {
  final String mytoken;
  final String userID;
  const UserHome({Key? key,required this.mytoken,required this.userID}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late String email;
  Future<List<PostModel>> getAll()async{
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
  @override
  void initState() {
    // TODO: implement initState
    Map<String,dynamic> x = JwtDecoder.decode(widget.mytoken);
    super.initState();
    email= x['email'].toString();
    print(email);
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppConstants.screenHeight(context)*0.37,
          width: AppConstants.screenWidth(context)*0.8,
          child: FutureBuilder(
            future: getAll(),
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
                            CustomButton(
                              width: 200,
                              backgroundColor: Colors.green,
                              isThreeD: true,
                              height: 35,
                              borderRadius: 25,
                              animate: true,
                              margin: const EdgeInsets.all(10),
                              onPressed: ()async {
                                var reqBody = {
                                  "userId": widget.userID,
                                  "eventId":  pdata[index].id,
                                };

                                var res = await http.post(Uri.parse("https://ecogather.onrender.com/api/users/eventRegister"),
                                  headers: {"Content-Type":"application/json",},
                                  body: jsonEncode(reqBody),
                                );


                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
