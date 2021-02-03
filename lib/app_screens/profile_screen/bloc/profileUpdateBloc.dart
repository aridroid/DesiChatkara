import 'dart:async';
import 'dart:io';

import 'package:desichatkara/app_screens/profile_screen/model/profileUpdateModel.dart';
import 'package:desichatkara/app_screens/profile_screen/repository/profileRepository.dart';
import 'package:desichatkara/helper/api_response.dart';

class ProfileUpdateBloc {

  ProfileRepository _profileRepository;

  StreamController _profileUpdateController;

  StreamSink<ApiResponse<ProfileUpdateModel>> get profileUpdateSink =>
      _profileUpdateController.sink;

  Stream<ApiResponse<ProfileUpdateModel>> get profileUpdateStream =>
      _profileUpdateController.stream;


  ProfileUpdateBloc() {
    _profileUpdateController = StreamController<ApiResponse<ProfileUpdateModel>>.broadcast();
    _profileRepository = ProfileRepository();
  }

  profileUpdate(Map body, File imageFile1, String token) async {
    profileUpdateSink.add(ApiResponse.loading("Submitting",));
    try {
      ProfileUpdateModel response = await _profileRepository.profileUpdate(body, imageFile1, token);
      profileUpdateSink.add(ApiResponse.completed(response));
    } catch (e) {
      profileUpdateSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _profileUpdateController?.close();
    profileUpdateSink?.close();
  }
}