import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePosts extends StatefulWidget {
  final String myToken;
  final String userid;
  const CreatePosts({Key? key,required this.myToken,required this.userid}) : super(key: key);

  @override
  State<CreatePosts> createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController vacancyController = TextEditingController();

  String firstName = "";
  String lastName = "";
  String bodyTemp = "";


  var measure;

  void _submit()async {
    var reqBody={
      "title": titleController.text,
      "date": dateController.text,
      "time": timeController.text,
      "location": locationController.text,
      "tagline": taglineController.text,
      "vacancy": vacancyController.text,
      "creator":widget.userid,
    };
    var response = await http.post(Uri.parse("https://ecogather.onrender.com/api/event/"),
        headers: {"Content-Type":"application/json",},
        body: jsonEncode(reqBody)
    );
    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);
    print(widget.myToken);

    showDialog<void>(
      context: context,
      barrierDismissible: true, // user can tap anywhere to close the pop up
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your information has been submitted'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("title",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(titleController.text),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("location:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(locationController.text),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Date:",
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(dateController.text),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('Go to profile'),
                  onPressed: () async {
                    FocusScope.of(context)
                        .unfocus(); // unfocus last selected input field
                    Navigator.pop(context);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyProfilePage())) // Open my profile
                        .then((_) => _formKey.currentState
                        ?.reset()); // Empty the form fields
                    setState(() {});
                  }, // so the alert dialog is closed when navigating back to main page
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    FocusScope.of(context)
                        .unfocus(); // Unfocus the last selected input field
                    _formKey.currentState?.reset(); // Empty the form fields
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Human IT care"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle, size: 32.0),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfilePage(),
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Enter your data",
                    style: TextStyle(
                      fontSize: 24,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'title',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: titleController,
                      onFieldSubmitted: (value) {
                        setState(() {
                          firstName = value.capitalize();
                          // firstNameList.add(firstName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          firstName = value.capitalize();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'First Name must contain at least 3 characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'date',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'Last Name must contain at least 3 characters';
                        }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          lastName = value.capitalize();
                          // lastNameList.add(lastName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          lastName = value.capitalize();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'location',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: locationController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ) {
                          return 'Use only numbers!';
                        }
                      },
                      onFieldSubmitted: (value) {
                        setState(() {
                          bodyTemp = value;
                          // bodyTempList.add(bodyTemp);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          bodyTemp = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'tagline',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: taglineController,
                      onFieldSubmitted: (value) {
                        setState(() {
                          firstName = value.capitalize();
                          // firstNameList.add(firstName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          firstName = value.capitalize();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'First Name must contain at least 3 characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'vacancy',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: vacancyController,
                      onFieldSubmitted: (value) {
                        setState(() {
                          firstName = value.capitalize();
                          // firstNameList.add(firstName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          firstName = value.capitalize();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'First Name must contain at least 3 characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'time',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: timeController,
                      onFieldSubmitted: (value) {
                        setState(() {
                          firstName = value.capitalize();
                          // firstNameList.add(firstName);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          firstName = value.capitalize();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'First Name must contain at least 3 characters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // DropdownButtonFormField(
                    //     decoration: const InputDecoration(
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //           BorderRadius.all(Radius.circular(20.0)),
                    //           borderSide:
                    //           BorderSide(color: Colors.grey, width: 0.0),
                    //         ),
                    //         border: OutlineInputBorder()),
                    //     items: [
                    //       const DropdownMenuItem(
                    //         child: Text("ºC"),
                    //         value: 1,
                    //       ),
                    //       const DropdownMenuItem(
                    //         child: Text("ºF"),
                    //         value: 2,
                    //       )
                    //     ],
                    //     hint: const Text("Select item"),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         measure = value;
                    //         // measureList.add(measure);
                    //       });
                    //     },
                    //     onSaved: (value) {
                    //       setState(() {
                    //         measure = value;
                    //       });
                    //     }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60)),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          _submit();
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            const Text("New data",
                style: TextStyle(
                  fontSize: 24,
                )),
            const Spacer(),
            ElevatedButton(
              child: const Text('New'),
              onPressed: () => Navigator.pop(context),
            )
          ]),
        ]),
      ),
    );
  }
}

extension StringExtension on String {
  // Method used for capitalizing the input from the form
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
