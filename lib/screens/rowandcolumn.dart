import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:whale_vpn/screens/gridView.dart';

import 'package:whale_vpn/troggleEye/troggleeye.dart';



class RowandColumn extends StatefulWidget {
  const RowandColumn({Key? key}) : super(key: key);

  @override
  State<RowandColumn> createState() => _RowandColumnState();
}

class _RowandColumnState extends State<RowandColumn> {
  final TroggleEye _flag = Get.put(TroggleEye());

  final List<String> _list = [
    'Apple',
    'Banana',
    'Orange',
    'CustardApple',
    'Grapes',
    'Papaya',
    'Watermelon'
  ];
  String? firstHalf;
  String? secondHalf;
  // bool flag = true;
  final String? description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. ";

  @override
  void initState() {
    super.initState();

    if (description!.length > 50) {
      firstHalf = description!.substring(0, 50);
      secondHalf = description!.substring(50, description!.length);
    } else {
      firstHalf = description!;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF637074),
      appBar: AppBar(
        title: Text("Row and Column"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),

      body: SingleChildScrollView(
        child: Container(
            height: Get.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFFF8F4E3), Colors.black])),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .04, vertical: Get.height * .015),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: Get.height * .01),
                      decoration: BoxDecoration(
                          color: const Color(0xFF646F4B),
                          borderRadius: BorderRadius.circular(25)),
                      width: Get.width,
                      height: Get.height * .3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          const Text("This is Marque Effect",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          Container(
                            height: 50,
                            width: 380,
                            child: Marquee(
                              text:
                                  "This is a marquee text widget with a scrolling effect. You can customize its behavior and appearance.",
                              style: const TextStyle(color: Colors.white),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 50.0,
                              pauseAfterRound: const Duration(seconds: 1),
                              startPadding: 10.0,
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.bounceIn,
                              decelerationDuration:
                                  const Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 45,
                            width: Get.width,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _list.length,
                              itemBuilder: (context, index) {
                                int itemNumber = index + 1;
                                return Card(
                                  child: Center(
                                      child: Text(
                                    '$itemNumber. ${_list[index].toString()}',
                                    style: const TextStyle(fontSize: 25),
                                  )),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          Container(
                              color: Colors.white,
                              height: 50,
                              width: Get.width,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: _list.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        Text(
                                          _list[index].toString(),
                                          style: const TextStyle(fontSize: 31),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: Get.width * .01),
                            decoration: BoxDecoration(
                                color: const Color(0xFFBEB7A4),
                                borderRadius: BorderRadius.circular(20)),
                            height: Get.height * .25,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * .01,
                        ),
                        Container(
                          height: Get.height * .25,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF4C3B4D),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: Get.height * .09,
                                  width: Get.width * .4,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD3C0CD),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: Get.height * .09,
                                  width: Get.width * .4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF62BFED),
                            borderRadius: BorderRadius.circular(30)),
                        width: Get.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * .02,
                              horizontal: Get.width * .05),
                          child: Column(
                            children: [
                              const Text(
                                "What is Flutter!",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Container(
                                child: secondHalf!.isEmpty
                                    ? Text(firstHalf!)
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Obx(
                                              () => Text(_flag.flag.value
                                                  ? (firstHalf! + "...")
                                                  : (firstHalf! + secondHalf!)),
                                            ),
                                            // Text(flag
                                            //     ? (firstHalf! + "...")
                                            //     : (firstHalf! + secondHalf!)),
                                            InkWell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: Get.height * .05,
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      _flag.flag.value
                                                          ? "Show more.."
                                                          : "Show less",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                _flag.flagSwitch();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: StadiumBorder()),
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        msg: "This is Toast Notification");
                                  },
                                  child: Text("Toast Notification"))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      bottomNavigationBar: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          tabs: [
            GButton(text: "Home", icon: Icons.home),
            GButton(
                onPressed: (){

            },
                text: "Likes", icon: Icons.favorite_border),
            GButton(
                onPressed: () {
                  return Get.to(GridViewScreen());
                },
                text: 'Search',
                icon: Icons.search),
            GButton(text: 'Setting', icon: Icons.settings),
          ]),

// with obx
      // bottomNavigationBar: Obx(() => BottomNavigationBar(
      //
      //   currentIndex: _flag.currentInd.value,
      //   onTap: (value) {
      //     _flag.currentIndex(value);
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //
      //         label: 'Home',
      //         icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(
      //         label: 'Search',
      //         icon: Icon(Icons.search)),
      //     BottomNavigationBarItem(
      //         label: 'Settings',
      //         icon: Icon(Icons.settings)),
      //
      //   ],
      // ),)

      // bottomNavigationBar: Obx(() => BottomNavigationBar(
      //   currentIndex: _flag.currentInd.value,
      //   onTap: (value) {
      //     _flag.currentIndex(value);
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //
      //         label: 'Home',
      //         icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(
      //         label: 'Search',
      //         icon: Icon(Icons.search)),
      //     BottomNavigationBarItem(
      //         label: 'Settings',
      //         icon: Icon(Icons.settings)),
      //
      //   ],
      // ),)
    );
  }
}
