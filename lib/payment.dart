import 'package:Online_grocery_app/Authentication/firstscreen.dart';
import 'package:Online_grocery_app/Helpers/Devicesize.dart';
import 'package:Online_grocery_app/Profile.dart';
import 'package:Online_grocery_app/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var finalans = 0;
  var user = FirebaseAuth.instance.currentUser.uid.toString();
  @override
  Future<void> getprice() async {
    QuerySnapshot q = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user)
        .collection("Details")
        .get();

    var a = q.docs[0];

    setState(() {
      finalans = a["price"];
    });

    print("finalans is $finalans");
  }

  Future<void> displaymodalsheetofpay(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffbDE6262),
                Color(0xffbFFB88C),
              ]),
            ),
            height: displayHeight(context) * 0.2,
            width: displayWidth(context),
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Text(
                  "Thanks for shopping !!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: displayWidth(context) * 0.045),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => profile()));
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          height: displayHeight(context) * 0.045,
                          width: displayWidth(context) * 0.25,
                          child: Center(child: Text("Edit Details")),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          height: displayHeight(context) * 0.045,
                          width: displayWidth(context) * 0.35,
                          child: Center(child: Text("Continue Shopping")),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => first()));
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          height: displayHeight(context) * 0.045,
                          width: displayWidth(context) * 0.25,
                          child: Center(child: Text("Log Out")),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    getprice();
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your mode of payment"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text(
              "Cash On Delivery",
              style: TextStyle(fontSize: displayWidth(context) * 0.045),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text("Pay when item is delivered"),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "UPI-Gpay/PhonePe",
              style: TextStyle(fontSize: displayWidth(context) * 0.045),
            ),
            initiallyExpanded: false,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: displayWidth(context) * 0.15,
                  ),
                  Container(
                    // color: Colors.yellow,
                    height: displayHeight(context) * 0.1,
                    width: displayWidth(context) * 0.2,
                    child: Image(
                      image: AssetImage(
                        "images/gp.jpg",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.15,
                  ),
                  Container(
                    // color: Colors.yellow,
                    height: displayHeight(context) * 0.1,
                    width: displayWidth(context) * 0.2,
                    child: Image(
                      image: AssetImage(
                        "images/phpe.png",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Other Payment Options",
              style: TextStyle(fontSize: displayWidth(context) * 0.045),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text("Net Banking"),
              ),
              ListTile(
                title: Text("Debit/ATM Card"),
              ),
              ListTile(
                title: Text("EMI"),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.2,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                displaymodalsheetofpay(context);
              },
              child: Container(
                height: displayHeight(context) * 0.065,
                width: displayWidth(context) * 0.8,
                color: Colors.red,
                child: Center(
                    child: Text(
                  "Pay Rs $finalans",
                  style: TextStyle(
                      fontSize: displayWidth(context) * 0.055,
                      color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}