import 'dart:io';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadProfile extends StatefulWidget {
  UploadProfile(this.accountNumber);
  final int accountNumber;
  @override
  _UploadProfileState createState() => _UploadProfileState();
}

class _UploadProfileState extends State<UploadProfile> {
  bool isLoading = false;
  Dio dio = new Dio();
  File? _profile;
  File? _signature;

  final picker = ImagePicker();

  _openGallery(BuildContext context) async {
    final _selectedProfile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (_selectedProfile != null) {
        _profile = File(_selectedProfile.path);
      } else {
        print('No image selected');
      }
    });
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    final _selectedProfile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (_selectedProfile != null) {
        _profile = File(_selectedProfile.path);
      } else {
        print('No image selected');
      }
    });
    Navigator.pop(context);
  }

  _openGallery2(BuildContext context) async {
    final _selectedSig = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_selectedSig == null) {
        print('No image selected');
      } else {
        _signature = File(_selectedSig.path);
      }
    });
    Navigator.pop(context);
  }

  _openCamera2(BuildContext context) async {
    final _selectedSig = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (_selectedSig != null) {
        _signature = File(_selectedSig.path);
      } else {
        print('No image selected');
      }
    });
    Navigator.pop(context);
  }

  Future<void> selectOptions(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Options'),
            elevation: 16,
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    onTap: () => _openCamera(context),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Camera')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => _openGallery(context),
                    child: Row(
                      children: [
                        Icon(Icons.photo),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Gallery')
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> selectOptions2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Options'),
            elevation: 16,
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    onTap: () => _openCamera2(context),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Camera')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => _openGallery2(context),
                    child: Row(
                      children: [
                        Icon(Icons.photo),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Gallery')
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  uploadPhoto(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    print(widget.accountNumber);
    try {
      String filenameOne = _profile!.path.split('/').last;
      String filenameTwo = _signature!.path.split('/').last;

      FormData formData = new FormData.fromMap({
        'profile': await MultipartFile.fromFile(
          _profile!.path,
          filename: filenameOne,
          contentType: new MediaType('image', 'png'),
        ),
        "type": "image/png",
        'signature': await MultipartFile.fromFile(
          _signature!.path,
          filename: filenameTwo,
          contentType: new MediaType('image', 'png'),
        ),
        'accountNumber': widget.accountNumber
      });
      //FormData formData = await getFormData();

      Response res =
          await dio.post('https://sanchay-new.herokuapp.com/profile-upload',
              data: formData,
              options: Options(contentType: "multipart/form-data", headers: {
                "accept": "*/*",
                "Authorization": "Bearer accesstoken",
                "Content-Type": "multipart/form-data"
              }));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DashBoard()),
          (route) => false);
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Documents Uploaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
      ),
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text('Uploading...'),
              ],
            ))
          : Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profile == null
                      ? GestureDetector(
                          onTap: () => selectOptions(context),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width - 20,
                            child: Card(
                              elevation: 16,
                              child: Center(
                                child: Text('Select photo'),
                              ),
                            ),
                          ),
                        )
                      : Image.file(
                          _profile!,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width - 20,
                        ),
                  _signature == null
                      ? GestureDetector(
                          onTap: () => selectOptions2(context),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width - 20,
                            child: Card(
                              elevation: 16,
                              child: Center(
                                child: Text('Select signature'),
                              ),
                            ),
                          ),
                        )
                      : Image.file(
                          _signature!,
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width - 20,
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.pink[600]),
                    onPressed: () => uploadPhoto(context),
                    child: Text('Upload Documents'),
                  )
                ],
              )),
            ),
    );
  }
}
