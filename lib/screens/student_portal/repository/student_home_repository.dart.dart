import '../../../models/program_list_response.dart';
import '../../../models/talent_details_response.dart';
import '../../../utils/app_config.dart';
import 'package:http/http.dart' as http;

class StudentHomeRepository {
  Future<ProgramListResponse> getProgramList() async {
    var headers = {'Accept': 'application/json'};

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/programs');
    final response = await http.get(uri, headers: headers);
    return programListResponseFromJson(response.body);
  }

  Future<ProgramListResponse> getMyProgramList(
      {required String talentId}) async {
    var headers = {'Accept': 'application/json'};

    Uri uri =
        Uri.parse('${AppConfig.baseUrl}/api/programs?talent_id=$talentId');
    final response = await http.get(uri, headers: headers);
    return programListResponseFromJson(response.body);
  }

  Future<TalentDetailsResponse> getTalentDetailsList(
      {required String talentId}) async {
    var headers = {
      'Accept': 'application/json',
    };

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/category-details/$talentId');
    final response = await http.get(uri, headers: headers);
    return talentDetailsResponseFromJson(response.body);
  }
}
