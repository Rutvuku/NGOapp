import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class UserHome extends StatefulWidget {
  final String mytoken;
  const UserHome({Key? key,required this.mytoken}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    Map<String,dynamic> x = JwtDecoder.decode(widget.mytoken);
    super.initState();
    email= x['email'].toString();
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.mytoken),
          ],
        ),
      )
    );
  }
}
