import 'package:flutter/material.dart';

class SwiperFile extends StatefulWidget {
  const SwiperFile({Key? key}) : super(key: key);

  @override
  State<SwiperFile> createState() => _SwiperFileState();
}

class _SwiperFileState extends State<SwiperFile> {
  double swipeProgress = 0.0;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onHorizontalDragUpdate: (dragUpdate) {
          double progress = dragUpdate.localPosition.dx / MediaQuery.of(context).size.width;
          setState(() {
            swipeProgress = progress.clamp(-1.0, 1.0);
          });
        },
        onHorizontalDragEnd: (dragEnd) {
          if (swipeProgress > 0.5) {
            setState(() {
              currentPage = (currentPage + 1).clamp(0, 2);
              swipeProgress = 1.0;
            });
          } else if (swipeProgress < -0.5) {
            setState(() {
              currentPage = (currentPage - 1).clamp(0, 2);
              swipeProgress = -1.0;
            });
          } else {
            setState(() {
              swipeProgress = 0.0;
            });
          }
        },
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * (0 - currentPage + swipeProgress),
              child: SwipeScreen(
                progress: swipeProgress,
                color: _getPageColor(0),
                content: _getPageContent(0),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * (1 - currentPage + swipeProgress),
              child: SwipeScreen(
                progress: swipeProgress,
                color: _getPageColor(1),
                content: _getPageContent(1),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * (2 - currentPage + swipeProgress),
              child: SwipeScreen(
                progress: swipeProgress,
                color: _getPageColor(2),
                content: _getPageContent(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPageColor(int pageIndex) {
    // Define your colors for each page here
    List<Color> pageColors = [Colors.yellow, Colors.red, Colors.green];
    return pageColors[pageIndex];
  }

  Widget _getPageContent(int pageIndex) {
    // Define your content for each page here
    List<String> pageContent = [
      'Hello',
      'This is page 1',
      'This is page 2',
    ];
    return Center(
      child: Text(
        pageContent[pageIndex],
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}

class SwipeScreen extends StatelessWidget {
  final double progress;
  final Color color;
  final Widget content;

  const SwipeScreen({required this.progress, required this.color, required this.content});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [color, color, Colors.transparent, Colors.transparent],
          stops: [0.0, 0.5 + (progress * 0.5), 0.5 + (progress * 0.5), 1.0],
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: Container(
        color: color,
        child: content,
      ),
    );
  }
}


class LiquidSwipePainter extends CustomPainter {
  final double swipeProgress;
  final double verticalProgress;


  LiquidSwipePainter({required this.swipeProgress,required this.verticalProgress});

  @override
  void paint(Canvas canvas, Size size) {
    double circleX = size.width * swipeProgress;
    double circleY = size.height - size.height * verticalProgress * 2;


    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;


    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10;


    canvas.drawLine(
      Offset(circleX, 0),
      Offset(circleX, size.height),
      paint,
    );



    canvas.drawCircle(Offset(circleX, circleY), 60, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
