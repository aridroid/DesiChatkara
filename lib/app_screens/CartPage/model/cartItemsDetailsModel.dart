


class CartItemsDetailsModel {
  Data data;
  String message;
  int status;

  CartItemsDetailsModel({this.data, this.message, this.status});

  CartItemsDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<CartItems> cartItems;
  String cartItemCount;
  String cartTotalAmount;
  String taxAmount;
  String totalIncludingTax;
  String deliveryFee;
  String totalIncludingTaxDelivery;
  String totalAfterDiscount;

  Data(
      {this.cartItems,
        this.cartItemCount,
        this.cartTotalAmount,
        this.taxAmount,
        this.totalIncludingTax,
        this.deliveryFee,
        this.totalIncludingTaxDelivery,
        this.totalAfterDiscount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = new List<CartItems>();
      json['cart_items'].forEach((v) {
        cartItems.add(new CartItems.fromJson(v));
      });
    }
    cartItemCount = json['cart_item_count'];
    cartTotalAmount = json['cart_total_amount'];
    taxAmount = json['tax_amount'];
    totalIncludingTax = json['total_including_tax'];
    deliveryFee = json['delivery_fee'];
    totalIncludingTaxDelivery = json['total_including_tax_delivery'];
    totalAfterDiscount = json['total_after_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems.map((v) => v.toJson()).toList();
    }
    data['cart_item_count'] = this.cartItemCount;
    data['cart_total_amount'] = this.cartTotalAmount;
    data['tax_amount'] = this.taxAmount;
    data['total_including_tax'] = this.totalIncludingTax;
    data['delivery_fee'] = this.deliveryFee;
    data['total_including_tax_delivery'] = this.totalIncludingTaxDelivery;
    data['total_after_discount'] = this.totalAfterDiscount;
    return data;
  }
}

class CartItems {
  String cartItemId;
  String cartId;
  String skuId;
  String productId;
  String quantity;
  String skuName;
  String preparationTime;
  String isOutOfStock;
  String unitPrice;
  String productIdentification;
  String productName;
  String productImage;
  String shopName;
  String availableTo;
  String availableFrom;
  String vendorImage;
  String latitude;
  String longitude;
  String totalprice;
  String detailedProductImages;
  String productDescription;

  CartItems(
      {this.cartItemId,
        this.cartId,
        this.skuId,
        this.productId,
        this.quantity,
        this.skuName,
        this.preparationTime,
        this.isOutOfStock,
        this.unitPrice,
        this.productIdentification,
        this.productName,
        this.productImage,
        this.shopName,
        this.availableTo,
        this.availableFrom,
        this.vendorImage,
        this.latitude,
        this.longitude,
        this.totalprice,
        this.detailedProductImages,
        this.productDescription});

  CartItems.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cart_item_id'];
    cartId = json['cart_id'];
    skuId = json['sku_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    skuName = json['sku_name'];
    preparationTime = json['preparation_time'];
    isOutOfStock = json['is_out_of_stock'];
    unitPrice = json['unit_price'];
    productIdentification = json['product_identification'];
    productName = json['product_name'];
    productImage = json['product_image'];
    shopName = json['shop_name'];
    availableTo = json['available_to'];
    availableFrom = json['available_from'];
    vendorImage = json['vendor_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    totalprice = json['totalprice'];
    detailedProductImages = json['detailed_product_images'];
    productDescription = json['product_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_item_id'] = this.cartItemId;
    data['cart_id'] = this.cartId;
    data['sku_id'] = this.skuId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['sku_name'] = this.skuName;
    data['preparation_time'] = this.preparationTime;
    data['is_out_of_stock'] = this.isOutOfStock;
    data['unit_price'] = this.unitPrice;
    data['product_identification'] = this.productIdentification;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['shop_name'] = this.shopName;
    data['available_to'] = this.availableTo;
    data['available_from'] = this.availableFrom;
    data['vendor_image'] = this.vendorImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['totalprice'] = this.totalprice;
    data['detailed_product_images'] = this.detailedProductImages;
    data['product_description'] = this.productDescription;
    return data;
  }
}


