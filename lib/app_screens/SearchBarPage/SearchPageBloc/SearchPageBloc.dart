import 'dart:async';

import 'package:desichatkara/app_screens/SearchBarPage/SearchPageModel/SearchPageModel.dart';
import 'package:desichatkara/app_screens/SearchBarPage/SearchPageRepo/SearchPageRepo.dart';

import '../../../helper/api_response.dart';


class SearchPageBloc {

  SearchPageRepository _searchPageRepository;

  StreamController _controller;

  StreamSink<ApiResponse<SearchPageModel>> get searchPageSink =>
      _controller.sink;

  Stream<ApiResponse<SearchPageModel>> get searchPageStream =>
      _controller.stream;


  SearchPageBloc() {
    _controller = StreamController<ApiResponse<SearchPageModel>>.broadcast();
    _searchPageRepository = SearchPageRepository();
  }

  search(Map body) async {
    searchPageSink.add(ApiResponse.loading("Submitting",));
    try {
      SearchPageModel response = await _searchPageRepository.search(body);
      searchPageSink.add(ApiResponse.completed(response));
    } catch (e) {
      searchPageSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _controller?.close();
    searchPageSink?.close();
  }
}