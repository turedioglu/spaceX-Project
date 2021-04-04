import 'package:appnotion_project/constants/appBar.dart';
import 'package:appnotion_project/constants/borderConstants.dart';
import 'package:appnotion_project/constants/boxDecoration.dart';
import 'package:appnotion_project/constants/colors.dart';
import 'package:appnotion_project/constants/paddingConstants.dart';
import 'package:appnotion_project/models/spaceX_model.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

SpaceX items;

class _HomeState extends State<Home> {
  String url = 'https://api.spacexdata.com/v4/launches/latest';

  Future getItems() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final spaceX = spaceXFromJson(response.body);
        if (this.mounted) {
          setState(() {
            items = spaceX;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(appBarTitle),
          centerTitle: centerTitle,
          backgroundColor: appBarColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width),
            decoration: BoxDecoration(color: firstContainer),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: PaddingConstants.instance.paddingFirstContainer,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: secondContainer,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Padding(
                      padding: PaddingConstants.instance.paddingSecondContainer,
                      child: Container(
                        child: items != null
                            ? ListView(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Image.network(
                                          items.links.patch.small,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                        ),
                                        Text(items.name,
                                            style: GoogleFonts.abel(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: itemDetailsDecoration,
                                          child: Text(
                                            items.details,
                                            style: GoogleFonts.abel(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: PaddingConstants
                                                    .instance
                                                    .paddingYoutubeButton,
                                                child: RaisedButton(
                                                  shape: BorderConstants
                                                      .instance
                                                      .youtubeButtonCircular,
                                                  onPressed: () async {
                                                    url = items.links.webcast;
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_right,
                                                    color: youtubeIconColor,
                                                    size: 38,
                                                  ),
                                                  color: youtubeButtonColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: PaddingConstants
                                                    .instance
                                                    .paddingWikipediaButton,
                                                child: RaisedButton(
                                                  shape: BorderConstants
                                                      .instance
                                                      .wikipediaButtonCircular,
                                                  onPressed: () async {
                                                    url = items.links.wikipedia;
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw 'could not launch $url';
                                                    }
                                                  },
                                                  child: Text(' Wikipedia®',
                                                      style: GoogleFonts.roboto(
                                                          color:
                                                              wikipediaTextColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  color: wikipediaButtonColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
