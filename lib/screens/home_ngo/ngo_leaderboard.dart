import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/PostModel.dart';
import '../../model/leaderboardModel.dart';
import '../../utils/constants.dart';
class NGOLeaderboard extends StatefulWidget {
  const NGOLeaderboard({Key? key}) : super(key: key);

  @override
  State<NGOLeaderboard> createState() => _NGOLeaderboardState();
}

class _NGOLeaderboardState extends State<NGOLeaderboard> {
  Future<List<User>> leaderboard()async{
    List<User> prevPosts =[];
    var response = await http.get(Uri.parse("https://ecogather.onrender.com/api/event/leaderboard"),

    );
    var jsonResponse = jsonDecode(response.body);
    jsonResponse['users'].forEach(
            (value)=>{
          prevPosts.add(User(id: 'id', email: 'email', password: 'password', events: 'events', favourites: 'favourites', createdAt: 'createdAt', updatedAt: 'updatedAt', noOfCertificate: 'noOfCertificate', v: '__v'))

        }
    );
    print(jsonResponse);
    print("test 1");
    return prevPosts;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leaderboard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppConstants.screenHeight(context)*0.37,
          width: AppConstants.screenWidth(context)*0.8,
          child: FutureBuilder(
            future: leaderboard(),
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
                      return ListTile(
                        leading: Text("${index+1}"),
                        title: Text(pdata[index].id),
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
