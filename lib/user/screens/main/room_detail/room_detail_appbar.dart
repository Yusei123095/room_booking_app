import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoomDetailAppbar extends StatelessWidget {
  const RoomDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      pinned: false,
      expandedHeight: 275,
      backgroundColor: Colors.white,
      elevation: 0.0,
      stretch: true,

      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.blurBackground, StretchMode.zoomBackground],

        background: Image.asset(
          "assets/images/modern-equipped-computer-lab.jpg",
          fit: BoxFit.cover,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(
          child: Container(
            width: 40,
            height: 5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
      ),
      leadingWidth: 80.0,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          child: Align(
            alignment: Alignment(0.3, 0),
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
          margin: EdgeInsets.only(left: 24),
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
