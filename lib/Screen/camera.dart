import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:dip_taskplanner/Screen/gallery.dart';
import 'package:dip_taskplanner/Screen/cropping.dart';

//Entry point into Camera
class CameraPageEntry extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraPageEntry> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imgPath;



  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Display camera preview
  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    return AspectRatio(
      aspectRatio: cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            FloatingActionButton(
              heroTag: "Capture",
              child: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                print("shutter!");
                onCapture(context);
              },
            ),

          ],
        ),
      ),
    );
  }
  Widget GalleryWidget(context) {
    return Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "Gallery",
                child: Icon(
                  Icons.collections,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPageEntry()),);
                },
              )
              ],
          ),
        ),
    );
  }
  Widget cameraToggle() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: () {
              onSwitchCamera();
            },
            icon: Icon(
              getCameraLensIcons(lensDirection),
              color: Colors.white,
              size: 24,
            ),
            shape: RoundedRectangleBorder(),
            label: Text(
              '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }

  onCapture(context) async {
    try {
      print("get temporary diretory");
      final p = await getExternalStorageDirectory();
      print(p);
      final name = DateTime.now();
      //final name = "TestTest";
      final path = "${p.path}/$name.png";
      //final path = "${p.path}/TestTest.png";
      print("full file path:");
      print(path);

      await cameraController.takePicture(path).then((value) {
        print('Saving Photo to');
        print(path);
        //Navigator.push(context, MaterialPageRoute(builder: (context) =>PreviewScreen(imgPath: path,fileName: "$name.png",)));
        Navigator.push(context, MaterialPageRoute(builder: (context) =>PreviewScreen(imgPath: path,fileName: "TestTest.png",)));
      });

    } catch (e) {
      showCameraException(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if(cameras.length > 0){
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {

        });
      } else {
        print('No camera available');
      }
    }).catchError((e){
      print('Error : ${e.code}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: cameraPreview(),
            ),
            Align(
              //flex: 1,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 32.0, left: 5.0),
                child: BackButton(),
                ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    cameraToggle(),
                    cameraControl(context),
                    //Spacer(),
                    GalleryWidget(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex =
    selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  }

  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
  }
}

class PreviewScreen extends StatefulWidget {
  final String imgPath;
  final String fileName;
  PreviewScreen({this.imgPath, this.fileName});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.file(File(widget.imgPath),fit: BoxFit.cover,),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black,
                  child: Row(
                    children: <Widget>[
                      //Share Photo
                      Expanded(
                        child: FloatingActionButton(
                          heroTag: "Share",
                          child: Icon(Icons.share,color: Colors.black,),
                          backgroundColor: Colors.white,
                          onPressed: (){
                            getBytes().then((bytes) {
                              print("Share button pressed");
                              print(widget.imgPath);
                              print(bytes.buffer.asUint8List());
                              Share.file('Share via', widget.fileName, bytes.buffer.asUint8List(), 'image/path');
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: FloatingActionButton(
                        heroTag: "Crop",
                        child: Icon(Icons.crop,color: Colors.black,),
                        backgroundColor: Colors.white,
                        onPressed: (){

                          },
                        ),
                      ),



                      //Go to gallery
                      Expanded(
                        child: FloatingActionButton(
                          heroTag: "Gallery",
                          child: Icon(
                            Icons.collections,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            //pops stack, remove photo preview from stack
                            //not that pressing back from next route goes back to camera
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPageEntry()),);
                          },
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Future getBytes () async {
    Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
//    print(ByteData.view(buffer))
    return ByteData.view(bytes.buffer);
  }
}