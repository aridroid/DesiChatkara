import 'package:desichatkara/app_screens/Home/model/AllCategoryModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class AllCategoryRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AllCategoryResponseModel> getAllCategory() async {

    Map body={

    };
    final response = await _helper.post("categories",body);
    return AllCategoryResponseModel.fromJson(response);
  }
}