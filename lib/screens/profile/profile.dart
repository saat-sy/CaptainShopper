import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/screens/authentication/login.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/screens/profile/profile_components/claim_your_wins.dart';
import 'package:frontend/screens/profile/profile_components/customer_service.dart';
import 'package:frontend/screens/profile/profile_components/orders.dart';
import 'package:frontend/screens/profile/profile_components/rewards.dart';
import 'package:frontend/screens/profile/profile_components/settings.dart';
import 'package:frontend/screens/profile/profile_components/write_a_review.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

enum AppState { free, picked, cropped }

class _ProfileState extends State<Profile> {
  AppState state;

  File imageFile;

  PickedFile image;
  final picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  bool fromFirebase = false;
  var url;

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  initState() {
    var u = FirebaseAuth.instance.currentUser.photoURL;
    if (u != null) {
      fromFirebase = true;
      url = u;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: MyColors.PrimaryColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            height: 75 + (MediaQuery.of(context).size.width * 0.28),
          ),
          Center(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        showLoaderDialog(context);

                        image =
                            await picker.getImage(source: ImageSource.gallery);
                        if (image != null) {
                          imageFile = File(image.path);

                          File croppedFile = await ImageCropper.cropImage(
                              sourcePath: imageFile.path,
                              aspectRatioPresets: Platform.isAndroid
                                  ? [
                                      CropAspectRatioPreset.square,
                                    ]
                                  : [
                                      CropAspectRatioPreset.square,
                                    ],
                              androidUiSettings: AndroidUiSettings(
                                  toolbarTitle: 'Cropper',
                                  toolbarColor: MyColors.PrimaryColor,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio: CropAspectRatioPreset.square,
                                  lockAspectRatio: true),
                              iosUiSettings: IOSUiSettings(
                                title: 'Cropper',
                              ));
                          if (croppedFile != null) {
                            imageFile = croppedFile;

                            UploadTask uploadTask = _storage
                                .ref()
                                .child(
                                    'profile_photos/${FirebaseAuth.instance.currentUser.uid}')
                                .putFile(imageFile);

                            String downloadURL;
                            await uploadTask.whenComplete(() async {
                              downloadURL = await uploadTask.snapshot.ref
                                  .getDownloadURL();
                            });

                            User user = FirebaseAuth.instance.currentUser;
                            await user.updateProfile(photoURL: downloadURL);

                            setState(() {
                              url = downloadURL;
                              fromFirebase = true;
                            });
                          } else
                            print('No file found');
                        }
                        Navigator.pop(context);
                      },
                      child: ClipOval(
                        child: fromFirebase
                            ? Image.network(
                                url,
                                width: MediaQuery.of(context).size.width * 0.28,
                              )
                            : Image(
                                image: AssetImage('assets/profile.png'),
                                width: MediaQuery.of(context).size.width * 0.28,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser.displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser.email,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9), fontSize: 15),
                    ),
                    SizedBox(height: 35),
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrders()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.bag_fill,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('My Orders',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClaimYourWins()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.cash,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Cash Out',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNav(
                                      index: 4,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Favorites and Saves',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.ticket,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Redeem Coupons',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Rewards()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.seal,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Rewards',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WriteAReview()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.starPlus,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Write a Review',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerSupport()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.headset_mic,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Customer Support',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                    fromOrder: false,
                                  )));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: MyColors.PrimaryColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                    onTap: () async {
                      await context.read<AuthenticationService>().signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: MyColors.PrimaryColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
