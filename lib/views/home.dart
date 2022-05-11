import 'package:flutter/material.dart';
import 'package:loginpage/models/user.dart';
import 'package:loginpage/views/login.dart';

class Home extends StatefulWidget {
  final User user;
  const Home(this.user, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        centerTitle: true,
        title: const Text("Welcome!", style: TextStyle(color: Colors.black)),
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
                radius: 80,
                backgroundColor: Colors.blueGrey,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(widget.user.name.toString(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
              const Text("Name",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 77, 72, 72))),
              const SizedBox(height: 10),
              Card(
                color: Colors.lightBlue[50],
                elevation: 4,
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.user.name.toString(),
                      style: const TextStyle(fontSize: 15),
                    )),
              ),
              const SizedBox(height: 15),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 77, 72, 72),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.lightBlue[50],
                elevation: 4,
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.user.email.toString(),
                      style: const TextStyle(fontSize: 15),
                    )),
              ),
              const SizedBox(height: 15),
              const Text(
                "Token",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 77, 72, 72),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.lightBlue[50],
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.user.token.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextButton.icon(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                label:
                    const Text("Sign out", style: TextStyle(color: Colors.red)),
                onPressed: () async {
                  final statusCode =
                      await _user.logout(widget.user.token.toString());

                  if (statusCode == 200) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const Login()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
