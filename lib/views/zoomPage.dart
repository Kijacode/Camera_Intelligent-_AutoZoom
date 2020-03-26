import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'package:iapp/utils/network.dart';
import 'package:iapp/views/camera.dart';

class ZoomPage extends StatefulWidget {
//initialize imagepath
  String imagePath;

  ZoomPage({
    Key key,
    this.imagePath,
  }) : super(key: key);

  @override
  _ZoomPageState createState() => _ZoomPageState(imagePath: imagePath);
}

class _ZoomPageState extends State<ZoomPage> {
  //initialize scale factor for image zoom manipulation using matrix manipulation by change each pixel accordingly
  double _scale = 1.0;
  double _previousScale = 1.0;
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;
  String imagePath;
  _ZoomPageState({this.imagePath});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void navigationPage(BuildContext context) async {
    final cameras = await availableCameras();

    final firstCamera = cameras.first;

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Camera(
                  camera: firstCamera,
                )));
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text("Zoom Page"),
      ),
      body: Stack(children: [
        FutureBuilder(
          future: _initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2 + 50,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            //scalemanipulation starts

            onScaleStart: (ScaleStartDetails details) {
              _previousScale = _scale;
              setState(() {});
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              _scale = _previousScale * details.scale;
              setState(() {});
            },
            onScaleEnd: (ScaleEndDetails details) {
              _previousScale = 1.0;
              setState(() {});
            },
            child: RotatedBox(
              quarterTurns: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                  child: Card(
                      elevation: 7,
                      child: imagePath != null
                          ? Image.file(File(imagePath))
                          //check connection status and decide which image to view local or network image
                          : (Utils().connection() != null
                              ? CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                  imageUrl:
                                      "https://images.unsplash.com/photo-1578253809350-d493c964357f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                                )
                              : Image.asset(
                                  "assets/dog.jpg",
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                ))),
                ),
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red[400],
          child: Icon(Icons.photo_camera),
          onPressed: () {
            navigationPage(context);
          }),
    );
  }
}
