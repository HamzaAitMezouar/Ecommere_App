import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/products.dart';
import 'package:ecom/pages/product_detail.dart';
import 'package:ecom/services/CrudProducts.dart';
import 'package:ecom/widgets/pageRoute.dart';
import 'package:ecom/widgets/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../services/Auth.dart';
import 'Authpage.dart';

class homebody extends StatefulWidget {
  homebody({Key? key}) : super(key: key);

  @override
  State<homebody> createState() => _homebodyState();
}

class _homebodyState extends State<homebody> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(
              width: 75,
              child: Lottie.network(
                  'https://assets1.lottiefiles.com/private_files/lf30_lXFF5L.json'),
            ),
            Text(
              'Destore',
              style: GoogleFonts.cormorant(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    Auth().SignOut();
                  },
                  icon: SvgPicture.asset('assets/cart.svg'))
              : IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => AuthPage())));
                  },
                  icon: Image.asset('assets/login.png'))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseProducts().getProductscat(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Shimmerpage();
          } else if (snapshot.hasError) {
            return Shimmerpage();
          } else if (snapshot.hasData) {
            final productscat = snapshot.data!;
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: productscat.size,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${productscat.docs[index]['type']}',
                            style: GoogleFonts.aclonica(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )),
                  SizedBox(
                    child: StreamBuilder<List<Products>>(
                        initialData: [],
                        stream: DatabaseProducts().getProductsbyCat(
                            '${productscat.docs[index]['type']}'),
                        builder: (context, snap) {
                          List<Products> products = snap.data!;
                          if (!snapshot.hasData) {
                            return Shimmerpage();
                          } else {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                if (snap.hasError) {
                                  return Shimmerpage();
                                } else if (snap.hasData) {
                                  return InkWell(
                                    onTap: (() => Navigator.push(
                                        context,
                                        pageRoute(
                                            child: productDetails(
                                          category: products[index].category!,
                                          image: products[index].image!,
                                          name: products[index].name!,
                                          price: products[index].price!,
                                          desc: products[index].desc!,
                                        )))),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          height: 166,
                                          width: 160,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    products[index].image!)),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        Text(
                                          '${products[index].name}',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          '${products[index].price.toString()}\$',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Shimmerpage();
                                }
                              },
                            );
                          }
                        }),
                    height: 240,
                  )
                ]);
              },
            );
          } else {
            return Shimmerpage();
          }
        },
      ),
    );
  }
}
