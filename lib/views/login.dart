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
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 960) {
          return webview();
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(15, 120, 15, 0),
            children: [
              Center(child: Image.asset('assets/advancePro.png')),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(146, 251, 242, 217),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your E-mail';
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "E-mail",
                    prefixIcon: const Icon(Icons.email),
                  ),
                  enabled: inputFieldEnabled,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(146, 251, 242, 217),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Password';
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
              const SizedBox(height: 50),
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
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue),
                  )),
              TextButton.icon(
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
            ],
          ),
        );
      }),
    );
  }

  Widget webview() {
    return Container(
      padding: const EdgeInsets.all(70),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(146, 240, 182, 24),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(150, 20, 10, 200),
                        child: Image.asset('assets/Team-work.png')),
                    Expanded(
                      flex: 1,
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
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  labelText: "E-mail",
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                                enabled: inputFieldEnabled,
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
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
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
                                    primary:
                                        const Color.fromARGB(255, 95, 95, 236)),
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
                                            final password =
                                                passwordController.text;

                                            final statusCode = await user.login(
                                                email, password);
                                            if (statusCode == 200) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    Home(user),
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
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blue),
                                )),
                            TextButton.icon(
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
                          ],
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
