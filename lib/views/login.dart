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
          "Login Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 760) {
          return webview();
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(15, 120, 15, 0),
            children: [
              Center(child: Image.asset('assets/advancePro.png')),
              const SizedBox(height: 30),
              Expanded(
                child: TextFormField(
                  maxLines: null,
                  expands: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email_outlined)),
                ),
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
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 95, 95, 236)),
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
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextButton.icon(
                    icon: const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    label: const Text(
                      "Sign up",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Register(),
                      ));
                    },
                  )),
            ],
          ),
        );
      }),
    );
  }

  Widget webview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 250, 0, 0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // margin: const EdgeInsets.fromLTRB(100, 90, 50, 50),
                child: ListView(
                  children: [
                    Expanded(
                        child:
                            Center(child: Image.asset('assets/Team-work.png'))),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 15),
                    Expanded(
                        child: Center(
                            child: Image.asset('assets/advancePro.png'))),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(child: Image.asset('assets/advancePro.png')),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your Email';
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your Password';
                          }
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
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
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 50,
                      width: 500,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ElevatedButton(
                        child: const Text("Login"),
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 95, 95, 236)),
                        onPressed: inputFieldEnabled
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

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
                    SizedBox(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: TextButton.icon(
                          icon: const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          label: const Text(
                            "Sign up",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Register(),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
