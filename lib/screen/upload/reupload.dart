import 'dart:convert';
import 'dart:io';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReUploadProfile extends StatefulWidget {
  static const String id = 'ReUploadProfile';
  @override
  _ReUploadProfileState createState() => _ReUploadProfileState();
}

class _ReUploadProfileState extends State<ReUploadProfile> {
  final _key = GlobalKey<FormState>();
  TextEditingController _accountNumber = TextEditingController();

  bool isLoading = false;

  File? _profile;
  File? _signature;

  String? _profileData;
  String? _signatureData;

  final picker = ImagePicker();

  _openGallery(BuildContext context) async {
    final _selectedProfile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    if (_selectedProfile != null) {
      setState(() {
        _profile = File(_selectedProfile.path);
      });
    }
    _profileData = base64Encode(_profile!.readAsBytesSync());
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    final _selectedProfile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 25);

    if (_selectedProfile != null) {
      setState(() {
        _profile = File(_selectedProfile.path);
      });
    }
    _profileData = base64Encode(_profile!.readAsBytesSync());
    Navigator.pop(context);
  }

  _openGallery2(BuildContext context) async {
    final _selectedSig =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    if (_selectedSig != null) {
      setState(() {
        _signature = File(_selectedSig.path);
      });
    }
    _signatureData = base64Encode(_signature!.readAsBytesSync());
    Navigator.pop(context);
  }

  _openCamera2(BuildContext context) async {
    final _selectedSig =
        await picker.getImage(source: ImageSource.camera, imageQuality: 25);
    if (_selectedSig != null) {
      setState(() {
        _signature = File(_selectedSig.path);
      });
    }
    _signatureData = base64Encode(_signature!.readAsBytesSync());
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
    //if (!_key.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    var data = jsonEncode(<String, dynamic>{
      "profile": _profileData,
      "signature": _signatureData,
      "accountNumber": int.parse(_accountNumber.text),
      "id": _prefs.getInt('collectorId')
    });

    String uri = 'https://sanchay-new.herokuapp.com/profile-upload';

    try {
      var res = await http.post(Uri.parse(uri), body: data, headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}"
        //"Authorization": "Bearer ${_prefs.getString('token')}",
      });
      if (200 == res.statusCode) {
        print('photo uploaded');
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
        Navigator.pushNamedAndRemoveUntil(
            context, DashBoard.id, (route) => false);
      }
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: _key,
                        controller: _accountNumber,
                        decoration: InputDecoration(
                          //: null,
                          hintText: 'Enter a account number',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              //Color(0xff016b1d),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    _profile == null
                        ? GestureDetector(
                            onTap: () => selectOptions(context),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
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
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width - 20,
                          ),
                    _signature == null
                        ? GestureDetector(
                            onTap: () => selectOptions2(context),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
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
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width - 20,
                          ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pink[600]),
                      onPressed: () => uploadPhoto(context),
                      child: Text('Upload Documents'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
