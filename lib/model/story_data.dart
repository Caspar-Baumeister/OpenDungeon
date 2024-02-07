class StoryData {
  final List<Message> conversation;
  final List<Option> options;

  StoryData({required this.conversation, required this.options});

  factory StoryData.fromJson(Map<String, dynamic> json) {
    return StoryData(
      conversation: (json['conversation'] as List)
          .map((e) => Message.fromJson(e))
          .toList(),
      options:
          (json['options'] as List).map((e) => Option.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation': conversation.map((e) => e.toJson()).toList(),
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class Message {
  final String content;
  final String role;

  Message({required this.content, required this.role});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'role': role,
    };
  }
}

class Option {
  final String dmAnswer;
  final String text;

  Option({required this.dmAnswer, required this.text});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      dmAnswer: json['dm_answer'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dm_answer': dmAnswer,
      'text': text,
    };
  }
}
