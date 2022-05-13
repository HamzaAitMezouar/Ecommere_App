// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:ecom/pages/Home.dart';
import 'package:ecom/services/Auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final key = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String password = '';
  String ImageUrl = '';
  bool obs = true;
  bool Signin = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  PlatformFile? myImage;
  UploadTask? uploadTask;
  bool loading = false;
  //////// to upload image
  Future getImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return;
    }
    setState(() {
      myImage = result.files.first;
      print(myImage!.path!);
    });
  }

  Future uploadImage() async {
    final path = 'file/${name}/${myImage!.name}';
    final image = File(myImage!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(image);

    final snapshot = await uploadTask!.whenComplete(() {});
    final imagefirebaseUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      ImageUrl = imagefirebaseUrl;
    });
    print(ImageUrl);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadImage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Signin ? const Text('Sign In') : const Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Signin
                        ? Container(
                            height: 150,
                            child: Lottie.network(
                                'https://assets2.lottiefiles.com/packages/lf20_kz2ylhyq.json'),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: myImage == null
                                    ? Image.asset(
                                        'assets/noprofile.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(myImage!.path!),
                                        fit: BoxFit.cover,
                                      ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 150,
                                width: 150,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: const Icon(Icons.add_a_photo)),
                              ),
                            ],
                          )),
              ),
              Form(
                key: key,
                child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Signin
                        ? Column(children: [
                            EmailTextField(),
                            const SizedBox(
                              height: 10,
                            ),
                            PasswordTextField(),
                            const SizedBox(
                              height: 10,
                            ),
                            if (loading) ...[
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                            if (!loading) ...[
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                    });

                                    if (key.currentState!.validate() &&
                                        key.currentState != null) {
                                      Auth().Signin(email, password);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => home()));
                                    }
                                  },
                                  child: const Text('Sign In'))
                            ],
                          ])
                        : Column(
                            children: [
                              NameTextField(),
                              const SizedBox(
                                height: 10,
                              ),
                              EmailTextField(),
                              const SizedBox(
                                height: 10,
                              ),
                              PasswordTextField(),
                              const SizedBox(
                                height: 10,
                              ),
                              if (loading) ...[
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                              if (!loading) ...[
                                ElevatedButton(
                                  child: const Text('Register'),
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                    });
                                    uploadImage().whenComplete(() {
                                      if (key.currentState!.validate() &&
                                          key.currentState != null) {
                                        Auth().register(
                                            email, password, name, ImageUrl);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => home()));
                                      }
                                    });
                                  },
                                  /**/
                                )
                              ]
                            ],
                          )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      Signin = !Signin;
                      emailcontroller.clear();
                      namecontroller.clear();
                      passwordcontroller.clear();
                    });
                  },
                  child: Signin
                      ? const Text('Create an Account')
                      : const Text('Already Have An Acount !'))
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget EmailTextField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: emailcontroller,
        obscureText: false,
        key: const ValueKey('email'),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          label: const Text('Email'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelStyle: GoogleFonts.adamina(),
        ),
        validator: (val) {
          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);
          if (val!.isEmpty || !regex.hasMatch(val)) {
            return 'Enter a valid email address';
          } else {
            return null;
          }
        },
        onChanged: (val) => setState(() {
          email = val;
        }),
      ),
    );
  }

  Widget NameTextField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: namecontroller,
        obscureText: false,
        key: const ValueKey('name'),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          prefixIcon: Image.asset('assets/name.png'),
          label: const Text('Name'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelStyle: GoogleFonts.adamina(),
        ),
        validator: (val) => val!.isEmpty ? 'Enter your name' : null,
        onChanged: (val) => setState(() {
          name = val;
        }),
      ),
    );
  }

  Widget PasswordTextField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: passwordcontroller,
        obscureText: obs,
        key: const ValueKey('password'),
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          suffixIconColor: Theme.of(context).hintColor,
          suffix: IconButton(
              onPressed: () {
                setState(() {
                  obs = !obs;
                });
              },
              icon: obs
                  ? Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).hintColor,
                    )
                  : const Icon(Icons.visibility)),
          prefixIcon: const Icon(Icons.lock),
          label: const Text('password'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelStyle: GoogleFonts.adamina(),
        ),
        validator: (val) => val!.isEmpty || val.length < 6
            ? 'Your password is too short'
            : null,
        onChanged: (val) => setState(() {
          password = val;
        }),
      ),
    );
  }
}
