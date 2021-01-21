class FavoriteAddModel {
  bool success;
  Data data;
  String message;

  FavoriteAddModel({this.success, this.data, this.message});

  FavoriteAddModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int skuId;

  Data({this.skuId});

  Data.fromJson(Map<String, dynamic> json) {
    skuId = json['sku_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.skuId;
    return data;
  }
}
