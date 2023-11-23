import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../palatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_sources/api_services.dart';
import '../models/api_error.dart';
import '../models/api_response.dart';
// import '../models/users.dart';
import '../services/api.dart';
import '../widgets/nav-drawer.dart';
import '../widgets/widgets.dart';
import 'home.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Photo Booth System"),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    child: Center(
                        child: Text('Photo Booth Experience', style: kHeading)),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // TextInput(
                              //   icon: Icons.email,
                              //   hint: 'Email',
                              //   inputType: TextInputType.emailAddress,
                              //   inputAction: TextInputAction.next,
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600]?.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      border: InputBorder.none,
                                      hintText: 'Name or phone number',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(Icons.account_box,
                                            color: Colors.white, size: 20),
                                      ),
                                      hintStyle: kBodyText,
                                    ),
                                    style: kBodyText,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill name or phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // PasswordInput(
                              //   icon: Icons.lock,
                              //   hint: 'Mật khẩu',
                              //   inputAction: TextInputAction.done,
                              //   passwordController: passwordController,
                              // ),
                              // Text(
                              //   'Quên mật khẩu?',
                              //   style: kBodyText,
                              // ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 120,
                              ),
                              //RoundButon(buttonText: 'Đăng Nhập'),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)),
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        'Photo Booth Experience',
                                        style: kBodyText,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordController.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('Processing Data')),
                                        );
                                        _handleSubmitted();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Please fill input')));
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(color: Colors.white),
                              //     ),
                              //   ),
                              //   child:
                              //       Text('Tạo tài khoản mới', style: kBodyText),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: NavDrawer(),
        ),
      ],
    );
  }

  void _handleSubmitted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final FormState? form = _formKey.currentState;
    ApiResponse? _apiResponse = new ApiResponse();
    if (!form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Name or phone must required.')));
    } else {
      form.save();
      print('Name input ' + emailController.text);

      var directory = await getExternalDocumentPath();
      var newFolder =
          await createFolder(directory + "/" + emailController.text);
      //var directory = await Directory("/storage/emulated/0/$emailController.text").create(recursive: true);
      print(newFolder);
      if (newFolder.isNotEmpty) {
        if (newFolder.toString() == 'existed') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('This user had existed with name : ' +
                  emailController.text)));
          await prefs.setString("username", emailController.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntroScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Folder was created with name : ' + newFolder)));
          await prefs.setString("username", emailController.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntroScreen()),
          );
        }
      }
    }
  }

  void _saveAndRedirectToHome(_apiResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", emailController.text);
    // await prefs.setString("access_token", (_apiResponse.Data as Users).access_token);
    // await prefs.setString("userEmail", (_apiResponse.Data as Users).userEmail);
    // print("Api return at login screen ");
    // print(_apiResponse.Data as Users);
    //
    // Navigator.pushNamedAndRemoveUntil(
    //     context, '/home', ModalRoute.withName('/home'),
    //     arguments: (_apiResponse.Data as Users));
  }

  Future<String> createFolder(String cow) async {
    print('Begin create folder');
    final folderName = cow;
    final path = Directory(folderName);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return 'existed';
    } else {
      path.create();
      return path.path;
    }
  }

  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }
}
