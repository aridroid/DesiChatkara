import 'dart:async';

import '../../helper/api_response.dart';
import 'FavDeleteModel.dart';
import 'FavDeleteRepositry.dart';

class FavoriteDeleteBloc {
  FavoriteDeleteRepository _favoriteDeleteRepository;

  StreamController _favoriteDeleteController;

  StreamSink<ApiResponse<FavDeleteModel>> get favoriteDeleteSink =>
      _favoriteDeleteController.sink;

  Stream<ApiResponse<FavDeleteModel>> get favoriteDeleteStream =>
      _favoriteDeleteController.stream;

  FavoriteDeleteBloc() {
    _favoriteDeleteController = StreamController<ApiResponse<FavDeleteModel>>.broadcast();
    _favoriteDeleteRepository = FavoriteDeleteRepository();

  }

  favoriteDelete(String id,String token) async {
    //print("body");
    favoriteDeleteSink.add(ApiResponse.loading('Submitting'));
    try {
      FavDeleteModel favdeleteModel = await _favoriteDeleteRepository.favoritedelete(id,token);
      favoriteDeleteSink.add(ApiResponse.completed(favdeleteModel));
    } catch (e) {
      favoriteDeleteSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _favoriteDeleteController?.close();
    favoriteDeleteSink.close();
  }
}