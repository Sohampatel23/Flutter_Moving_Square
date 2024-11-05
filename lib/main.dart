import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Square'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _leftposition =0; //Initial position of left
  bool _isleftbuttondisable = true;
  bool _isrightbuttondisable = false;
  bool _isAnimating = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        _leftposition = (MediaQuery.of(context).size.height/2)-50;
        _isleftbuttondisable =false;
        _isrightbuttondisable = false;
      });
    });
    super.initState();
  }

  //function to move square to the left side
  void moveLeft(){
    setState(() {
      _leftposition = 0; //Move square to left edge
      _isleftbuttondisable = true;
      _isrightbuttondisable = false;
      _isAnimating = true;
    });
  }

  //function to move square to the right side
  void moveRight(){
    setState(() {
      _leftposition = MediaQuery.of(context).size.width-100;
      _isrightbuttondisable = true;
      _isleftbuttondisable = false;
      _isAnimating = true;
    });
  }

  void _onAnimationEnd() {
    setState(() {
      // Re-enable the buttons based on the final position of the square
      _isAnimating = false;
      _isleftbuttondisable = _leftposition == 0; // Disable if on left edge
      _isrightbuttondisable = _leftposition == MediaQuery.of(context).size.width - 100; // Disable if on right edge
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              left: _leftposition,
            top: MediaQuery.of(context).size.height/2-50, //center vertically square place
            child: Container(width: 100,height: 100,color: Colors.blue,),
            onEnd: _onAnimationEnd,
          ),
          Positioned(
            bottom: 50,
              left: 0,
              right: 0,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){ ( _isleftbuttondisable || _isAnimating )? null : moveLeft();
                  }, child: Text('Left'),
                    style: ElevatedButton.styleFrom(backgroundColor: ( _isleftbuttondisable || _isAnimating ) ? Colors.grey :Colors.blue),),
                  SizedBox(width: 20,),
                  ElevatedButton(onPressed: (){ (_isrightbuttondisable || _isAnimating)? null : moveRight();}, child: Text('Right'),
                  style: ElevatedButton.styleFrom(backgroundColor: (_isrightbuttondisable || _isAnimating) ? Colors.grey :Colors.blue),
                  ),
                ],
              ))
        ],
      )

    );
  }
}
