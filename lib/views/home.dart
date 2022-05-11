import 'package:flutter/material.dart';
import 'package:loginpage/models/user.dart';

class Home extends StatefulWidget {
  final User user;
  const Home(this.user, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        centerTitle: true,
        title: const Text("Home", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: [
              const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
                radius: 100,
                backgroundColor: Colors.blueGrey,
              ),
              SizedBox(height: 20),
              Text("Email"),
              Center(
                  child: const ListTile(
                title: Text("awe"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
//  Text(
//                 "Welcome! " + widget.user.name.toString(),
//                 style: const TextStyle(fontSize: 20),
//               )