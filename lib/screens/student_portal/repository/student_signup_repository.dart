import 'package:rspsa_user/models/program_category_list_response.dart';

import '../../../utils/app_config.dart';
import 'package:http/http.dart' as http;

class StudentSignupRepository {
  Future<ProgramCategoryListResponse> getProgramCategoryList() async {
    var headers = {'Accept': 'application/json'};

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/program-talents');
    final response = await http.get(uri, headers: headers);
    return programCategoryListResponseFromJson(response.body);
  }
}
