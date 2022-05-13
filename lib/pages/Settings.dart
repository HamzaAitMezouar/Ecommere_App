// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ecom/pages/Authpage.dart';
import 'package:ecom/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../models/userModel.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static const keyDarkMode = 'key-dark-mode';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: FirebaseAuth.instance.currentUser == null
            ? Center(
                child: InkWell(
                  onTap: () {
                    Auth().SignOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthPage()));
                  },
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 201, 23),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.login_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Sign In ',
                          style: GoogleFonts.lora(
                              color: const Color.fromARGB(251, 255, 255, 255),
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : FutureBuilder(
                future: Auth().getuser(FirebaseAuth.instance.currentUser!.uid),
                builder: (BuildContext context, AsyncSnapshot<UserM> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 252, 74, 61)),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 252, 74, 61)));
                  } else if (snapshot.hasData) {
                    UserM user = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          height: 150,
                          child: Center(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(user.profile!))),
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 10,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add_a_photo)),
                                )
                              ],
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: 250,
                            height: 80,
                            child: Column(
                              children: [
                                InkWell(
                                  child: Text(
                                    user.name!,
                                    style: GoogleFonts.lora(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(user.email!,
                                    style: GoogleFonts.lora(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.7))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 300,
                            child: ListView(children: [
                              settingcard('Acount',
                                  'Privacy,Security,Delete Acount ', Icons.key),
                              settingcard(
                                  'Notifications',
                                  'Updates , New Products Alert',
                                  Icons.notifications),
                              settingcard(
                                  'Purchase',
                                  'Purchase History ,Purchase Methods ',
                                  Icons.attach_money),
                              settingcard(
                                  'Help',
                                  'Help Center ,Contact ,Privacy Policy',
                                  Icons.help_rounded),
                              settingcard('invite Friend', '', Icons.add)
                            ])),
                        InkWell(
                          onTap: () {
                            Auth().SignOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                          },
                          child: Container(
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(40)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.logout_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  'LogOut',
                                  style: GoogleFonts.lora(
                                      color: const Color.fromARGB(
                                          251, 255, 255, 255),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Shimmer.fromColors(
                        child: Container(
                          height: 150,
                          child: Center(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 172, 172, 172),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        baseColor: const Color.fromARGB(255, 172, 172, 172),
                        highlightColor:
                            const Color.fromARGB(255, 212, 212, 212));
                  }
                },
              ));
  }

  Widget settingcard(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title, style: GoogleFonts.lora()),
      subtitle: Text(subtitle),
      leading: Icon(icon),
    );
  }
}
