class FoodDetailsModel {
  Data data;
  int status;

  FoodDetailsModel({this.data, this.status});

  FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<Menu> menu;
  List<CartItems> cartItems;
  String cartItemCount;
  List<ProductDetails> productDetails;

  Data({this.menu, this.cartItems, this.cartItemCount, this.productDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = new List<Menu>();
      json['menu'].forEach((v) {
        menu.add(new Menu.fromJson(v));
      });
    }
    if (json['cart_items'] != null) {
      cartItems = new List<CartItems>();
      json['cart_items'].forEach((v) {
        cartItems.add(new CartItems.fromJson(v));
      });
    }
    cartItemCount = json['cart_item_count'];
    if (json['product_details'] != null) {
      productDetails = new List<ProductDetails>();
      json['product_details'].forEach((v) {
        productDetails.add(new ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menu != null) {
      data['menu'] = this.menu.map((v) => v.toJson()).toList();
    }
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems.map((v) => v.toJson()).toList();
    }
    data['cart_item_count'] = this.cartItemCount;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String categoryname;
  String id;
  List<Subcategory> subcategory;

  Menu({this.categoryname, this.id, this.subcategory});

  Menu.fromJson(Map<String, dynamic> json) {
    categoryname = json['categoryname'];
    id = json['id'];
    if (json['subcategory'] != null) {
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryname'] = this.categoryname;
    data['id'] = this.id;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  String subcategoryname;
  String id;

  Subcategory({this.subcategoryname, this.id});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subcategoryname = json['subcategoryname'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategoryname'] = this.subcategoryname;
    data['id'] = this.id;
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
    data['totalprice'] = this.totalprice;
    data['detailed_product_images'] = this.detailedProductImages;
    data['product_description'] = this.productDescription;
    return data;
  }
}

class ProductDetails {
  int id;
  String name;
  String categoryId;
  String manufacturerId;
  String productImage;
  String createdAt;
  String updatedAt;
  String isActive;
  List<Skus> skus;

  ProductDetails(
      {this.id,
        this.name,
        this.categoryId,
        this.manufacturerId,
        this.productImage,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.skus});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    manufacturerId = json['manufacturer_id'];
    productImage = json['product_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    if (json['skus'] != null) {
      skus = new List<Skus>();
      json['skus'].forEach((v) {
        skus.add(new Skus.fromJson(v));
      });
    }
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
    if (this.skus != null) {
      data['skus'] = this.skus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skus {
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
  Wishlist wishlist;
  CartItem cartItem;

  Skus(
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
        this.wishlist,
        this.cartItem});

  Skus.fromJson(Map<String, dynamic> json) {
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
    wishlist = json['wishlist'] != null
        ? new Wishlist.fromJson(json['wishlist'])
        : null;
    cartItem = json['cart_item'] != null
        ? new CartItem.fromJson(json['cart_item'])
        : null;
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
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist.toJson();
    }
    if (this.cartItem != null) {
      data['cart_item'] = this.cartItem.toJson();
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

class Wishlist {
  int id;
  String userId;
  String skuId;
  String createdAt;
  String updatedAt;

  Wishlist({this.id, this.userId, this.skuId, this.createdAt, this.updatedAt});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    skuId = json['sku_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sku_id'] = this.skuId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CartItem {
  int cartItemId;
  String cartId;
  String skuId;
  String quantity;
  String createdAt;
  String updatedAt;

  CartItem(
      {this.cartItemId,
        this.cartId,
        this.skuId,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  CartItem.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cart_item_id'];
    cartId = json['cart_id'];
    skuId = json['sku_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_item_id'] = this.cartItemId;
    data['cart_id'] = this.cartId;
    data['sku_id'] = this.skuId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
