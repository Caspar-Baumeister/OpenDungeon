import 'package:flutter/material.dart';
import 'package:opendungeon/apis/interact.dart';
import 'package:opendungeon/conversation_box.dart';
import 'package:opendungeon/model/story_data.dart';

class StoryPage extends StatefulWidget {
  final StoryData? initialStoryData;

  const StoryPage({super.key, required this.initialStoryData});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late StoryData? storyData;
  bool loading = false;

  @override
  void initState() {
    storyData = widget.initialStoryData;
    super.initState();
  }

  updateStorydata(StoryData? newStoryData) {
    setState(() {
      storyData = newStoryData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return storyData != null
        ? SafeArea(
            child: Column(
              children: [
                // Display the conversation
                Expanded(
                    child: ConversationWidget(
                        conversation: storyData!.conversation)),

                // Display the options
                loading
                    ? const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: storyData!.options.map((option) {
                            return Padding(
                              // Add some padding between buttons
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  storyData!.conversation.add(Message(
                                      content: option.text, role: "user"));
                                  storyData!.conversation.add(Message(
                                      content: option.dmAnswer,
                                      role: "assistant"));
                                  setState(() {
                                    loading = true;
                                  });
                                  Map<String, dynamic> response =
                                      await interactApi(option.text);

                                  try {
                                    StoryData newStoryData =
                                        StoryData.fromJson(response);

                                    updateStorydata(newStoryData);
                                  } catch (e) {
                                    print("button clicked: $e");
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: Text(option.text),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ],
            ),
          )
        : Container();
  }
}
