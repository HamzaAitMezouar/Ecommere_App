import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/products.dart';

class DatabaseProducts {
  Stream<List<Products>> getProducts() =>
      FirebaseFirestore.instance.collection('products').snapshots().map(
            (snapshot) => snapshot.docs.map((doc) {
              return Products.fromJson(
                doc.data(),
              );
            }).toList(),
          );
  Stream<List<Products>>? getProductsbyCat(String cat) =>
      FirebaseFirestore.instance
          .collection('Products')
          .where('category', isEqualTo: cat)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) {
              return Products.fromJson(
                doc.data(),
              );
            }).toList(),
          );
  Stream<QuerySnapshot> getProductscat() =>
      FirebaseFirestore.instance.collection('categories').snapshots();
}
