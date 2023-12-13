// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Drawer.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:flutter_application_1/get_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    debugShowCheckedModeBanner: false, // Set initial route to Login
    routes: {
      '/login': (context) => const Login(),
      '/drawer': (context) => const MyDraw(),
      '/get_data': (context) => const YourWidget(),
    },
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final LocalAuthentication auth;
  bool _passwordVisible = true;
  bool _supportState = false;
  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fashion Analyser",
              style: GoogleFonts.habibi(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: AppColors.PrimaryColor,
          foregroundColor: AppColors.PrimaryColor4,
        ),
        body: Scaffold(
          backgroundColor: AppColors.PrimaryColor5,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100.0,
                  width: 300.0,
                  margin: const EdgeInsets.only(top: 40.0, bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.PrimaryColor,
                    borderRadius: BorderRadius.circular(
                        20.0), // Creates equal rounded corners
                    border: Border.all(
                        color: AppColors.PrimaryColor4,
                        style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Text(
                      "Login Please !",
                      style: GoogleFonts.dhurjati(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.PrimaryColor4),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 60.0,
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.PrimaryColor,
                    border: Border.all(
                        color: AppColors.PrimaryColor4,
                        style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Form(
                      key: _nameFormKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          hintStyle: GoogleFonts.dhurjati(
                            fontSize: 23.0,
                            color: AppColors.PrimaryColor4,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          }
                        },
                        style: GoogleFonts.dhurjati(
                          // Replace 'yourSelectedFont' with the desired Google Font
                          fontSize: 23.0, // Customize the font size
                          color: Colors.black, // Customize the text color
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  margin: const EdgeInsets.all(20.0),
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.PrimaryColor,
                    border: Border.all(
                        color: AppColors.PrimaryColor4,
                        style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Form(
                      key: _passwordFormKey,
                      child: TextFormField(
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintStyle: GoogleFonts.dhurjati(
                            fontSize: 23.0,
                            color: AppColors.PrimaryColor4,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 20.0, top: 15.0, bottom: 0),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password must be of 6 characters";
                          }
                          return null;
                        },
                        style: GoogleFonts.dhurjati(
                          // Replace 'yourSelectedFont' with the desired Google Font
                          fontSize: 23.0, // Customize the font size
                          color: Colors.black, // Customize the text color
                        ), // Style for the entered text
                        cursorColor: Colors.black, // Cursor color
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.PrimaryColor,
                    border: Border.all(
                        color: AppColors.PrimaryColor4,
                        style: BorderStyle.solid),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameFormKey.currentState!.validate() &&
                          _passwordFormKey.currentState!.validate()) {
                        // setState(() {
                        print("Harry");
                        Navigator.pushNamed(context, '/get_data');
                        // });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.PrimaryColor4,
                      backgroundColor:
                          AppColors.PrimaryColor1, // Set text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // Set padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Set rounded corners
                      ),
                    ),
                    child: Text(
                      "SUBMIT",
                      style: GoogleFonts.dhurjati(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.PrimaryColor,
                    border: Border.all(
                        color: AppColors.PrimaryColor4,
                        style: BorderStyle.solid),
                  ),
                  child: ElevatedButton(
                    onPressed: authenticate,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.PrimaryColor4,
                      backgroundColor:
                          AppColors.PrimaryColor1, // Set text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // Set padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Set rounded corners
                      ),
                    ),
                    child: Text(
                      "Authenticate via Phone",
                      style: GoogleFonts.dhurjati(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 80, left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20.0), // Creates equal rounded corners
                    border: Border.all(
                      color: AppColors.PrimaryColor4,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/drawer');
                    },
                    child: Row(
                      children: [
                        CupertinoButton(
                          child: Icon(
                            CupertinoIcons.briefcase_fill,
                            size: 50.0,
                            color: Colors.black,
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/drawer'),
                        ),
                        Text(
                          "Developer's Profile !",
                          style: GoogleFonts.dhurjati(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.PrimaryColor4),
                        ).shimmer(
                          primaryColor: AppColors.PrimaryColor4,
                          secondaryColor: AppColors.PrimaryColor3,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _getAvailiableBiometrics() async {
    List<BiometricType> availiableBiometrics =
        await auth.getAvailableBiometrics();
    print("List of availiableBiometrics : $availiableBiometrics");
  }

  Future<void> authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Please Authnticate To Get Started",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));
      if (authenticated) {
        Navigator.pushNamed(context, '/get_data');
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}

/// Stateful widget to fetch and then display video content.
// class VideoApp extends StatefulWidget {
//   const VideoApp({super.key});
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;
//   late final LocalAuthentication auth;
//   final bool _supportState = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/1.mp4')
//       ..setLooping(true) // Set the video to loop continuously
//       ..initialize().then((_) {
//         setState(() {
//           _controller.play(); // Automatically play the video
//         });
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Video Demo',
//         debugShowCheckedModeBanner: false,
//         home: Stack(
//           children: [
//             VideoPlayer(_controller),
//             Container(
//               height: 80.0,
//               width: 300.0,
//               margin: const EdgeInsets.only(
//                   left: 50.0, top: 70, bottom: 50.0, right: 50.0),
//               decoration: BoxDecoration(
//                 color: AppColors.PrimaryColor,
//                 borderRadius: BorderRadius.circular(
//                     20.0), // Creates equal rounded corners
//                 border: Border.all(
//                     color: AppColors.PrimaryColor4, style: BorderStyle.solid),
//               ),
//               child: Center(
//                 child: Text(
//                   "Mood Spotifier !",
//                   style: GoogleFonts.dhurjati(
//                       fontSize: 40.0,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.PrimaryColor4),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     title: 'Video Demo',
//   //     home: Scaffold(
//   //       body: Center(
//   //         child: _controller.value.isInitialized
//   //             ? AspectRatio(
//   //                 aspectRatio: _controller.value.aspectRatio,
//   //                 child: VideoPlayer(_controller),
//   //               )
//   //             : Container(),
//   //       ),
//   //       floatingActionButton: FloatingActionButton(
//   //         onPressed: () {
//   //           setState(() {
//   //             _controller.value.isPlaying
//   //                 ? _controller.pause()
//   //                 : _controller.play();
//   //           });
//   //         },
//   //         child: Icon(
//   //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

  