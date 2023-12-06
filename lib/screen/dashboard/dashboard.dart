import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../constant/colors.dart';
import '../../model/fileCardModel.dart';
import '../../widget/customeFloatng.dart';
import '../../widget/customeHomeAppBar.dart';
import '../../widget/fileCard.dart';
import '../../widget/gradientBack.dart';
import '../addDocument/addDocumnet.dart';
import '../../logic/k/provider/mprovider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DashBoardPage extends StatefulWidget {
  static String routeName = '/DashBoardPage';
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  initializAdmob() {
    print('init');
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        // 'ca-app-pub-7764025314745072/9448965280',
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isBannerAdReady = true;
              print('init load  $_isBannerAdReady');
            });
          },
          onAdFailedToLoad: (ad, error) {
            _isBannerAdReady = false;
            setState(() {});
            print('init fail  $_isBannerAdReady');
          },
        ),
        request: const AdRequest());

    _bannerAd.load();
  }

  @override
  void initState() {
    setStream();
    initializAdmob();

    super.initState();
  }

  TextEditingController controller = TextEditingController();

  StreamController<DatabaseEvent> streamController = StreamController();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  setStream() {
    FirebaseDatabase.instance
        .ref()
        .child('file_info$userId')
        .orderByChild('title')
        .startAt(controller.text)
        .endAt('${controller.text}' '\uf8ff')
        .onValue
        .listen((event) {
      streamController.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProivder>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
            floatingActionButton: CustomFloatingButton(
              title: 'Upload',
              onTap: () {
                Navigator.pushNamed(context, AddDocumentPage.routeName);
              },
              child: const Icon(
                Icons.cloud_upload_rounded,
                color: indigo,
              ),
            ),
            appBar: CustomAppBar(
                controller: controller,
                onSerach: () {
                  setStream();
                  print('searching');
                  setState(() {});
                }),
            body: GradientBackground(
              child: StreamBuilder<DatabaseEvent>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value != null) {
                      List<FileCardModel> list = [];
                      print('value   ${snapshot.data!.snapshot.value}');
                      (snapshot.data!.snapshot.value as Map<dynamic, dynamic>)
                          .forEach((key, value) {
                        list.add(FileCardModel.fromJson(value));
                        print('$key: $value');
                      });

                      return ListView(
                          children: list
                              .map((e) => FileCard(
                                  filecard: FileCardModel(
                                      title: e.title,
                                      note: e.note,
                                      date: e.date,
                                      fileName: e.fileName,
                                      fileType: e.fileType,
                                      fileUrl: e.fileUrl)))
                              .toList());
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Data Found'),
                        ],
                      );
                    }
                  }),
            ),
            bottomNavigationBar: _isBannerAdReady
                ? Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  )
                : const SizedBox(
                    child: Text('failed'),
                  )),
      );
    });
  }
}
