import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sudo_task/models/news_model.dart';
import 'package:sudo_task/screens/home_detail_screen.dart';

class HomescreenBlock extends StatelessWidget {
  HomescreenBlock({this.index, this.modelResponse});

  List<Articles>? modelResponse;
  int? index;

  @override
  Widget build(BuildContext context) {
    var str = "${modelResponse![index!].publishedAt}";
    var parts = str.split('T');
    var prefix = parts[0].trim();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
              builder: (_) =>
                  HomeDetailScreen(modelResponse: modelResponse, index: index)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          elevation: 2,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                  // borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: modelResponse![index!].urlToImage == null
                        ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                        : modelResponse![index!].urlToImage!,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    placeholder: (BuildContext context, String url) => Center(
                      child: SpinKitRipple(
                        color: Color(0xFF0A6093),
                      ),
                    ),
                    errorWidget:
                        (BuildContext context, String url, dynamic error) =>
                            const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    modelResponse![index!].title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'montserrat_medium'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$prefix',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'gotham_medium',
                            color: Color(0xFF0A6093)),
                      ),
                      Text(
                        '${DateFormat.jm().format(DateTime.parse(str))}',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'gotham_bold',
                            color: Color(0xFF0A6093)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
