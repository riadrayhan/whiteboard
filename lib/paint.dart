import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hand_signature/signature.dart';
import 'package:flutter/cupertino.dart';

class Painting extends StatefulWidget {
  const Painting({Key? key}) : super(key: key);

  @override
  State<Painting> createState() => _PaintingState();
}
HandSignatureControl control = HandSignatureControl(
  threshold: 0.70,
  smoothRatio: 0.5,
  velocityRange: 2.0,

);
HandSignature name=HandSignature(
  control: control,
  color: Colors.lightGreen,
);
/*HandSignaturePaint _paint=HandSignaturePaint(
    control: control,
  color: Colors.deepPurple,
);*/
class _PaintingState extends State<Painting> {
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-7230640014460944/6424288998', // Replace with your own AdUnitId
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load banner ad: $error');
        },
      ),
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: Text("Whiteboard"),
        leading: Icon(Icons.developer_board,color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 200,
                  constraints: BoxConstraints.tight(Size(double.maxFinite, MediaQuery.of(context).size.height/1.4)),
                  color: Colors.lightGreenAccent,
                  child: HandSignature(
                    control: control,
                    type: SignatureDrawType.shape,
                    color: Colors.deepOrange,
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tight(Size(double.maxFinite, MediaQuery.of(context).size.height/14)),
                  color: Colors.deepOrange,
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),

                Stack(
                  children: <Widget>[

                    /*    Container(
                      color: Colors.deepOrange,
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                      constraints: BoxConstraints.tight(Size(double.maxFinite, MediaQuery.of(context).size.height/1.3)),
                    ),*/

                    Column(
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () {
                            control.clear();
                          },
                          child: const Text('CLEAR ALL',style: TextStyle(color: Colors.black,fontSize: 20,fontStyle: FontStyle.normal)),
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
    );
  }
}
