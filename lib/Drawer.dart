import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/colors.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:url_launcher/url_launcher.dart';
import "package:velocity_x/velocity_x.dart";

class MyDraw extends StatefulWidget {
  const MyDraw({super.key});

  @override
  State<MyDraw> createState() => _MyDrawState();
}

class _MyDrawState extends State<MyDraw> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hariomshukla337@gmail.com', // replace with your email
      queryParameters: {
        'subject': 'Hello! I am from your Mood Spotifier App !',
        'body': 'Please! Type your message here',
      },
    );

    final String uri = emailLaunchUri.toString();

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 250,
              color: Colors.redAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/profile.jpeg"),
                            maxRadius: 35,
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/1.jpeg"),
                            maxRadius: 35,
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/9.jpeg"),
                            maxRadius: 35,
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/8.jpeg"),
                            maxRadius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: Text(
                            " HariOm (Leader)",
                            style: GoogleFonts.dhurjati(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textScaleFactor: 1.2,
                          ).shimmer(
                            primaryColor: AppColors.PrimaryColor4,
                            secondaryColor: AppColors.PrimaryColor3,
                          ),

                          width: 80,
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: Text(
                            "Govind",
                            style: GoogleFonts.dhurjati(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textScaleFactor: 1.2,
                          ).shimmer(
                            primaryColor: AppColors.PrimaryColor4,
                            secondaryColor: AppColors.PrimaryColor3,
                          ),

                          width: 70,
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: Text(
                            "Sarthak",
                            style: GoogleFonts.dhurjati(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textScaleFactor: 1.2,
                          ).shimmer(
                            primaryColor: AppColors.PrimaryColor4,
                            secondaryColor: AppColors.PrimaryColor3,
                          ),

                          width: 70,
                        ),
                        Container(
                          // margin: EdgeInsets.all(10),
                          child: Text(
                            "Pratham",
                            style: GoogleFonts.dhurjati(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textScaleFactor: 1.2,
                          ).shimmer(
                            primaryColor: AppColors.PrimaryColor4,
                            secondaryColor: AppColors.PrimaryColor3,
                          ),

                          width: 75,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    // color: AppColors.PrimaryColor,
                    height: 60,

                    decoration: BoxDecoration(
                      color: AppColors.PrimaryColor,
                      // borderRadius: BorderRadius.circular(
                      // 20.0), // Creates equal rounded corners
                      border: Border.all(
                          color: AppColors.PrimaryColor4,
                          style: BorderStyle.solid),
                    ),
                    child: Center(
                      child: Text(
                        " Team Leader's Details",
                        style: GoogleFonts.dhurjati(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textScaleFactor: 1.2,
                      ).shimmer(
                        primaryColor: AppColors.PrimaryColor4,
                        secondaryColor: AppColors.PrimaryColor3,
                      ),
                    ),
                  )
                ],
              ),
              // padding: EdgeInsets.zero,
              // child: UserAccountsDrawerHeader(
              //   margin: EdgeInsets.zero,
              //   decoration: BoxDecoration(
              //     color: Colors.red,
              //   ),
              //   accountName: Text(
              //     "Hari Om Shukla",
              //     style: GoogleFonts.dhurjati(
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white),
              //   ),
              //   accountEmail: Text(
              //     "hariomshukla337@gmail.com",
              //     style: GoogleFonts.dhurjati(
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white),
              //   ),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundImage: AssetImage("assets/profile.jpeg"),
              //   ),
              // ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textScaleFactor: 1.2,
              ),
            ),
            ListTile(
              onTap: () {
                final Uri _url = Uri.parse(
                    'https://www.linkedin.com/in/hariom-shukla-32ab3a24a/');
                launchUrl(_url);
              },
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Leader's  Profile",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                _sendEmail();
              },
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              title: Text(
                "Email to Leader",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                final Uri _url = Uri.parse(
                    'https://drive.google.com/file/d/1OYQi98YDuOeS6zD68ov_rkCuikcuzmJd/view?usp=sharing');
                launchUrl(_url);
              },
              leading: Icon(
                CupertinoIcons.bag_fill_badge_plus,
                color: Colors.white,
              ),
              title: Text(
                "Leader's Resume",
                textScaleFactor: 1.2,
                style: GoogleFonts.dhurjati(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
