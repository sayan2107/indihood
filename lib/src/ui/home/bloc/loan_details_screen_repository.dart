import 'package:dio/dio.dart';
import 'package:indihood/src/base/base_repository.dart';
import 'package:indihood/src/data/model/home/loan_data/loan_records_response.dart';
import 'package:indihood/src/data/model/home/loan_data/loan_schema_response.dart';
import 'package:indihood/src/data/model/parsed_response.dart';
import 'package:indihood/src/data/web_services.dart';
import 'package:indihood/src/utility/url_constants.dart';

class SchemaDetailsRepository extends BaseRepository {
  WebServices _webServices;

  SchemaDetailsRepository(this._webServices);

  Future<ParsedResponse<LoanRecordsResponse>> fetchLoanRecordsData() async {
    try {
      Response response = await _webServices.doGetApiCall(UrlConstants.loan_records_data);
      if(response != null && response.statusCode == BaseRepository.HTTP_OK) {
        return ParsedResponse.addData(LoanRecordsResponse.fromJson(response.data));
      } else {
        return Future.value(ParsedResponse.addError(handleHttpErrorResponse(response)));
      }
    } on DioError catch(e) {
      return Future.value(ParsedResponse.addError(handleDioError(e)));
    }
  }

  Future<ParsedResponse<LoanSchemaResponse>> fetchLoanSchemaData() async {
    try {
      Response response = await _webServices.doGetApiCall(UrlConstants.loan_schema_data);
      if(response != null && response.statusCode == BaseRepository.HTTP_OK) {
        return ParsedResponse.addData(LoanSchemaResponse.fromJson(response.data));
      } else {
        return Future.value(ParsedResponse.addError(handleHttpErrorResponse(response)));
      }
    } on DioError catch(e) {
      return Future.value(ParsedResponse.addError(handleDioError(e)));
    }
  }

}