class Message {
  final int id;
  final String title;
  final String content;
  final String audioPath;
  final bool hasOnlyAudio;
  final bool isFavorite;

  Message( {
    required this.id,
    required this.title,
    required this.content,
    required this.audioPath,
    required this.hasOnlyAudio,
    required this.isFavorite,

  });

  Message copy({
    int? id,
    String? title,
    String? content,
    String? audioPath,
    bool? hasOnlyAudio,
  }) =>
      Message(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        audioPath: audioPath ?? this.audioPath,
        hasOnlyAudio: hasOnlyAudio ?? this.hasOnlyAudio,
        isFavorite: isFavorite,

      );

  static Message fromJson(Map<String, Object?> json) => Message(
    id: json['id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    audioPath: json['audioPath'] as String,
    hasOnlyAudio: json['hasOnlyAudio'] == 1, isFavorite: json['isFavorite'] == 1,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'audioPath': audioPath,
    'hasOnlyAudio': hasOnlyAudio ? 1 : 0,
  };
}
