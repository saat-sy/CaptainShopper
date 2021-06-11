import 'package:flutter/material.dart';

class ProductsModel {
  List<dynamic> images;
  String title;
  String description;
  String oldPrice;
  String newPrice;
  String brand;
  String productID;
  List<dynamic> reviews;
  double totalRating;
  List<dynamic> ratings;
  String quantity;
  List<dynamic> usernames;
  String discount;

  ProductsModel({
    this.brand,
    this.description,
    this.discount,
    this.quantity,
    this.newPrice,
    this.oldPrice,
    this.totalRating,
    this.ratings,
    this.reviews,
    this.productID,
    this.images,
    this.usernames,
    this.title,
  });
}
