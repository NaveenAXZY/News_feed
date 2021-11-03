import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sudo_task/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetailScreen extends StatelessWidget {
  HomeDetailScreen({Key? key, this.modelResponse, this.index})
      : super(key: key);

  List<Articles>? modelResponse;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.red.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: "${modelResponse![index!].urlToImage}",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12, top: 10),
                    width: double.infinity,
                    child: Text(
                      'Title ',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D0D0D)),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 20, top: 12),
                      child: Text('${modelResponse![index!].title!}')),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 12, top: 12),
                    child: Text(
                      'Description',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat-Bold',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0D0D0D)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20, top: 12, right: 6),
                    child: Text(
                      '${modelResponse![index!].description}',
                      style: TextStyle(fontSize: 13, color: Color(0xFF59595A)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 170,
              width: double.infinity,
              color: Colors.white,
              child: Column(children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Content',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat-Bold',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0D0D0D)),
                      ),
                      Text(
                        '',
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20, top: 12, right: 6),
                  child: Text(
                    '${modelResponse![index!].content}',
                    style: TextStyle(fontSize: 13, color: Color(0xFF59595A)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(modelResponse![index!].url!);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 22, right: 12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Explore',
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
