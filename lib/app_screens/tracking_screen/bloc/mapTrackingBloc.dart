import 'dart:async';

import 'package:desichatkara/app_screens/tracking_screen/model/mapTrackingModel.dart';
import 'package:desichatkara/app_screens/tracking_screen/repository/mapTrackingRepository.dart';
import 'package:desichatkara/helper/api_response.dart';



class MapTrackingBloc {

  MapTrackingRepository _mapTrackingRepository;

  StreamController _mapTrackingController;

  StreamSink<ApiResponse<MapTrackingModel>> get mapTrackingSink =>
      _mapTrackingController.sink;

  Stream<ApiResponse<MapTrackingModel>> get mapTrackingStream =>
      _mapTrackingController.stream;


  MapTrackingBloc() {
    _mapTrackingController = StreamController<ApiResponse<MapTrackingModel>>.broadcast();
    _mapTrackingRepository = MapTrackingRepository();
  }

  mapTracking(String id, String token) async {
    mapTrackingSink.add(ApiResponse.loading("Submitting",));
    try {
      MapTrackingModel response = await _mapTrackingRepository.mapTracking(id, token);
      mapTrackingSink.add(ApiResponse.completed(response));
    } catch (e) {
      mapTrackingSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _mapTrackingController?.close();
    mapTrackingSink?.close();
  }
}