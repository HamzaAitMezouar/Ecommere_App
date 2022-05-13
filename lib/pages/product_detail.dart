import 'package:ecom/models/products.dart';
import 'package:ecom/pages/Paypal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class productDetails extends StatefulWidget {
  @override
  State<productDetails> createState() => _productDetailsState();
  String? name;
  String? image;
  String? category;
  double? price;
  String? desc;

  productDetails(
      {required this.name,
      required this.image,
      required this.category,
      required this.price,
      required this.desc});
}

class _productDetailsState extends State<productDetails> {
  bool isfavourite = false;
  double rating = 1;
  int numItem = 1;
  clickfavourite() {
    setState(() {
      if (isfavourite) {
        isfavourite = false;
      } else {
        isfavourite = true;
        Get.snackbar('You Liked This Products', '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        body: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image!),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                    height: 350,
                  ),
                  Positioned(
                    top: 25,
                    left: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 20),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    top: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.name!,
                                        style: GoogleFonts.lora(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${widget.price.toString()}\$',
                                        style: TextStyle(
                                            color: Colors.amber[600],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, left: 14),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Rate this products :${rating}',
                                          style: GoogleFonts.lora(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                        RatingBar.builder(
                                            itemSize: 20,
                                            updateOnDrag: true,
                                            minRating: 0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                      226, 247, 191, 24),
                                                ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                this.rating = rating;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon:
                                      SvgPicture.asset('assets/addtocart.svg')),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 24,
                                    width: 28,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        onPressed: () {
                                          if (numItem > 1) {
                                            setState(() {
                                              numItem--;
                                            });
                                          }
                                        },
                                        child: const Icon(Icons.remove)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      numItem.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                    width: 28,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        onPressed: () {
                                          setState(() {
                                            numItem++;
                                          });
                                        },
                                        child: const Icon(Icons.add)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(14),
                                          side: const BorderSide(
                                              color: Colors.amber),
                                          elevation: 5,
                                          primary: Colors.amber,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        Get.to(Paypal(
                                            image: widget.image!,
                                            name: widget.name!,
                                            price: widget.price!,
                                            quantity: numItem));
                                      },
                                      child: const Text(
                                        'Buy Now',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        clickfavourite();
                                      },
                                      icon: isfavourite
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Color.fromARGB(
                                                  255, 255, 19, 98),
                                            )
                                          : const Icon(Icons.favorite_border)),
                                ],
                              )
                            ],
                          ),
                        ),
                        height: 100,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Description : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Text(widget.desc!,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
