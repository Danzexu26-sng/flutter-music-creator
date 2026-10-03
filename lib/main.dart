import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/recorder/presentation/providers/recorder_provider.dart';
import 'features/sequencer/presentation/providers/sequencer_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecorderProvider()),
        ChangeNotifierProvider(create: (_) => SequencerProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Music Creator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
