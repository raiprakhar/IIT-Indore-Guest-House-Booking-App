import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:soft_proj/ScopedModels/mainmodel.dart';
import 'dart:async';

final smtpServer = gmail('user@iiti.ac.in', '');
final message = Message()
  ..from = Address('user@iiti.ac.in')
  ..recipients.add('cse180001035@iiti.ac.in') //recipent email
  ..ccRecipients.addAll(
      ['destCc1@example.com', 'cse180001035@iiti.ac.in']) //cc Recipents emails
  ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
  ..subject =
      'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
  ..text =
      'This is the plain text.\nThis is line 2 of the text part.'; //body of the email

class PayPage extends StatefulWidget {
  final MainModel model;
  final String payAmtstr;
  PayPage(this.model, this.payAmtstr);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  int totalAmount;
  var em = "";
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    totalAmount = int.parse(widget.payAmtstr);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void launchPayment() async {
    var options = {
      'key': 'rzp_test_hAp4ncD8bvQBaI', //your razopay key
      'amount': totalAmount * 100,
      'name': 'IIT Indore Guest House Booking',
      'description': 'Payment from Flutter app',
      'prefill': {'contact': '', 'email': em},
      'external': {
        'wallets': ['gpay']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    await send(message, smtpServer);
    Fluttertoast.showToast(
        msg: 'Error ' + response.code.toString() + ' ' + response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await send(message, smtpServer);
    Fluttertoast.showToast(
        msg: 'Payment Success ' + response.paymentId,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
    _changePage();
  }

  void _changePage() async {
    await new Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/postPay');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    send(message, smtpServer);
    Fluttertoast.showToast(
        msg: 'Wallet Name ' + response.walletName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IITI Payement Portal'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Guest House Booking', style: TextStyle(fontSize: 28)),
              SizedBox(height: 15.0),
              LimitedBox(
                maxWidth: 150.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Amount To Pay = ' + totalAmount.toString(),
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(height: 15.0),
              LimitedBox(
                maxWidth: 150.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:
                      InputDecoration(hintText: 'Email: ' + 'User@iiti.ac.in'),
                  enabled: false,
                  onChanged: (text) {
                    setState(() {
                      em = text;
                    });
                  },
                ),
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                color: Colors.lightBlue,
                child: Text('Proceed'),
                onPressed: () {
                  launchPayment();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
