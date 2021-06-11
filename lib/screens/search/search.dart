import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/products_model.dart';
import 'package:frontend/screens/productScreens/dealsProduct.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();

  bool isLoading = true;
  bool noSearch = true;

  var products = <ProductsModel>[];

  getProducts() async {
    await FirebaseFirestore.instance
        .collection('Products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((product) {
        final p = ProductsModel(
            title: product['title'],
            images: product['images'],
            oldPrice: product['oldPrice'],
            newPrice: product['newPrice'],
            discount: product['discount'],
            productID: product['product_id'],
            totalRating: double.parse(product['total_rating'].toString()),
            brand: product['brand']);
        if (p.title.toLowerCase().contains(searchController.text.toLowerCase()))
          products.add(p);
      });
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  var focusNode = FocusNode();
  @override
  initState() {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(focusNode);
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  controller: searchController,
                  focusNode: focusNode,
                  onFieldSubmitted: (value) {
                    products = [];
                    setState(() {
                      noSearch = false;
                      isLoading = true;
                    });
                    getProducts();
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    hintText: 'Search a product',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Visibility(
                      visible: true,
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: Visibility(
                      visible: true,
                      child: IconButton(
                        onPressed: () {
                          searchController.text = '';
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(color: Colors.grey.shade500, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            BorderSide(color: Colors.grey.shade500, width: 1)),
                  )),
            ),
            noSearch
                ? Container()
                : Expanded(
                    child: isLoading
                        ? Container(
                            child: Center(child: CircularProgressIndicator()))
                        : products.length == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Image.asset(
                                      "assets/empty_search.png",
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                    ),
                                    Text('Sorry! No product found',
                                        style: TextStyle(fontSize: 23))
                                  ])
                            : ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DealsProductScreen(
                                            productID: products[index].productID,
                                          )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 0.5)),
                                      padding: EdgeInsets.all(13),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            products[index].images[0],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8)),
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${products[index].title}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '\$' +
                                                          products[index]
                                                              .oldPrice,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade400,
                                                          fontSize: 16,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          products[index]
                                                              .newPrice,
                                                      style: TextStyle(
                                                        color:
                                                            MyColors.PrimaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors.green
                                                              .withOpacity(0.15)),
                                                      child: Center(
                                                        child: Text(
                                                          products[index]
                                                                  .discount +
                                                              '% OFF',
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .PrimaryColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                      products[index]
                                                          .totalRating
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: double.parse(
                                                          products[index]
                                                              .totalRating
                                                              .toString()),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 15.0,
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
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      products[index].brand,
                                                      style: TextStyle(
                                                          color: MyColors
                                                              .PrimaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
          ],
        ),
      ),
    );
  }
}
