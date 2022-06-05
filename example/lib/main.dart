import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http_hive_cache/http_hive_cache.dart';

Future<void> main() async {
  await HttpHiveCache.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final urlController = useTextEditingController();
    final result = useState('no response');

    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpHiveCache example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: TextField(
                  controller: urlController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'URL',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final url = urlController.text;
                  final response = await HttpHiveCache.get(
                    Uri.parse(url),
                  );

                  // expect JSON style
                  final body = json.decode(response.body) as Map;
                  result.value = body.toString();
                },
                child: const Text('Search'),
              ),
              Text('Result: ${result.value}'),
            ],
          ),
        ),
      ),
    );
  }
}
