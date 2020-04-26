import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indihood/src/data/model/home/loan_data/loan_records_response.dart';
import 'package:indihood/src/infra/bloc/bloc_provider.dart';
import 'package:indihood/src/ui/home/bloc/loan_details_bloc.dart';
import 'package:indihood/src/utility/color_constants.dart';

class SchemaDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/loan_details_screen_route";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: SchemaDetailsBloc(),
      child: _MusicDetailsScreenInternal(),
    );
  }
}


class _MusicDetailsScreenInternal extends StatefulWidget {

  @override
  _MusicDetailsScreenState createState() =>
      _MusicDetailsScreenState();
}

class _MusicDetailsScreenState extends State<_MusicDetailsScreenInternal> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SchemaDetailsBloc>(context).getLoanRecords();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoanRecordsResponse>(
      stream:   BlocProvider.of<SchemaDetailsBloc>(context).loanRecordsStream,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return SizedBox();
        }
        if(snapshot.hasError) {
          return Center(child: Text("Something went wrong"),);
        }
        Loan1 loanData = snapshot.data.loan1;
        return Scaffold(
          backgroundColor: ColorConstants.details_page_background_color,
          appBar: AppBar(
            centerTitle: true,
            title:  Text(loanData.title, style: TextStyle(fontSize: 16),),
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//            onPressed: () => Navigator.pop(context),
//          ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        "https://lh3.googleusercontent.com/4jdIr7IAp3DVx_Ss_JKAc4aKuWo5KRMUNGkhP-J60kvQ6R-zR1Tt9LbPhVASEO3iasx2X9SgmGZzmk1SDPE7vSz9hMLT",
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 270,
                       // color: Colors.black12,
                        padding: EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                               // right: 24,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        child: GoogleMap(
                                          mapType: MapType.normal,
                                          zoomControlsEnabled: false,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(loanData.borrowerLocation.lat, loanData.borrowerLocation.lng),
                                            zoom: 14,
                                          )),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                                            color: Colors.white,
                                            boxShadow: [BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1.0,
                                            ),]
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width - 110,
                                            child: Text(
                                                loanData?.image?.label,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width - 130,
                                            child: Text(
                                              loanData?.borrowerLocation?.address,
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                height: 1,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                        ),]
                    ),

                    margin: EdgeInsets.only(top:10, left: 10, right: 10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "Application Details",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          height: 100,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0,
                              crossAxisCount: 2,
                              children: <Widget>[
                                titleSubTitleWidget("Name", loanData?.applicantDetails?.name),
                                SizedBox(height: 0,),
                                titleSubTitleWidget("Date Of Birth",  loanData?.applicantDetails?.dateOfBirth),
                                titleSubTitleWidget("Phone Number", loanData?.applicantDetails?.phoneNumber[0]),
                              ]),),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                                child: Text(
                                    "See More".toUpperCase(),
                                  style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              onTap: (){},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                        ),]
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Loan Terms",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                      SizedBox(
                        height: 100,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 0,
                          crossAxisCount: 2,
                          children: <Widget>[
                            titleSubTitleWidget("Duration", loanData?.loanTerms?.duration),
                            titleSubTitleWidget("Interest rate", loanData?.loanTerms?.interestRate),
                            titleSubTitleWidget("Loan Amount", loanData?.loanTerms?.loanAmount.toString()),
                            titleSubTitleWidget("Loan product", loanData?.loanTerms?.loanProduct.toString()),
                          ]),),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                        ),]
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Repayment Schedule",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          height: 150,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: 3,
                              crossAxisSpacing: 20,
                              crossAxisCount: 2,
                              children:
//                              loanData.repaymentSchedule.map((item){
//                                return titleSubTitleWidget("Date", item.date);
//                              //  titleSubTitleWidget("Amount", item.amount.toString());
//                              }).toList()
                              <Widget>[
                                titleSubTitleWidget("Date", loanData.repaymentSchedule[0].date),
                                titleSubTitleWidget("Amount", loanData.repaymentSchedule[0].amount.toString()),
                                titleSubTitleWidget("Date",loanData.repaymentSchedule[1].date),
                                titleSubTitleWidget("Amount", loanData.repaymentSchedule[1].amount.toString()),
                                titleSubTitleWidget("Date", loanData.repaymentSchedule[2].date),
                                titleSubTitleWidget("Amount", loanData.repaymentSchedule[2].amount.toString()),
                              ]
                          ),),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                "See Full Schedule".toUpperCase(),
                                style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                              onTap: (){},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget titleSubTitleWidget(String title, String subtitle) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 12, color: ColorConstants.details_page_sub_text_color),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: ColorConstants.details_page_text_color, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
  }
