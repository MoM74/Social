// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 200,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Image(
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/fire-Social.appspot.com/o/user%2Fimage_picker6842197940318941066.jpg?alt=media&token=5cc87736-1967-4c5e-bc9a-9bc4bec6fbbb'),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              color: Colors.grey[100],
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email address:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "mo7amedmb777@gmail.com",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          //color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Phone number:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "01028612804",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          //color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              color: Colors.grey[100],
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Social App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Using Firebase,authentication,firestore",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Shop App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Using Sqflite,APIs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "News App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Using APIs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "ToDo App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
