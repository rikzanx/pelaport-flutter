import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pelaport/constant.dart';
import 'package:pelaport/items_slide.dart';
import 'package:pelaport/slide_dots.dart';
import 'package:pelaport/slide_items.dart';
import 'package:pelaport/views/login/login.dart';
import 'package:pelaport/views/login/login_new.dart';

class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    tinggilayar = MediaQuery.of(context).size.height;
    lebarlayar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: tinggilayar,
        width: lebarlayar,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                height: tinggilayar,
                width: lebarlayar,
                child: PageView.builder(
                  // scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: slideList.length,
                  itemBuilder: (ctx, i) => SlideItem(i),
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < slideList.length; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                )),
            Container(
              height: tinggilayar / 15,
              width: lebarlayar,
              margin:
                  EdgeInsets.only(bottom: 60.0, left: 40, right: 40, top: 50.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(14),
                color: primarycolor,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                  onPressed: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => LoginNew()),
                        (ctx) => false);
                  },
                  child: Text("LANJUT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: tinggilayar / lebarlayar * 7)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
