import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';

class GiveawayProduct extends StatefulWidget {
  @override
  _GiveawayProductState createState() => _GiveawayProductState();
}

class _GiveawayProductState extends State<GiveawayProduct> {
  List<String> media = [
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/PS5.png',
  ];

  List<Color> media_colors = [
    Colors.deepPurple,
    Colors.white,
    Colors.blue.shade900,
    Colors.blueGrey.shade900,
    Colors.black,
  ];

  List<bool> isVideo = [true, false, false, false, false];

  List<String> name = [
    'Alex Jackson',
    'Peter Johnson',
    'Tim Cook',
    'Peter Parker',
    'I can\'t think of any other name'
  ];

  List<double> rating = [5.0, 4.0, 4.0, 5.0, 5.0];

  List<String> review = [
    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English.',
    'Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy.',
    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.'
  ];
  String description =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.';

  int activeMedia = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: media_colors[activeMedia],
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Image(
                          image: AssetImage(media[activeMedia]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}),
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
                                  onTap: () {},
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Icon(
                                            Icons.info_outline,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'Watch ad to join the giveaway',
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
                            activeMedia = index;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.deepPurple),
                                  color: media_colors[index]),
                              child: Image(
                                image: AssetImage(media[index]),
                                height: MediaQuery.of(context).size.height * 0.1,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.topRight,
                              child: 
                              isVideo[index] ? 
                              Icon(Icons.play_circle_fill, color: Colors.white, size: 15,)
                              :
                              Icon(Icons.image, color: Colors.white, size: 15,)
                            )
                          ],
                        ),
                      );
                    },
                  )
                ),

              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.PrimaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Text(
                    'Click here to Watch Ad',
                    style: TextStyle(
                      color: MyColors.PrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'PS5 Console Giveaway',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(CupertinoIcons.clock, color: MyColors.PrimaryColor,),
                        SizedBox(height: 5,),
                        Text('5 min',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16)
                        ),
                        Text('Time left',
                          style: TextStyle(color: Colors.grey, fontSize: 14)
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(CupertinoIcons.person, color: MyColors.PrimaryColor,),
                        SizedBox(height: 7,),
                        Text('4800/5000*',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 15.5)
                        ),
                        Text('Joined Overall',
                          style: TextStyle(color: Colors.grey, fontSize: 14)
                        )
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
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),

              SizedBox(height: 10,),

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

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),

              SizedBox(height: 7,),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: review.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                              ),
                            ),
                            RatingBarIndicator(
                              rating: rating[index],
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 13.0,
                            ),
                            SizedBox(height: 6,),
                            Text(review[index],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15
                              ),
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
