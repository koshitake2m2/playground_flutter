import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyWebViewWidget(),
    );
  }
}

class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({super.key});
  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {
  late final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/hello.html')
      ..addJavaScriptChannel(
        'helloWorld',
        onMessageReceived: _helloWorldByFront,
      );
  }

  Future<void> _helloWorldByFront(JavaScriptMessage result) async {
    if (kDebugMode) {
      print('message: ${result.message} in flutter');
    }

    await _controller
        .runJavaScriptReturningResult("calledByFlutter({wow: \"wow\"})");
  }
}
