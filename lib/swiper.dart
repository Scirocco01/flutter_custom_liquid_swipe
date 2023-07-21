

import 'package:flutter/material.dart';

class SwiperFile extends StatefulWidget {
  const SwiperFile({super.key});

  @override
  State<SwiperFile> createState() => _SwiperFileState();
}

class _SwiperFileState extends State<SwiperFile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('this is the output Log');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(

            child: GestureDetector(
              onHorizontalDragStart: (drag){
                print('this is the drag${drag.globalPosition}');
              },
              onPanStart: (drag){
                print('this is the drag on Pan Start${drag.globalPosition}');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.red,
                child:const Center(
                    child:Text('this is the First Screen',style: TextStyle(color: Colors.white),)),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onHorizontalDragStart: (drag){
                print('this is the drag${drag.globalPosition}');
              },
              onPanStart: (drag){
                print('this is the drag on Pan Start${drag.globalPosition}');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blueAccent,
                child:const Center(
                    child:Text('this is the First Screen',style: TextStyle(color: Colors.white),)),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onHorizontalDragStart: (drag){
                print('this is the drag${drag.globalPosition}');
              },
              onPanStart: (drag){
                print('this is the drag on Pan Start${drag.globalPosition}');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.green,
                child:const Center(
                    child:Text('this is the First Screen',style: TextStyle(color: Colors.white),)),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
