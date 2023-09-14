import 'package:flutter/material.dart';

class TransparentScreen extends StatefulWidget {
  @override
  _TransparentScreenState createState() => _TransparentScreenState();
}

class _TransparentScreenState extends State<TransparentScreen> {
  double opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Half Transparent Screen'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          double newOpacity = opacity - details.delta.dx / MediaQuery.of(context).size.width;
          if (newOpacity < 0.0) {
            newOpacity = 0.0;
          } else if (newOpacity > 1.0) {
            newOpacity = 1.0;
          }
          setState(() {
            opacity = newOpacity;
          });
        },
        child: Stack(
          children: [
            // Transparent container to show content behind
            Container(
              color: Colors.black.withOpacity(opacity),
            ),
            // Content container
            Center(
              child: YourContentWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class YourContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Your content goes here
      child: Text(
        'Your content here',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
