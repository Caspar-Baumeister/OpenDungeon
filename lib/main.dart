import 'package:flutter/material.dart';
import 'package:opendungeon/apis/start_api.dart';
import 'package:opendungeon/model/story_data.dart';
import 'package:opendungeon/story_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Dungeon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(title: 'Open Dungeon'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<StoryData?>? storyDataFuture;

  @override
  void initState() {
    super.initState();
    storyDataFuture = startBackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              Future<StoryData?> responseData = startBackend();
              setState(() {
                storyDataFuture = responseData;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<StoryData?>(
        future: storyDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return RefreshIndicator(
                onRefresh: () async {
                  Future<StoryData?> responseData = startBackend();
                  setState(() {
                    storyDataFuture = responseData;
                  });
                },
                child: const Center(child: Text('No data received.')));
          } else {
            // Assuming StoryData has a 'toString()' method or you can modify the below line to format the data as you wish
            return StoryPage(initialStoryData: snapshot.data);
          }
        },
      ),
    );
  }
}

Future<StoryData?> startBackend() async {
  final response = await startApi();
  try {
    return StoryData.fromJson(response);
  } catch (e) {
    print(e.toString());
  }
  return null;
}
