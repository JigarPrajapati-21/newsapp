class Article {
  final String articleId;
  final String title;
  final String link;
  final String? description;
  final String? pubDate;
  final String? imageUrl;
  final String? sourceName;
  final String? sourceUrl;
  final String? sourceIcon;
  final String? language;
  final List<String>? country;
  final List<String>? category;
  final String? creator;
  final bool? duplicate;
  final int? sourcePriority;
  final String? videoUrl;
  final String? sentiment;
  final String? sentimentStats;
  final String? aiTag;
  final String? aiRegion;
  final String? aiOrg;

  Article({
    required this.articleId,
    required this.title,
    required this.link,
    this.description,
    this.pubDate,
    this.imageUrl,
    this.sourceName,
    this.sourceUrl,
    this.sourceIcon,
    this.language,
    this.country,
    this.category,
    this.creator,
    this.duplicate,
    this.sourcePriority,
    this.videoUrl,
    this.sentiment,
    this.sentimentStats,
    this.aiTag,
    this.aiRegion,
    this.aiOrg,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      articleId: json['article_id'] ?? '',
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      description: json['description'],
      pubDate: json['pubDate'],
      imageUrl: json['image_url'] ?? "https://images.app.goo.gl/UJ2U9tR2mj1k6sH96",
      sourceName: json['source_name'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      language: json['language'],
      country: json['country'] != null ? List<String>.from(json['country']) : null,
      category: json['category'] != null ? List<String>.from(json['category']) : null,
      creator: json['creator'] != null ? List<String>.from(json['creator']).join(', ') : null,
      duplicate: json['duplicate'],
      sourcePriority: json['source_priority'],
      videoUrl: json['video_url'],
      sentiment: json['sentiment'],
      sentimentStats: json['sentiment_stats'],
      aiTag: json['ai_tag'],
      aiRegion: json['ai_region'],
      aiOrg: json['ai_org'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'link': link,
      'description': description,
      'pubDate': pubDate,
      'image_url': imageUrl,
      'source_name': sourceName,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'language': language,
      'country': country,
      'category': category,
      'creator': creator != null ? creator!.split(', ') : null,
      'duplicate': duplicate,
      'source_priority': sourcePriority,
      'video_url': videoUrl,
      'sentiment': sentiment,
      'sentiment_stats': sentimentStats,
      'ai_tag': aiTag,
      'ai_region': aiRegion,
      'ai_org': aiOrg,
    };
  }

  @override
  String toString() {
    return 'Article{articleId: $articleId, title: $title, link: $link, description: $description, pubDate: $pubDate, imageUrl: $imageUrl, sourceName: $sourceName, sourceUrl: $sourceUrl, sourceIcon: $sourceIcon, language: $language, country: $country, category: $category, creator: $creator, duplicate: $duplicate, sourcePriority: $sourcePriority, videoUrl: $videoUrl, sentiment: $sentiment, sentimentStats: $sentimentStats, aiTag: $aiTag, aiRegion: $aiRegion, aiOrg: $aiOrg}';
  }
}
