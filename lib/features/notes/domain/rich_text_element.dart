class RichTextElement {
  String text;
  bool isBold;
  bool isQuote;
  bool hasBullet;

  RichTextElement({
    required this.text,
    this.isBold = false,
    this.isQuote = false,
    this.hasBullet = false,
  });

  factory RichTextElement.fromMap(Map<String, dynamic> map) {
    return RichTextElement(
      text: map['text'],
      isBold: map['isBold'] ?? false,
      isQuote: map['isQuote'] ?? false,
      hasBullet: map['hasBullet'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isBold': isBold,
      'isQuote': isQuote,
      'hasBullet': hasBullet,
    };
  }
}