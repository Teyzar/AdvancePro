import 'package:flutter/material.dart';
import 'package:loginpage/models/user.dart';
import 'package:loginpage/views/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ConfirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool passwordObscured = true;
  bool inputFieldEnabled = true;

  final user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white54,
          centerTitle: true,
          title: const Text("Register", style: TextStyle(color: Colors.black)),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 760) {
            return Container(
              child: Center(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 200),
                    Center(child: Image.asset('assets/advancePro.png')),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            hintText: "Enter Name"),
                        controller: nameController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter E-mail"),
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          labelText: "Password",
                          hintText: "Enter Password",
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Confirm Password';
                          } else if (value != passwordController.text) {
                            return 'Password not match';
                          }
                        },
                        controller: ConfirmPassController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          labelText: "Confirm Password",
                          hintText: "Confirm Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                        enabled: inputFieldEnabled,
                        obscureText: passwordObscured,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      width: 500,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: ElevatedButton(
                        child: const Text("Register"),
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 95, 95, 236)),
                        onPressed: inputFieldEnabled
                            ? () async {
                                final name = nameController.text;
                                final email = emailController.text;
                                final password = passwordController.text;
                                final confirmPassword =
                                    ConfirmPassController.text;
                                if (_formKey.currentState!.validate() &&
                                    password == confirmPassword) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  setState(() {
                                    inputFieldEnabled = false;
                                  });

                                  final statusCode = await user.register(
                                      name, email, password);

                                  if (statusCode == 200) {
                                    Navigator.popUntil(context,
                                        (route) => Navigator.canPop(context));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const Login()));
                                  } else {
                                    setState(() {
                                      inputFieldEnabled = true;
                                    });
                                  }
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              )),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(15, 120, 15, 0),
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter Name"),
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter E-mail"),
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Password",
                    hintText: "Enter Password",
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
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Confirm Password';
                    } else if (value != passwordController.text) {
                      return 'Password not match';
                    }
                  },
                  controller: ConfirmPassController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                  enabled: inputFieldEnabled,
                  obscureText: passwordObscured,
                ),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ElevatedButton(
                    child: const Text("Register"),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 95, 95, 236)),
                    onPressed: inputFieldEnabled
                        ? () async {
                            final name = nameController.text;
                            final email = emailController.text;
                            final password = passwordController.text;
                            final confirmPassword = ConfirmPassController.text;
                            if (_formKey.currentState!.validate() &&
                                password == confirmPassword) {
                              FocusScope.of(context).requestFocus(FocusNode());

                              setState(() {
                                inputFieldEnabled = false;
                              });

                              final statusCode =
                                  await user.register(name, email, password);

                              if (statusCode == 200) {
                                Navigator.popUntil(context,
                                    (route) => Navigator.canPop(context));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Login()));
                              } else {
                                setState(() {
                                  inputFieldEnabled = true;
                                });
                              }
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
