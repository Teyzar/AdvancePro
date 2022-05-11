import 'package:flutter/material.dart';
import 'package:loginpage/models/user.dart';
import 'package:loginpage/views/home.dart';
import 'package:loginpage/views/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final user = User();

  bool passwordObscured = true;
  bool inputFieldEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white54,
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 120, 15, 0),
          children: [
            Center(child: Image.asset('assets/advancePro.png')),
            const SizedBox(height: 30),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Email';
                }
              },
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Password';
                }
              },
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                labelText: "Password",
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordObscured
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordObscured = !passwordObscured;
                    });
                  },
                ),
              ),
              enabled: inputFieldEnabled,
              obscureText: passwordObscured,
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: ElevatedButton(
                child: const Text("Login"),
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                onPressed: inputFieldEnabled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          setState(() {
                            inputFieldEnabled = false;
                          });

                          Future((() async {
                            final email = emailController.text;
                            final password = passwordController.text;

                            final statusCode =
                                await user.login(email, password);
                            if (statusCode == 200) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => Home(user),
                              ));
                            } else {
                              setState(() {
                                inputFieldEnabled = true;
                              });
                            }
                          }));
                        }
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 35),
            TextButton.icon(
              icon: const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.black),
              ),
              label: const Text(
                "Register Here",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Register(),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
