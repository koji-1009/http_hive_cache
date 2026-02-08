import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:http_hive_cache/http_hive_cache.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await Hive.initFlutter();
  final String? cacheDir;
  if (kIsWeb) {
    cacheDir = null;
  } else {
    cacheDir = (await getApplicationCacheDirectory()).path;
  }
  await HttpHiveCache.open(path: cacheDir);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
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
  final _urlController = TextEditingController(text: 'https://httpbin.org/get');
  String _result = 'no response';

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final url = _urlController.text;
    if (url.isEmpty) return;

    try {
      final response = await HttpHiveCache.get(Uri.parse(url));

      // expect JSON style
      final bodyString = utf8.decode(response.bodyBytes);
      // simple pretty print or just show string
      setState(() {
        _result = bodyString;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HttpHiveCache example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            TextField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'URL',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _search(),
            ),
            OutlinedButton(onPressed: _search, child: const Text('Search')),
            SelectableText('Result: $_result'),
          ],
        ),
      ),
    );
  }
}
