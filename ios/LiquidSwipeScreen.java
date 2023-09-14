class LiquidSwipeScreen extends StatefulWidget {
  @override
  _LiquidSwipeScreenState createState() => _LiquidSwipeScreenState();
}

class _LiquidSwipeScreenState extends State<LiquidSwipeScreen> {
  final List<String> pageContent = ['Page 1', 'Page 2', 'Page 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: pageContent.length,
        itemBuilder: (context, index) {
          return LiquidSwipePage(
            content: pageContent[index],
          );
        },
        pageSnapping: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class LiquidSwipePage extends StatelessWidget {
  final String content;

  const LiquidSwipePage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getPageColor(content),
      child: Center(
        child: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Color _getPageColor(String pageContent) {
    // Define your colors for each page here
    Map<String, Color> pageColors = {
      'Page 1': Colors.yellow,
      'Page 2': Colors.red,
      'Page 3': Colors.green,
    };
    return pageColors[pageContent]!;
  }
}