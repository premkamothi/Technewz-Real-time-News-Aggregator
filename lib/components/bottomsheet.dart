import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:technewz/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components.dart';

void showMyBottomSheet(
  BuildContext context,
  String title,
  String description,
  imageurl,
  url,
) {
  showBottomSheet(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    elevation: 20,
    context: context,
    builder: (context) {
      return MyBottomSheetLayout(
        url: url,
        imageurl: imageurl,
        title: title,
        description: description,
      );
    },
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyBottomSheetLayout extends StatelessWidget {
  final String imageurl, title, description, url;

  const MyBottomSheetLayout({
    Key? key,
    required this.imageurl,
    required this.title,
    required this.description,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomSheetImage(imageurl: imageurl, title: title),
          Container(
            padding: EdgeInsets.all(10),
            child: modifiedText(
              text: description,
              size: 16,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: RichText(text: TextSpan(children: <TextSpan>[TextSpan(
              text: 'Read full artical',
              recognizer: TapGestureRecognizer()
                ..onTap=(){
                    _launchURL(url);
                },
              style: GoogleFonts.lato(color: Colors.blue.shade400)
            )])),
          ),
        ],
      ),
    );
  }
}
