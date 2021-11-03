

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_bloc.dart';
import 'package:sudo_task/bloc/home_bloc/recent_list_event.dart';

class CountryListBlock extends StatelessWidget {
   CountryListBlock({Key? key,this.postBloc,this.countryList,this.index}) : super(key: key);

   NewsListBloc? postBloc;
   var countryList;
   int? index;

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        postBloc!.add(Query(
            params: countryList[index]['code'],
            source: 'COUNTRY'));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 2,
          child: Column(
            children: [
              ClipRRect(
                child: SvgPicture.network(
                  '${countryList[index]['image']}',
                  fit: BoxFit.fill,
                  height: 130,
                  width: double.infinity,
                  placeholderBuilder:
                      (BuildContext context) =>
                      Center(
                        child: SpinKitRipple(
                          color: Colors.green,
                        ),
                      ),
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8)),
              ),
              SizedBox(height: 18),
              Text('${countryList[index]['country']}')
            ],
          ),
        ),
      ),
    );
  }
}
