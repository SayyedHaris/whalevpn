import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({Key? key}) : super(key: key);

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  var arrColor = [
    Colors.red,
    Colors.orange,
    Colors.grey,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.purpleAccent,
    Colors.brown
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Grid View"),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          crossAxisCount: 2),
          itemCount: arrColor.length,
          itemBuilder: (context, index) {
            return Container(
              color: arrColor[index],

            );
          },),
      // body: GridView.count(crossAxisCount: 4,
      // mainAxisSpacing: 2,
      // crossAxisSpacing: 2,
      // children: [
      //   Container(
      //     color: Colors.red,
      //   ),
      //   Container(
      //     color: Colors.black,
      //   ),
      //   Container(
      //     color: Colors.blue,
      //   ),
      //   Container(
      //     color: Colors.green,
      //   ),
      //   Container(
      //     color: Colors.pink,
      //   ),
      //   Container(
      //     color: Colors.yellow,
      //   ),
      //   Container(
      //     color: Colors.deepPurpleAccent,
      //   ),
      //   Container(
      //     color: Colors.cyan,
      //   ),
      // ],
      // ),

      // body: GridView.extent(
      //   maxCrossAxisExtent: 200,
      //   children: [
      //     Container(
      //       color: Colors.red,
      //     ),
      //     Container(
      //       color: Colors.black,
      //     ),
      //     Container(
      //       color: Colors.blue,
      //     ),
      //     Container(
      //       color: Colors.green,
      //     ),
      //     Container(
      //       color: Colors.pink,
      //     ),
      //     Container(
      //       color: Colors.yellow,
      //     ),
      //     Container(
      //       color: Colors.deepPurpleAccent,
      //     ),
      //     Container(
      //       color: Colors.cyan,
      //     ),
      //   ],
      // ),
    );
  }
}
