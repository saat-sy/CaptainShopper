import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';

class DealsProductScreen extends StatefulWidget {
  @override
  _DealsProductScreenState createState() => _DealsProductScreenState();
}

class _DealsProductScreenState extends State<DealsProductScreen> {
  List<String> media = [
    'assets/products/product1.png',
    'assets/products/product1.png',
    'assets/products/product1.png',
    'assets/products/product1.png',
    'assets/products/product1.png',
  ];

  List<String> relatedImages = [
    'assets/products/product2.png',
    'assets/products/product1.png',
    'assets/products/product2.png',
    'assets/products/product1.png',
    'assets/products/product2.png',
    'assets/products/product1.png',
  ];

  List<Color> relatedColors = [
    Color(0xFF5C4D93),
    Color(0xFFD37C79),
    Color(0xFF5C4D93),
    Color(0xFFD37C79),
    Color(0xFF5C4D93),
    Color(0xFFD37C79),
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
                color: Color(0xFFD37C79),
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
                  color: Colors.grey.shade200,
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
                              width: 80,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                color: Color(0xFFD37C79),
                              ),
                              child: Image(
                                image: AssetImage(media[index]),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5 Packs of SuperFruit Barries',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '\$' + '199.99',
                          style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 21,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '\$' + '68.99',
                          style: TextStyle(
                            color: MyColors.PrimaryColor,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.green.withOpacity(0.15)),
                          child: Center(
                            child: Text(
                              '75' + '% OFF',
                              style: TextStyle(
                                  color: MyColors.PrimaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '5.0',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RatingBarIndicator(
                          rating: 5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(6,256 Ratings)',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Brand:',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Candy Cane',
                          style: TextStyle(color: MyColors.PrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Style: \nNew',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 18,)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('3 colors: \nReal Flowers',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 18,)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: MyColors.PrimaryColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: MyColors.PrimaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                        color: MyColors.PrimaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                  'Related Coupons',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 11),
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(0, 4),
                                blurRadius: 3.0,
                                spreadRadius: 1.0)
                          ],
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        width: 200,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: relatedColors[index],
                              ),
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Image(
                                  height: 75,
                                  image: AssetImage(relatedImages[index]),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '5.0',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        RatingBarIndicator(
                                          rating: 5,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 13.0,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '(6,256 Ratings)',
                                          style: TextStyle(
                                              color: Colors.grey.shade400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '\$' + '199.99',
                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '\$' + '68.99',
                                          style: TextStyle(
                                            color: MyColors.PrimaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.green
                                                  .withOpacity(0.15)),
                                          child: Center(
                                            child: Text(
                                              '75' + '% OFF',
                                              style: TextStyle(
                                                  color: MyColors.PrimaryColor,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '5 Packs of SuperFruit Barries',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Sold By:',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Candy Cane',
                                          style: TextStyle(
                                              color: MyColors.PrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                  },
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name[index],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
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
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              review[index],
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
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
