class SearchPageModel {
  List<Data> data;
  String message;
  int status;

  SearchPageModel({this.data, this.message, this.status});

  SearchPageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String skuId;
  String sku;
  String skuName;
  String productIdentification;
  String productImage;
  String manufacturerName;
  String price;
  String productId;
  String productName;
  String detailedProductImages;
  String productDescription;
  List<Vendor> vendor;

  Data(
      {this.skuId,
        this.sku,
        this.skuName,
        this.productIdentification,
        this.productImage,
        this.manufacturerName,
        this.price,
        this.productId,
        this.productName,
        this.detailedProductImages,
        this.productDescription,
        this.vendor});

  Data.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
    sku = json['sku'];
    skuName = json['sku_name'];
    productIdentification = json['product_identification'];
    productImage = json['product_image'];
    manufacturerName = json['manufacturer_name'];
    price = json['price'];
    productId = json['product_id'];
    productName = json['product_name'];
    detailedProductImages = json['detailed_product_images'];
    productDescription = json['product_description'];
    if (json['vendor'] != null) {
      vendor = new List<Vendor>();
      json['vendor'].forEach((v) {
        vendor.add(new Vendor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    data['sku'] = this.sku;
    data['sku_name'] = this.skuName;
    data['product_identification'] = this.productIdentification;
    data['product_image'] = this.productImage;
    data['manufacturer_name'] = this.manufacturerName;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['detailed_product_images'] = this.detailedProductImages;
    data['product_description'] = this.productDescription;
    if (this.vendor != null) {
      data['vendor'] = this.vendor.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  String id;
  String shopName;
  String mobileNumber;
  String mobileVerifiedFlag;
  String mobileVerifiedToken;
  String mobileVerifiedAt;
  String address;
  String city;
  String state;
  String zip;
  String longitude;
  String latitude;
  String vendorImage;
  String categoryId;
  String createdAt;
  String updatedAt;
  String availableFrom;
  String availableTo;
  String isActive;
  String parentId;
  String vendorId;

  Vendor(
      {this.id,
        this.shopName,
        this.mobileNumber,
        this.mobileVerifiedFlag,
        this.mobileVerifiedToken,
        this.mobileVerifiedAt,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.longitude,
        this.latitude,
        this.vendorImage,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.availableFrom,
        this.availableTo,
        this.isActive,
        this.parentId,
        this.vendorId});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    mobileNumber = json['mobile_number'];
    mobileVerifiedFlag = json['mobile_verified_flag'];
    mobileVerifiedToken = json['mobile_verified_token'];
    mobileVerifiedAt = json['mobile_verified_at'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    vendorImage = json['vendor_image'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    availableFrom = json['available_from'];
    availableTo = json['available_to'];
    isActive = json['is_active'];
    parentId = json['parent_id'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_name'] = this.shopName;
    data['mobile_number'] = this.mobileNumber;
    data['mobile_verified_flag'] = this.mobileVerifiedFlag;
    data['mobile_verified_token'] = this.mobileVerifiedToken;
    data['mobile_verified_at'] = this.mobileVerifiedAt;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['vendor_image'] = this.vendorImage;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['available_from'] = this.availableFrom;
    data['available_to'] = this.availableTo;
    data['is_active'] = this.isActive;
    data['parent_id'] = this.parentId;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}
