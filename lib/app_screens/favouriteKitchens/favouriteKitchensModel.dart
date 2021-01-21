class FavoritekitchensModel {
  bool success;
  List<Data> data;
  String message;

  FavoritekitchensModel({this.success, this.data, this.message});

  FavoritekitchensModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String userId;
  String skuId;
  String createdAt;
  String updatedAt;
  Sku sku;

  Data(
      {this.id,
        this.userId,
        this.skuId,
        this.createdAt,
        this.updatedAt,
        this.sku});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    skuId = json['sku_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sku = json['sku'] != null ? new Sku.fromJson(json['sku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sku_id'] = this.skuId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sku != null) {
      data['sku'] = this.sku.toJson();
    }
    return data;
  }
}

class Sku {
  int id;
  String productId;
  String sku;
  String productIdentification;
  String price;
  String skuName;
  String isVeg;
  String vendorId;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String isActive;
  Vendor vendor;
  Image image;
  List<SkuVariant> skuVariant;

  Sku(
      {this.id,
        this.productId,
        this.sku,
        this.productIdentification,
        this.price,
        this.skuName,
        this.isVeg,
        this.vendorId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isActive,
        this.vendor,
        this.image,
        this.skuVariant});

  Sku.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    sku = json['sku'];
    productIdentification = json['product_identification'];
    price = json['price'];
    skuName = json['sku_name'];
    isVeg = json['is_veg'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isActive = json['is_active'];
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    if (json['sku_variant'] != null) {
      skuVariant = new List<SkuVariant>();
      json['sku_variant'].forEach((v) {
        skuVariant.add(new SkuVariant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['sku'] = this.sku;
    data['product_identification'] = this.productIdentification;
    data['price'] = this.price;
    data['sku_name'] = this.skuName;
    data['is_veg'] = this.isVeg;
    data['vendor_id'] = this.vendorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_active'] = this.isActive;
    if (this.vendor != null) {
      data['vendor'] = this.vendor.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.skuVariant != null) {
      data['sku_variant'] = this.skuVariant.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  int id;
  String shopName;
  String address;
  String city;
  String state;
  String zip;
  String vendorImage;

  Vendor(
      {this.id,
        this.shopName,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.vendorImage});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    vendorImage = json['vendor_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_name'] = this.shopName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['vendor_image'] = this.vendorImage;
    return data;
  }
}

class Image {
  int id;
  String skuId;
  String productImages;
  String position;
  String createdAt;
  String updatedAt;

  Image(
      {this.id,
        this.skuId,
        this.productImages,
        this.position,
        this.createdAt,
        this.updatedAt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuId = json['sku_id'];
    productImages = json['product_images'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku_id'] = this.skuId;
    data['product_images'] = this.productImages;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SkuVariant {
  String skuId;
  String productVariantId;
  String productVariantOptionsId;
  String createdAt;
  String updatedAt;
  ProductVariant productVariant;
  ProductVariantOption productVariantOption;

  SkuVariant(
      {this.skuId,
        this.productVariantId,
        this.productVariantOptionsId,
        this.createdAt,
        this.updatedAt,
        this.productVariant,
        this.productVariantOption});

  SkuVariant.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
    productVariantId = json['product_variant_id'];
    productVariantOptionsId = json['product_variant_options_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productVariant = json['product_variant'] != null
        ? new ProductVariant.fromJson(json['product_variant'])
        : null;
    productVariantOption = json['product_variant_option'] != null
        ? new ProductVariantOption.fromJson(json['product_variant_option'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    data['product_variant_id'] = this.productVariantId;
    data['product_variant_options_id'] = this.productVariantOptionsId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productVariant != null) {
      data['product_variant'] = this.productVariant.toJson();
    }
    if (this.productVariantOption != null) {
      data['product_variant_option'] = this.productVariantOption.toJson();
    }
    return data;
  }
}

class ProductVariant {
  int id;
  String productId;
  String name;
  String createdAt;
  String updatedAt;

  ProductVariant(
      {this.id, this.productId, this.name, this.createdAt, this.updatedAt});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductVariantOption {
  int id;
  String productVariantId;
  String name;
  String createdAt;
  String updatedAt;

  ProductVariantOption(
      {this.id,
        this.productVariantId,
        this.name,
        this.createdAt,
        this.updatedAt});

  ProductVariantOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productVariantId = json['product_variant_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_variant_id'] = this.productVariantId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
