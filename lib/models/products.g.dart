// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      name: json['name'] as String?,
      image: json['image'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'category': instance.category,
      'price': instance.price,
      'desc': instance.desc,
    };
