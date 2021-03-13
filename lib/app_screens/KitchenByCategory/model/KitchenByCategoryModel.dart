class KitchenByCategoryResponseModel {
  List<Data> data;
  String message;
  int code;

  KitchenByCategoryResponseModel({this.data, this.message, this.code});

  KitchenByCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String productName;
  String productImage;
  String manufacturerName;
  String categoryName;
  String productId;
  String categoryId;
  String manufacturerId;
  String parentCategoryId;
  List<Vendor> vendor;

  Data(
      {this.productName,
        this.productImage,
        this.manufacturerName,
        this.categoryName,
        this.productId,
        this.categoryId,
        this.manufacturerId,
        this.parentCategoryId,
        this.vendor});

  Data.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productImage = json['product_image'];
    manufacturerName = json['manufacturer_name'];
    categoryName = json['category_name'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    manufacturerId = json['manufacturer_id'];
    parentCategoryId = json['parent_category_id'];
    if (json['vendor'] != null) {
      vendor = new List<Vendor>();
      json['vendor'].forEach((v) {
        vendor.add(new Vendor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['manufacturer_name'] = this.manufacturerName;
    data['category_name'] = this.categoryName;
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    data['manufacturer_id'] = this.manufacturerId;
    data['parent_category_id'] = this.parentCategoryId;
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
