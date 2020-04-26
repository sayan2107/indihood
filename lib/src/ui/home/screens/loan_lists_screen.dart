import 'package:indihood/generated/i18n.dart';
import 'package:indihood/src/data/model/home/loan_data/loan_records_response.dart';
import 'package:indihood/src/ui/home/bloc/loan_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:indihood/src/base/ui_event.dart';
import 'package:indihood/src/infra/bloc/bloc_provider.dart';
import 'package:indihood/src/infra/bloc/event_listener.dart';
import 'package:indihood/src/ui/common/widgets/widget_mixin.dart';
import 'package:indihood/src/ui/home/widgets/loan_list_item_widget.dart';
import 'package:indihood/src/utility/color_constants.dart';

class LoanListsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/loan_lists_screen_route";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: SchemaDetailsBloc(),
      child: _LoanListsScreenInternal(),
    );
  }
}

class _LoanListsScreenInternal extends StatefulWidget {

  _LoanListsScreenInternal();

  @override
  _LoanListsScreenState createState() =>
      _LoanListsScreenState();
}

class _LoanListsScreenState extends State<_LoanListsScreenInternal> with CommonWidget{
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //Fetch all data from the network
    BlocProvider.of<SchemaDetailsBloc>(context).getLoanRecords();
    return EventListener(
      BlocProvider
          .of<SchemaDetailsBloc>(context)
          .uiEventStream,
      handleEvent,
      child: Scaffold(
          key: _scafoldKey,
          backgroundColor: ColorConstants.details_page_background_color,
          appBar: AppBar(
            title: Center(child: Text(S.of(context).text_loan_list)),
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//            onPressed: () => Navigator.pop(context),
//          ),
          ),
          body: StreamBuilder<LoanRecordsResponse>(
            stream: BlocProvider
                .of<SchemaDetailsBloc>(context)
                .loanRecordsStream,
            builder:(BuildContext context, AsyncSnapshot<LoanRecordsResponse> snapshot)  {
              if(snapshot.hasError){
                return Container(
                    child: Text(S.of(context).text_something_went_wrong, style: TextStyle(color: Colors.red),)
                );
              }
              List<Loan1> musicLists = List<Loan1>();
              musicLists.add(snapshot.data.loan1);
              if(musicLists?.length==0){
                return Container(child: Text(S.of(context).text_nothing_found));
              }
              return ListView.builder(
                  itemCount: musicLists?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MusicListItemWidget(musicLists[index]);
                  });
            },
          )
      ),
    );
  }




  void handleEvent(UIEvent uiEvent) {
    if (uiEvent != null) {
      if (uiEvent is SnackBarEvent) {
        SnackBarEvent sbe = uiEvent;
        _scafoldKey.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          content: Text(sbe.message),
        ));
      }else if(uiEvent is LoadingScreenUiEvent) {
        LoadingScreenUiEvent loading = uiEvent;
        if(loading.isVisible) {
          showLoader(context);
        }else {
          hideLoader(context);
        }
      }
    }
  }

}
