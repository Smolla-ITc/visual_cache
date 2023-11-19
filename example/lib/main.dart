import 'package:flutter/material.dart';
import 'package:visual_cache/visual_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual cache Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo cache visual'),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cache size',style: TextStyle(fontSize: 24),
            ),
            FutureBuilder<String>(
              future: VisualCache().getCacheSize(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while waiting for the future to complete
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle the error case
                  return Text('Error: ${snapshot.error}');
                } else {
                  // When data is ready, display it
                  return Text(
                    snapshot.data ?? 'Cache size not available',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
              },
            )

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
