import 'package:flutter/material.dart';

class CouponModel {
  List<dynamic> images;
  String title;
  String description;
  String oldPrice;
  String newPrice;
  String brand;
  String store;
  String validTill;
  List<dynamic> reviews;
  String storeLocation;
  List<dynamic> ratings;
  List<dynamic> usernames;
  String discount;
  Color backgroundColor;
  String time;
  String totalRating;
  String couponID;

  CouponModel({
    this.brand,
    this.description,
    this.discount,
    this.newPrice,
    this.couponID,
    this.time,
    this.oldPrice,
    this.store,
    this.totalRating,
    this.backgroundColor,
    this.storeLocation,
    this.ratings,
    this.reviews,
    this.validTill,
    this.images,
    this.usernames,
    this.title,
  });
}
