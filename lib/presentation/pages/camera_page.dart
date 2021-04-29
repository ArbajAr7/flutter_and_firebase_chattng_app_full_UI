import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:t_amo/presentation/widgets/theme/Style.dart';

import 'package:custom_image_picker/custom_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String filePath = '';
  List<CameraDescription> cameras;
  CameraController _cameraController;
  List<dynamic> _galleryPhotos;

  @override
  void initState() {
    initializeCamera();

    super.initState();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }
  getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check = prefs.containsKey('image');
    if (check) {
      setState(() {
        filePath = prefs.getString('image');
      });
      return;
    }
    ImagePicker imagePicker = new ImagePicker();
    PickedFile image = await imagePicker.getImage(source: ImageSource.gallery);
    String imagePath = image.path;
    await prefs.setString('image', imagePath);
    setState(() {
      filePath = prefs.getString('image');
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return Container(height: 0.0, width: 0.0,);

    }
    return Scaffold(
      body: Stack(
        children: <Widget>[


          Container(
            height: 480,
            width: 360,
            child: CameraPreview(_cameraController),
          ),
          _cameraButtonWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.folder),
      ),
    );
  }
  Widget _cameraButtonWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.flash_on,color: Colors.white,size: 30,),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Colors.white,width: 2)
              ),
            ),
            Icon(Icons.camera_alt,size: 30,color: Colors.white,)

          ],
        ),
      ),
    );
  }
}