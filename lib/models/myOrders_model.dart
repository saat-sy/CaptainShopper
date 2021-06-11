class MyOrdersModel {
  String images;
  String orderID;
  String productID;
  String title;
  bool delivered;
  bool reviewed;

  MyOrdersModel(
      {this.delivered,
      this.images,
      this.title,
      this.orderID,
      this.productID,
      this.reviewed});
}
