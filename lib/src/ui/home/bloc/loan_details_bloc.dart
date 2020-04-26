import 'package:indihood/src/data/model/home/loan_data/loan_records_response.dart';
import 'package:indihood/src/data/model/home/loan_data/loan_schema_response.dart';
import 'package:indihood/src/data/model/parsed_response.dart';
import 'package:get_it/get_it.dart';
import 'package:indihood/src/base/ui_event.dart';
import 'package:indihood/src/data/web_services.dart';
import 'package:indihood/src/infra/bloc/bloc_provider.dart';
import 'package:indihood/src/ui/home/bloc/loan_details_screen_events.dart';
import 'package:indihood/src/ui/home/bloc/loan_details_screen_repository.dart';
import 'package:rxdart/rxdart.dart';

class SchemaDetailsBloc extends BaseBloc {

  SchemaDetailsRepository _schemaDetailsRepository;

  SchemaDetailsBloc() {
    _schemaDetailsRepository = SchemaDetailsRepository(GetIt.I<WebServices>());
  }

  BehaviorSubject<UIEvent> _uiEventStreamController = BehaviorSubject();
  Stream<UIEvent> get uiEventStream => _uiEventStreamController.stream;

  BehaviorSubject<LoanRecordsResponse> _loanRecordsStreamController = BehaviorSubject();
  Stream<LoanRecordsResponse> get loanRecordsStream => _loanRecordsStreamController.stream;

  BehaviorSubject<LoanSchemaResponse> _loanSchemaStreamController = BehaviorSubject();
  Stream<LoanSchemaResponse> get loanSchemaStream => _loanSchemaStreamController.stream;


   void getLoanRecords() async {
      _uiEventStreamController.add(LoadingScreenUiEvent(true));
      ParsedResponse<LoanRecordsResponse> loanRecordsResponse = await _schemaDetailsRepository.fetchLoanRecordsData();
      //also get schema data
      getLoanSchemas();
      _uiEventStreamController.add(LoadingScreenUiEvent(false));
      if(loanRecordsResponse.hasData) {
        _loanRecordsStreamController.add(loanRecordsResponse.data);
      } else {
        _uiEventStreamController.add(SnackBarEvent(loanRecordsResponse.error.message));
      }
    }

   void getLoanSchemas() async {
    ParsedResponse<LoanSchemaResponse> loanRecordsResponse = await _schemaDetailsRepository.fetchLoanSchemaData();
    if(loanRecordsResponse.hasData) {
      _loanSchemaStreamController.add(loanRecordsResponse.data);
    } else {
      _uiEventStreamController.add(SnackBarEvent(loanRecordsResponse.error.message));
    }
  }




  @override
  void onDispose() {
    _uiEventStreamController.close();
    _loanRecordsStreamController.close();
    _loanSchemaStreamController.close();
  }

}