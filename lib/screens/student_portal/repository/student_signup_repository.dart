import 'package:rspsa_user/models/student_signup_response.dart';
import 'package:rspsa_user/models/talent_details_response.dart';
import 'package:rspsa_user/models/talent_list_response.dart';
import '../../../models/program_list_response.dart';
import '../../../utils/app_config.dart';
import 'package:http/http.dart' as http;

class StudentSignupRepository {
  Future<TalentResponse> getTalentList() async {
    var headers = {'Accept': 'application/json'};

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/program-categories');
    final response = await http.get(uri, headers: headers);
    return talentResponseFromJson(response.body);
  }

  Future<ProgramListResponse> getProgramList({required String talentId}) async {
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

  Future<StudentSignupResponse?> studentSignup({
    required String talentId,
    required String programId,
    required String talentDetailsId,
    required String name,
    required String fatherName,
    required String email,
    required String mobile,
    required String dob,
    required String password,
    required String address,
    required String aadharNumber,
    required String schoolOrInstitutionName,
    required String schoolOrInstitutionAddress,
    required String appearingClass,
    required String bankName,
    required String accountHolderName,
    required String accountNumber,
    required String ifscCode,
    required String utrNo,
    required String declaration,
    required String termsAndConditions,
    required String registrationFor,
    required String? currentEducationProof,
    required String? photo,
    required String? signature,
    required String? paymentProof,
    required String? aadharCard,
  }) async {
    var body = {
      'talent_id': talentId,
      'program_id': programId,
      'talent_detail_id': talentDetailsId,
      'name': name,
      'father_name': fatherName,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'password': password,
      'password_confirmation': password,
      'address': address,
      'aadhar_number': aadharNumber,
      'school_or_institute_name': schoolOrInstitutionName,
      'school_or_institute_address': schoolOrInstitutionAddress,
      'appearing_class': appearingClass,
      'bank_name': bankName,
      'account_holder_name': accountHolderName,
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'utr_no': utrNo,
      'declaration': declaration,
      'terms_and_conditions': termsAndConditions,
      'registration_for': registrationFor
    };

    var headers = {'Accept': 'application/json'};
    Uri url = Uri.parse("${AppConfig.baseUrl}/api/student/store");
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);

    if (currentEducationProof != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'current_education_proof', currentEducationProof));
    }

    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', photo));
    }
    if (signature != null) {
      request.files
          .add(await http.MultipartFile.fromPath('signature', signature));
    }

    if (paymentProof != null) {
      request.files.add(
          await http.MultipartFile.fromPath('payment_proof', paymentProof));
    }
    if (aadharCard != null) {
      request.files
          .add(await http.MultipartFile.fromPath('aadhar_card', aadharCard));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return studentSignupResponseFromJson(
          await response.stream.bytesToString());
    } else {
      return null;
    }
  }
}
