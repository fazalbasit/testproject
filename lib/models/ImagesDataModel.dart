class ImageData {
  final double aspectRatio;
  final int height;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  ImageData({
    required this.aspectRatio,
    required this.height,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      aspectRatio: json['aspect_ratio'] ?? 0.0,
      height: json['height'] ?? 0,
      iso6391: json['iso_639_1'],
      filePath: json['file_path'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      width: json['width'] ?? 0,
    );
  }
}

class ImageResponse {
  final List<ImageData> images;

  ImageResponse({
    required this.images,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> imagesJson = json['backdrops'] ?? [];
    List<ImageData> images =
        imagesJson.map((imageJson) => ImageData.fromJson(imageJson)).toList();
    return ImageResponse(images: images);
  }
}
