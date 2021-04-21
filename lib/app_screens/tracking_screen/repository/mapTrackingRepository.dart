
import 'package:desichatkara/app_screens/tracking_screen/model/mapTrackingModel.dart';
import 'package:desichatkara/app_screens/tracking_screen/model/mapTrackingPickDropModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class MapTrackingRepository{
  ApiBaseHelper _apiBaseHelper = new ApiBaseHelper();

  Future<MapTrackingModel> mapTracking(String id, String token) async{
    // Map body={};
    final response= await _apiBaseHelper.getWithHeader("carrier/$id/location","Bearer $token");
    return MapTrackingModel.fromJson(response);
  }

  Future<MapTrackingPickDropModel> mapTrackingforPickUp(carrierId,token) async{
    // Map body={};
    final response= await _apiBaseHelper.getWithHeader("carrier/$carrierId/location","Bearer $token");
    return MapTrackingPickDropModel.fromJson(response);
  }
}