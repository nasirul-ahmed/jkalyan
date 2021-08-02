import 'dart:io';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http_parser/http_parser.dart';

class UploadDocs2 extends StatefulWidget {
  const UploadDocs2({Key? key, this.accountNumber}) : super(key: key);
  final int? accountNumber;
  @override
  _UploadDocs2State createState() => _UploadDocs2State();
}

class _UploadDocs2State extends State<UploadDocs2> {
  File? _image;

  bool isProfileUploaded = false;

  getImage(ImageSource src) async {
    var picker = ImagePicker();
    var img = await picker.getImage(source: src);
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: img!.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Signature',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Signature"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => getImage(ImageSource.gallery),
          child: Icon(Icons.upload),
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                height: 50,
                width: screen.width * 0.8,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Customer Siganture Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _image == null
                ? Center(
                    child: Text(
                    'Select an image to upload',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ))
                : Card(
                    child: Image.file(_image!),
                    //color: Colors.amber,
                  ),
            SizedBox(
              height: 20,
            ),
            _image != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: screen.width * 0.5,
                        color: Colors.green,
                        child: InkWell(
                          onTap: () => uploadPhoto(context),
                          child: Center(
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }

  uploadPhoto(BuildContext context) async {
    Dio dio = Dio();
    String uri = '$janaklyan/api/collector/uploads-signature';
    String filename = _image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(_image!.path,
          filename: filename, contentType: MediaType("image", "png")),
      "accountNumber": widget.accountNumber,
    });

    try {
      var res = await dio.post(uri,
          data: formData,
          options: Options(sendTimeout: 60000, method: "POST", headers: {
            "Accept": "*/*",
            "Content-Type": "multipart/form-data",
          }));

      if (200 == res.statusCode) {
        print(res.data);
        Fluttertoast.showToast(
          msg: "Files Uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
