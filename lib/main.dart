import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.blue,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Signature Demo'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor:  Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'Signature',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Signature(
            key: const Key('signature'),
            controller: _controller,
            height: 300,
            width: 350,
            backgroundColor: Colors.grey[200]!,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:  Colors.blue,
                  ),
                  onPressed: () {
                    setState(() => _controller.undo());
                  },
                  child: const Text("Undo")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:  Colors.blue,
                  ),
                  onPressed: () {
                    setState(() => _controller.redo());
                  },
                  child: const Text("Redo")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:  Colors.blue,
                  ),
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  child: const Text("Clear")),
            ],
          ),
        ),
      ),
    );
  }
}
