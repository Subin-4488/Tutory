// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tutory/screens/home/user/pages/prevpractise/topic.dart';

import '../../../../shared/ad_helper.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  int i = 0;

  InterstitialAd? _intestitialAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createIntestitialAd();
  }

  void _createIntestitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: ((ad) => _intestitialAd = ad),
            onAdFailedToLoad: ((error) => _intestitialAd = null)));
  }

  void _showIntestitialAd() {
    if (_intestitialAd != null) {
      _intestitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: ((ad) {
        ad.dispose();
        _createIntestitialAd();
      }), onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        _createIntestitialAd();
      }));
      _intestitialAd!.show();
      _intestitialAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              //color of border
              color: Colors.transparent,
              width: 60, //width of border
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Practice",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5),
              ),
              TextButton.icon(
                  onPressed: () {
                    //previous year practise
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Topic();
                    }));
                  },
                  icon: FaIcon(FontAwesomeIcons.bookMedical),
                  label: Text(
                    "Previous Year Questions",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )),
              TextButton.icon(
                onPressed: () {
                  _showIntestitialAd();
                  Navigator.pushNamed(context, '/category');
                },
                icon: FaIcon(FontAwesomeIcons.paperclip),
                label: Text("Practice Questions",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    )),
              ),
            ],
          )),
    );
  }
}
