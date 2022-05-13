import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:lottie/lottie.dart';

class Paypal extends StatefulWidget {
  String name;
  double price;
  int quantity;
  String image;
  Paypal(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.quantity})
      : super(key: key);
  @override
  State<Paypal> createState() => PaypalState();
}

class PaypalState extends State<Paypal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).hintColor,
            ),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(
                width: 75,
                child: Lottie.network(
                    'https://assets1.lottiefiles.com/private_files/lf30_lXFF5L.json'),
              ),
              const Text(
                'Paypal Payment',
                style: TextStyle(color: Colors.amber),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover)),
              height: 250,
              width: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.name,
              style: TextStyle(
                  color: Color.fromARGB(255, 58, 41, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${widget.price} \$',
              style: TextStyle(
                  color: Color.fromARGB(255, 185, 140, 2).withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Quantity : ${widget.quantity} ',
              style: TextStyle(
                  color: Color.fromARGB(255, 49, 34, 0).withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total  : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 49, 34, 0).withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${widget.quantity * widget.price} \$',
                  style: TextStyle(
                      color: Color.fromARGB(255, 196, 147, 1).withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextButton(
                  style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.amber.withOpacity(0.5)),
                      shadowColor: Color.fromARGB(255, 250, 215, 111),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                            sandboxMode: true,
                            clientId:
                                "AbqLVolPfbrCRVwE-BOFT7p-tTCwf9zvTwqS1t7kaR9LLd6piIzab_coYL_l1KRKUHOMgGzlc9KG0fBY",
                            secretKey:
                                "EF0s5TVhil4CZxeevgeisJ4mCYmD_wkziMuLmQG3hPtAOq9yoqeYIQTY9A1PTi43TEGDC1tP9RcRInmo",
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: [
                              {
                                "amount": {
                                  "total": '${widget.price}',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '${widget.price}',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": widget.quantity,
                                      "price": '${widget.price}',
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  /*"shipping_address": {
                                          "recipient_name": "Jane Foster",
                                          "line1": "Travis County",
                                          "line2": "",
                                          "city": "Austin",
                                          "country_code": "US",
                                          "postal_code": "73301",
                                          "phone": "+00000000",
                                          "state": "Texas"
                                        },*/
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                            },
                            onCancel: (params) {
                              print('cancelled: $params');
                            }),
                      ),
                    )
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            'assets/paypal.jpg',
                            fit: BoxFit.cover,
                          )),
                      const Text("Make Payment",
                          style: TextStyle(color: Colors.amber)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
