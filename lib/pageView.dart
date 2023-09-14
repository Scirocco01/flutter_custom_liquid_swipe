import 'package:flutter/material.dart';

class OverlayWithHole extends StatefulWidget {
  const OverlayWithHole({super.key});

  @override
  State<OverlayWithHole> createState() => _OverlayWithHoleState();
}

class _OverlayWithHoleState extends State<OverlayWithHole> {

  double x= 150.0;
  double y = 450.0;
  double boxWidth = 0.0;
  double horizontalOffset = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  GestureDetector(
          onPanUpdate: (pan){
            print('these are and y values ${pan.globalPosition.dy} and x = ${pan.globalPosition.dx}');
            setState(() {
              x= pan.globalPosition.dx;
              y= pan.globalPosition.dy;
              boxWidth = MediaQuery.of(context).size.width - x;

              // Calculate the horizontal offset based on user's touch position
              horizontalOffset = (MediaQuery.of(context).size.width - x) / MediaQuery.of(context).size.width;
            });
          },
          child: Stack(children: <Widget>[
            _getContent(),
            _getClipPathOverlay()
          ]),
        )
    );
  }



  Widget _getContent() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color(0xff49b5eb)
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 60,),
                Image(image: AssetImage('Assets/blue.png'),
                  fit: BoxFit.contain,
                ),
                Text('Healthy \n Foods',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                Text('Discover healthy recipes that \n are easy to do with the detailed \n cooking '
                    'instruction from top \n chefs ',
                textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,),
                )

              ],
            )
        ),

        );

  }


  ClipPath _getClipPathOverlay() {
    return ClipPath(
      clipper: InvertedClipper(x: x,y: y, boxWidth: boxWidth, context: context, horizontalOffset: horizontalOffset),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xfff4a5b3)
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 60,),
            Image(image: AssetImage('Assets/pink.png'),
              fit: BoxFit.contain,
            ),
            Text('Dessert\n Recipes',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w700),),
            SizedBox(height: 10,),
            Text('Hot or cold our dessert \n recipes can turn average\n meal'
                'onto a memorable event',
              textAlign: TextAlign.center,

              style: TextStyle(color: Colors.white,),
            ),

          ],
        )
      ),
    );
  }
}

class HolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54;

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(
              Rect.fromLTWH(0, 0, size.width, size.height)
          ),
          Path()
            ..addOval(Rect.fromCircle(center: Offset(size.width -44, size.height - 44), radius: 40))
            ..close(),
        ),
        paint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class InvertedClipper extends CustomClipper<Path> {
  double x;
  double y;
  double boxWidth;
  double horizontalOffset;
  BuildContext context;

  InvertedClipper({required this.x, required this.y, required this.boxWidth,required this.context,required this.horizontalOffset});

  @override
  Path getClip(Size size) {
    double waveOffset = 60.0 * horizontalOffset *2; // Adjust the wave amplitude here

    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..moveTo(0, 550) // Start from the top-right corner
        // ..lineTo(x, 450) // Move to the top-left of the "hole" without the wave effect
        ..cubicTo(
          y - 50, x,
          x + boxWidth + waveOffset - 50, y,
          x + boxWidth + waveOffset, 0,
        )
        ..lineTo(size.width, 0) // Move back to the top-right corner to close the path
        ..lineTo(size.width, size.height *2 ) // Move to the bottom-right corner
        ..lineTo(0, size.height * 4) // Move to the bottom-left corner
        ..lineTo(0, 0) // Move back to the top-right corner to close the path
        ..close(),
    );
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

