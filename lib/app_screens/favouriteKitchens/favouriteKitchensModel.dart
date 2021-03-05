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
  String preparationTime;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String isActive;
  String isOutOfStock;
  Vendor vendor;
  Image image;
  List<SkuVariant> skuVariant;
  Product product;

  Sku(
      {this.id,
        this.productId,
        this.sku,
        this.productIdentification,
        this.price,
        this.skuName,
        this.isVeg,
        this.vendorId,
        this.preparationTime,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isActive,
        this.isOutOfStock,
        this.vendor,
        this.image,
        this.skuVariant,
        this.product});

  Sku.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    sku = json['sku'];
    productIdentification = json['product_identification'];
    price = json['price'];
    skuName = json['sku_name'];
    isVeg = json['is_veg'];
    vendorId = json['vendor_id'];
    preparationTime = json['preparation_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isActive = json['is_active'];
    isOutOfStock = json['is_out_of_stock'];
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    if (json['sku_variant'] != null) {
      skuVariant = new List<SkuVariant>();
      json['sku_variant'].forEach((v) {
        skuVariant.add(new SkuVariant.fromJson(v));
      });
    }
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
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
    data['preparation_time'] = this.preparationTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_active'] = this.isActive;
    data['is_out_of_stock'] = this.isOutOfStock;
    if (this.vendor != null) {
      data['vendor'] = this.vendor.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.skuVariant != null) {
      data['sku_variant'] = this.skuVariant.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Vendor {
  int id;
  String shopName;
  String mobileNumber;
  String mobileVerifiedFlag;
  String mobileVerifiedToken;
  Null mobileVerifiedAt;
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
  Null parentId;

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
        this.parentId});

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

class Product {
  int id;
  String name;
  String categoryId;
  Null manufacturerId;
  String productImage;
  String createdAt;
  String updatedAt;
  String isActive;
  Category category;

  Product(
      {this.id,
        this.name,
        this.categoryId,
        this.manufacturerId,
        this.productImage,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    manufacturerId = json['manufacturer_id'];
    productImage = json['product_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['manufacturer_id'] = this.manufacturerId;
    data['product_image'] = this.productImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String position;
  String status;
  String parentId;
  String createdAt;
  String updatedAt;
  Null remark;
  CategoryDetails categoryDetails;

  Category(
      {this.id,
        this.position,
        this.status,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.remark,
        this.categoryDetails});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    status = json['status'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    remark = json['remark'];
    categoryDetails = json['category_details'] != null
        ? new CategoryDetails.fromJson(json['category_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
    data['status'] = this.status;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['remark'] = this.remark;
    if (this.categoryDetails != null) {
      data['category_details'] = this.categoryDetails.toJson();
    }
    return data;
  }
}

class CategoryDetails {
  int id;
  String name;
  String categoryImage;
  String slug;
  String description;
  String metaTitle;
  String metaDescription;
  String metaKeywords;
  String categoryId;
  String createdAt;
  String updatedAt;

  CategoryDetails(
      {this.id,
        this.name,
        this.categoryImage,
        this.slug,
        this.description,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.categoryId,
        this.createdAt,
        this.updatedAt});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryImage = json['category_image'];
    slug = json['slug'];
    description = json['description'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_image'] = this.categoryImage;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
