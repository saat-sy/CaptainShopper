import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/order/placeOrder.dart';
import 'package:frontend/screens/profile/profile.dart';
import 'package:frontend/styles/style_sheet.dart';

class SettingsPage extends StatefulWidget {
  bool fromOrder;
  SettingsPage({@required this.fromOrder});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;

  final creditCardName = TextEditingController(),
      creditCardNo = TextEditingController(),
      creditCardexpiration = TextEditingController(),
      name = TextEditingController(),
      address = TextEditingController();

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

  addDetails() async {
    showLoaderDialog(context);

    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Credit Card Details')
        .doc('CreditCardInfo')
        .update({
          'credit_card_name': creditCardName.text,
          'credit_card_no': creditCardNo.text,
          'credit_card_expiration': creditCardexpiration.text
        })
        .then((value) => val = 'Done')
        .catchError((e) => val = 'error');

    if (val != 'error')
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('Address')
          .doc('AddressList')
          .update({
            'name': name.text,
            'address': address.text,
          })
          .then((value) => val = 'Changes Saved')
          .catchError((e) => val = 'Failed to save changes');

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pop(context);
    if (val != 'Failed to save changes') {
      if(widget.fromOrder)
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => PlaceOrder()));
      else
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  getDetails() async {
    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Credit Card Details')
        .get()
        .then((QuerySnapshot querySnapshot) {
      val = 'Done';
      querySnapshot.docs.forEach((doc) {
        creditCardName.text = doc['credit_card_name'];
        creditCardNo.text = doc['credit_card_no'];
        creditCardexpiration.text = doc['credit_card_expiration'];
      });
    }).catchError((e) => val = 'error');

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Address')
        .get()
        .then((QuerySnapshot querySnapshot) {
      val = 'Done';
      querySnapshot.docs.forEach((doc) {
        name.text = doc['name'];
        address.text = doc['address'];
      });
    }).catchError((e) => val = 'error');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Credit Card Info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Divider(color: Colors.black, height: 2),
                      ),
                      TextFormField(
                        controller: creditCardName,
                        validator: (value) => value.isEmpty
                            ? 'Please enter the name mentioned on your Credit Card'
                            : null,
                        decoration: const InputDecoration(
                          hintText: 'Name on your Credit Card',
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        controller: creditCardNo,
                        validator: (value) => value.isEmpty
                            ? 'Please enter your Credit Card number'
                            : null,
                        decoration: const InputDecoration(
                          hintText: 'Credit Card Number',
                          labelText: 'Number',
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: creditCardexpiration,
                          validator: (value) => value.isEmpty
                              ? 'Please enter the expiration mm/yy'
                              : null,
                          decoration: const InputDecoration(
                            labelText: 'Expiration',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Account Info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Divider(color: Colors.black, height: 2),
                      ),
                      TextFormField(
                        controller: name,
                        validator: (value) => value.isEmpty
                            ? 'Please enter your full name'
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                      ),
                      TextFormField(
                        controller: address,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your address' : null,
                        decoration: const InputDecoration(
                          hintText: 'Full Address',
                          labelText: 'Address',
                        ),
                      ),
                      SizedBox(height: 20),
                      SubmitButton(
                        text: 'Save Changes',
                        onPress: () {
                          if (_formKey.currentState.validate()) {
                            addDetails();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
