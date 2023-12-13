import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class YourWidget extends StatefulWidget {
  const YourWidget({super.key});

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  List<dynamic> responseText = [77.05, 8];
  bool isLoading = false;
  late VideoPlayerController _controller;
  late final LocalAuthentication auth;
  late CameraController _cameraController;
  late Future<List<CameraDescription>> cameras = availableCameras();
  final player = AudioPlayer();
  String manual = "";
  // final Map<String, dynamic> data = {};
  final sugg = [
    "FASHION",
    "ANALYZE",
    "RATING",
    "BEAUTIFUL",
    "WONDERFUL",
    "FANTASTIC",
    "WOW",
    "SO ELEGANT",
  ];
  // late File image;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/1.mp4')
      ..setLooping(true) // Set the video to loop continuously
      ..initialize().then((_) {
        setState(() {
          _controller.play(); // Automatically play the video
        });
      });
    // initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    print(cameras);
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  Future<Uint8List> getBytesFromAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<String> getBase64EncodedImage(String path) async {
    final Uint8List imageBytes = await getBytesFromAsset(path);
    return base64Encode(imageBytes);
  }

  Future<void> sendRequest() async {
    print("Sending Request");
    setState(() {
      isLoading = true;
    });

    // final image = (await _cameraController.takePicture());

    const String apiUrl = "http://192.168.43.110:8000";
    // final String base64EncodedImage =
    // await getBase64EncodedImage(imageLocation);
    // final imageBytes = await image.readAsBytes();

    // Encode the image bytes to base64
    // final base64EncodedImage = base64Encode(imageBytes);
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          responseText = data;
        });
        print(data);
      } else {
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}");
        throw Exception(
            "Error during request. Status Code: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      print("Socket Exception: $e");
      throw Exception("Network error. Please check your connection.");
    } on http.ClientException catch (e) {
      print("HTTP Client Exception: $e");
      throw Exception("HTTP client error. Make sure the server is running.");
    } catch (e, stackTrace) {
      print("Error: $e");
      print("Stack Trace: $stackTrace");
      throw Exception("Unknown error occurred.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        VideoPlayer(_controller),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60.0,
                width: 300.0,
                margin: const EdgeInsets.only(
                    top: 70, bottom: 15, left: 40, right: 40),
                decoration: BoxDecoration(
                  color: AppColors.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                      20.0), // Creates equal rounded corners
                  border: Border.all(
                    color: AppColors.PrimaryColor4,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text(
                    "FASHION ON !",
                    style: GoogleFonts.dhurjati(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PrimaryColor4),
                  ).shimmer(
                    primaryColor: AppColors.PrimaryColor4,
                    secondaryColor: AppColors.PrimaryColor3,
                  ),
                ),
              ),
              Container(
                width: 300,
                color: AppColors.PrimaryColor4,
                margin: EdgeInsets.all(10),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.asset(
                          "assets/6.jpeg",
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "YOUR'S FASHION MY ANALYSIS !",
                          style: GoogleFonts.dhurjati(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.PrimaryColor4),
                        ).shimmer(
                          primaryColor: AppColors.PrimaryColor4,
                          secondaryColor: AppColors.PrimaryColor3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: VxSwiper.builder(
                    itemCount: sugg.length,
                    height: 50.0,
                    viewportFraction: 0.4,
                    autoPlay: true,
                    autoPlayAnimationDuration: 3.seconds,
                    autoPlayCurve: Curves.linear,
                    enableInfiniteScroll: true,
                    itemBuilder: (context, index) {
                      final s = sugg[index];
                      return Chip(
                        label: s.text
                            .textStyle(
                              GoogleFonts.dhurjati(
                                fontSize: 20.0,
                                color: AppColors.PrimaryColor4,
                              ),
                            )
                            .bold
                            .make(),
                        backgroundColor: Vx.randomColor,
                      );
                    }),
              ),
              Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.PrimaryColor4,
                      backgroundColor: AppColors.PrimaryColor,
                      side: const BorderSide(
                        color: AppColors.PrimaryColor4, // Set the border color
                        width: 1.0, // Set the border width
                      ),
                    ),
                    onPressed: sendRequest,
                    child: Text(
                      "Get Score",
                      style: GoogleFonts.dhurjati(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.PrimaryColor4),
                    )),
              ),
              Container(
                height: 60.0,
                width: 340.0,
                margin: const EdgeInsets.only(
                    top: 20, bottom: 25, left: 50, right: 50),
                decoration: BoxDecoration(
                  color: AppColors.PrimaryColor5,
                  borderRadius: BorderRadius.circular(
                      20.0), // Creates equal rounded corners
                  border: Border.all(
                    color: AppColors.PrimaryColor4,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Fashion Score: " + responseText[0].toString() + "%",
                    style: GoogleFonts.dhurjati(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ).shimmer(
                    primaryColor: Colors.redAccent,
                    secondaryColor: AppColors.PrimaryColor,
                  ),
                ),
              ),
              Container(
                height: 60.0,
                width: 340.0,
                margin: const EdgeInsets.only(
                    top: 0, bottom: 35, left: 50, right: 50),
                decoration: BoxDecoration(
                  color: AppColors.PrimaryColor5,
                  borderRadius: BorderRadius.circular(
                      20.0), // Creates equal rounded corners
                  border: Border.all(
                    color: AppColors.PrimaryColor4,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Fabric Score: " + responseText[1].toString() + "/10",
                    style: GoogleFonts.dhurjati(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ).shimmer(
                    primaryColor: Colors.redAccent,
                    secondaryColor: AppColors.PrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
