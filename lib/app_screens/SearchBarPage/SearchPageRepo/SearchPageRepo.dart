
import 'package:desichatkara/app_screens/SearchBarPage/SearchPageModel/SearchPageModel.dart';

import '../../../helper/api_base_helper.dart';

class SearchPageRepository{
  ApiBaseHelper _apiBaseHelper = new ApiBaseHelper();

  Future<SearchPageModel> search(Map body) async{
    final response= await _apiBaseHelper.post("product/search", body);
    return SearchPageModel.fromJson(response);
  }
}