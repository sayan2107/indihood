import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indihood/src/data/model/home/loan_data/loan_records_response.dart';
import 'package:indihood/src/ui/home/screens/loan_details_screen.dart';
import 'package:indihood/src/utility/asset_constants.dart';
import 'package:indihood/src/utility/color_constants.dart';

class MusicListItemWidget extends StatelessWidget {
  final Loan1 _loanItemData;
  MusicListItemWidget(this._loanItemData);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(SchemaDetailsScreen.ROUTE_NAME, arguments: _loanItemData);
        },
        child: Container(
          height: 150,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                        ),],
                        border: Border.all(
                            width: 1,
                            color: ColorConstants.input_bg_color_dark)),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 118.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _loanItemData?.title.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Name: " + _loanItemData?.applicantDetails.name,
                            style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Contact: " + _loanItemData?.applicantDetails.phoneNumber[0],
                            style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Loan Amount: " + _loanItemData?.loanTerms.loanAmount.toString(),
                             style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 8,
                child: Hero(
                  tag: '${_loanItemData?.applicantDetails.dateOfBirth}',
                  child: SizedBox(
                    width: 100,
                    height: 125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage(
                        image: NetworkImage(_loanItemData?.image.url),
                        fit: BoxFit.cover,
                        placeholder:
                        AssetImage(AssetConstants.ic_loading),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
