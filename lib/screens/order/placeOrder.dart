import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/screens/profile/profile_components/orders.dart';
import 'package:frontend/screens/profile/profile_components/settings.dart';
import 'package:frontend/styles/style_sheet.dart';
import 'package:intl/intl.dart';

class PlaceOrder extends StatefulWidget {
  String products;
  String subtotal;

  PlaceOrder({this.products, this.subtotal});

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String nameAddress, address;
  String creditCardName, creditCardNo, creditCardexpiration;

  bool isAddressEmpty = true;

  double discount = 0;

  String coupons;

  bool isLoading = true;

  final couponsList = <String>[];

  getData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      coupons = documentSnapshot.get('coupons');
    });

    if (coupons != '')
      coupons.split(',').forEach((element) {
        couponsList.add(element);
      });

    setState(() {
      isLoading = false;
    });
  }

  removeCoupon(int index) async {
    showLoaderDialog(context);

    int i = 0;

    String finalCoupon = '';

    coupons.split(',').forEach((element) {
      if (finalCoupon.isNotEmpty) finalCoupon += ',';
      if (element == couponsList[index]) {
        if (i == 0) {
          i = 1;
        } else {
          finalCoupon += element;
        }
      } else {
        finalCoupon += element;
      }
    });

    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
          'coupons': finalCoupon,
        })
        .then((value) => val = 'Removed from Cart')
        .catchError((e) {
          val = 'An error occured';
          print(e);
        });

    discount = double.parse(widget.subtotal) *
        (double.parse(couponsList[index]) / 100);

    couponsList.removeAt(index);

    setState(() {
      isLoading = true;
      getData();
    });

    Navigator.pop(context);
  }

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

  showOrderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order Success',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your order is being processed by the system, you can see the progress at',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyOrders()));
                },
                child: Text(
                  'My Order',
                  style: TextStyle(
                    color: MyColors.PrimaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/order_confirmed.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNav()));
                },
                child: Container(
                  color: MyColors.PrimaryColor,
                  padding: EdgeInsets.all(5),
                  child: Text('Go back', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ));
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool isAddressLoading = true;
  getAddress() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Address')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        nameAddress = doc['name'];
        address = doc['address'];
      });
    }).catchError((e) => print(e));

    if (nameAddress != '')
      setState(() {
        isAddressEmpty = false;
      });

    setState(() {
      isAddressLoading = false;
    });
  }

  bool isCreditCardLoading = true;
  getCreditCard() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Credit Card Details')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        creditCardName = doc['credit_card_name'];
        creditCardNo = doc['credit_card_no'];
        creditCardexpiration = doc['credit_card_expiration'];
      });
    }).catchError((e) => print(e));

    setState(() {
      isCreditCardLoading = false;
    });
  }

  @override
  void initState() {
    getAddress();
    getCreditCard();
    getData();
    super.initState();
  }

  int currentIndex = 0;
  PageController pageController = PageController();
  void animateToNextPage(int index) {
    currentIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<int> getCurrentOrderID() async {
    int orderId = 0;
    await FirebaseFirestore.instance
        .collection("Orders")
        .orderBy("order_id", descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        orderId = (int.parse(element['order_id'].toString()) + 1);
      });
    });
    return orderId;
  }

  Future<String> getCurrentUserOrders() async {
    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      val = documentSnapshot.get('orders');
    }).catchError((e) {
      print(e);
      val = 'An error occured';
    });
    return val;
  }

  placeOrder() async {
    showLoaderDialog(context);
    String o = await getCurrentUserOrders();

    for (final element in widget.products.split(',')) {
      int orderID = await getCurrentOrderID();
      if (o != '') o += ',';
      o += orderID.toString();
      await FirebaseFirestore.instance
          .collection("Orders")
          .add({
            'order_id': orderID,
            'products': element,
            'time': DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
            'reviewed': false,
            'address': address,
            'full_name': nameAddress,
            'delivered': false
          })
          .then((value) {})
          .catchError((e) => print(e));
    }

    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'orders': o})
        .then((value) => val = 'Removed from Cart')
        .catchError((e) {
          val = 'An error occured';
          print(e);
        });

    Navigator.pop(context);
    showOrderDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: [
          Stack(
            children: [
              //BOTTOM
              Container(
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: MyColors.PrimaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: MyColors.PrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        animateToNextPage(1);
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: MyColors.PrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //TOP
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Verify your Address",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    isAddressLoading
                        ? Container(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : isAddressEmpty
                            ? Container(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                        'No address found. Please add a new address')),
                              )
                            : Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nameAddress,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Divider(
                                        color: Colors.black,
                                        height: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Address:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      address,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage(
                                      fromOrder: true,
                                    )));
                      },
                      child: Text(
                          isAddressEmpty ? "Add Address" : "Change address",
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              //BOTTOM
              Container(
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        animateToNextPage(0);
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: MyColors.PrimaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(color: MyColors.PrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate())
                          animateToNextPage(2);
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: MyColors.PrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //TOP
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Verify your Credit Card Details",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      isCreditCardLoading
                          ? Container(
                              height: 200,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Credit Card Number:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    creditCardNo,
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Name on Credit Card:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    creditCardName,
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Expiry:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    creditCardexpiration,
                                    style: TextStyle(fontSize: 19),
                                  ),
                                ],
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage(
                                        fromOrder: true,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("Change details",
                              style: TextStyle(
                                  color: MyColors.PrimaryColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter the CVV',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                validator: (value) =>
                                    value.isEmpty ? 'Enter your CVV' : null,
                                controller: cvvController,
                                cursorColor: MyColors.PrimaryColor,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  hintText: 'CVV',
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: MyColors.PrimaryColor,
                                          width: 1.0)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [

              couponsList.length == 0
                  ? Center(
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/empty_coupons.png",
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              Text('No Coupons found',
                                  style: TextStyle(fontSize: 23))
                            ]),
                      ),
                    )
                  : Container(
                    color: Colors.white,
                    child: ListView.builder(
                        itemCount: couponsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              removeCoupon(index);
                            },
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1.0),
                                ),
                                child: Stack(
                                  children: [
                                    Row(children: [
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 1.0),
                                            ),
                                          ),
                                          child: Text('${couponsList[index]}%',
                                              style: TextStyle(
                                                  color: MyColors.PrimaryColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold))),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('OFF THIS PURCHASE',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height: 3),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: MyColors.PrimaryColor),
                                              child: Center(
                                                  child: Text('Claim',
                                                      style: TextStyle(
                                                          color: Colors.white))),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ],
                                )),
                          );
                        },
                      ),
                  ),

              //BOTTOM
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          animateToNextPage(1);
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: MyColors.PrimaryColor),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              'Back',
                              style: TextStyle(color: MyColors.PrimaryColor),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          animateToNextPage(3);
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: MyColors.PrimaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    SubmitButton(
                      text: 'Place your order',
                      onPress: () {
                        placeOrder();
                      },
                    ),
                    SizedBox(height: 25),
                    Text('Order Summary',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Subtotal',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '\$' + widget.subtotal,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                discount != 0
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Discount',
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                '\$${discount.toString()}',
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Shipping',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '\$0',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              child: Divider(
                            height: 2,
                            color: Colors.grey.shade500,
                          )),
                          Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$' +
                                      (double.parse(widget.subtotal) - discount)
                                          .toString(),
                                  style: TextStyle(
                                      color: MyColors.PrimaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            animateToNextPage(2);
                          },
                          child: Text(
                            'Go Back',
                            style: TextStyle(color: MyColors.PrimaryColor),
                          ),
                        ),
                      ],
                    )
                  ]))
        ],
      ),
    );
  }
}
