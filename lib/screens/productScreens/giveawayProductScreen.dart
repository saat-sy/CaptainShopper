import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';

class GiveawayProduct extends StatefulWidget {
  String id;
  GiveawayProduct({this.id});

  @override
  _GiveawayProductState createState() => _GiveawayProductState();
}

class _GiveawayProductState extends State<GiveawayProduct> {
  bool isLoading = true;
  bool inFav = false;
  bool hasEntered = false;
  String doc;
  String uid;

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

  Future<String> getUserFavs() async {
    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      val = documentSnapshot.get('giveaway_favorite');
    }).catchError((e) {
      print(e);
      val = 'An error occured';
    });
    return val;
  }

  getProductDetails() async {
    await FirebaseFirestore.instance
        .collection('Giveaways')
        .where('giveaway_id', isEqualTo: widget.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        media = doc['images'];
        isVideo = doc['is_video'];
        name = doc['usernames'];
        rating = doc['ratings'];
        review = doc['reviews'];
        description = doc['description'];
        title = doc['title'];
        users = doc['users'];
        members = doc['members'].toString();
        duration = doc['duration'].toString();
        this.doc = doc.id;
      });
    });
    String isFav = await getUserFavs();
    if (isFav != "An error occured")
      isFav.split(',').forEach((product) {
        if (product == widget.id) inFav = true;
      });

    String enter = users;
    enter.split(',').forEach((element) {
      print(element);
      if (element == uid) hasEntered = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> enterGiveAway() async {
    showLoaderDialog(context);
    String val = '';

    if (users != '') users += ',';

    await FirebaseFirestore.instance
        .collection('Giveaways')
        .doc(doc)
        .update({'users': users + uid})
        .then((value) => val = 'You\'ve successfully entered the giveaway!')
        .catchError((e) {
          val = 'An error occured';
          print(e);
        });

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (val != 'An error occured')
      setState(() {
        hasEntered = true;
      });
    Navigator.pop(context);
  }

  Future<void> addToFav() async {
    showLoaderDialog(context);

    String val = '';

    String favs = await getUserFavs();
    if (favs != "") favs += ',';
    if (favs == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'giveaway_favorite': favs + widget.id})
          .then((value) => val = 'Added to Favorites')
          .catchError((e) {
            val = 'An error occured';
            print(e);
          });
    }

      final snackBar = SnackBar(content: Text(val));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (val != 'An error occured')
      setState(() {
        inFav = true;
      });
    Navigator.pop(context);
  }

  Future<void> removeFromFav() async {
    showLoaderDialog(context);

    String val = '';

    String favs = await getUserFavs();
    if (favs == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      String newFavs = '';
      favs.split(',').forEach((element) {
        if (element != widget.id) {
          if (newFavs != '')
            newFavs += ',$element';
          else
            newFavs += element;
        }
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'giveaway_favorite': newFavs})
          .then((value) => val = 'Removed from Favorites')
          .catchError((e) {
            val = 'An error occured';
            print(e);
          });
    }

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (val != 'An error occured')
      setState(() {
        inFav = false;
      });
    Navigator.pop(context);
    Navigator.pop(context);
  }

  List<dynamic> media;
  List<dynamic> isVideo;
  List<dynamic> name;
  List<dynamic> rating;
  List<dynamic> review;
  String description, title, members, duration, users;

  int activeMedia = 0;

  final imageController = PageController();

  animateToIndex(int index) {
    imageController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    getProductDetails();
    uid = FirebaseAuth.instance.currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Stack(
                        children: [
                          PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                activeMedia = index;
                              });
                            },
                            controller: imageController,
                            itemCount: media.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(
                                  child: Image.network(
                                    media[activeMedia],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {})
                                  ],
                                ),
                                isVideo[activeMedia]
                                    ? GestureDetector(
                                        onTap: () {
                                          if (!hasEntered) enterGiveAway();
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.play_circle_fill_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            Text(
                                              'Play Now',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                                isVideo[activeMedia]
                                    ? RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.white,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    'Watch ad to join the giveaway',
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.11,
                        color: Colors.grey.shade300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: media.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  animateToIndex(index);
                                  activeMedia = index;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: index == activeMedia ? 2 : 1,
                                          color: index == activeMedia
                                              ? MyColors.PrimaryColor
                                              : Colors.grey.shade200),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        media[index],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      alignment: Alignment.topRight,
                                      child: isVideo[index]
                                          ? Icon(
                                              Icons.play_circle_fill,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          : Icon(
                                              Icons.image,
                                              color: Colors.white,
                                              size: 15,
                                            ))
                                ],
                              ),
                            );
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        if (!hasEntered) enterGiveAway();
                      },
                      child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.PrimaryColor, width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            hasEntered
                                ? 'You have entered the giveaway!'
                                : 'Click here to Watch Ad',
                            style: TextStyle(
                                color: MyColors.PrimaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: inFav
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.pinkAccent.shade400,
                                  )
                                : Icon(Icons.favorite_outline),
                            onPressed: () async {
                              if (inFav)
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Remove giveaway?'),
                                    content: const Text(
                                        'Do you want to remove this giveaway from favorites?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async =>
                                            await removeFromFav(),
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              else
                                await addToFav();
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(
                                CupertinoIcons.clock,
                                color: MyColors.PrimaryColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(duration,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              Text('Time left',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14))
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                CupertinoIcons.person,
                                color: MyColors.PrimaryColor,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text('${members}/5000',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.5)),
                              Text('Joined Overall',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: review.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                  RatingBarIndicator(
                                    rating:
                                        double.parse(rating[index].toString()),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 13.0,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    review[index],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ),
    );
  }
}
