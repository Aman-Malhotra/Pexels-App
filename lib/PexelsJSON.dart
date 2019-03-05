class Pexels {
  int page, perPage, totalResults;
  String url, nextPage;
  List<Photo> photos = [];
  Pexels(
      {this.page,
      this.perPage,
      this.totalResults,
      this.url,
      this.nextPage,
      this.photos});

  Pexels.fromJson(Map<String, dynamic> json) {
    if (json['page'] != null) {
      page = json['page'];
    }
    if (json['total_results'] != null) {
      totalResults = json['total_results'];
    }
    if (json['per_page'] != null) {
      perPage = json['per_page'];
    }
    if (json['url'] != null) {
      url = json['url'];
    }
    if (json['nextPage'] != null) {
      url = json['nextPage'];
    }
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(Photo.fromJson(v));
      });
    }
  }
}

class Photo {
  int width, height;
  String url, photographer;
  Src src;
  Photo({this.width, this.height, this.url, this.photographer, this.src});
  Photo.fromJson(Map<String, dynamic> json) {
    if (json['width'] != null) {
      width = json['width'];
    }
    if (json['height'] != null) {
      height = json['height'];
    }
    if (json['url'] != null) {
      url = json['url'];
    }
    if (json['photographer'] != null) {
      photographer = json['photographer'];
    }
    if (json['src'] != null) {
      src = Src.fromJson(json['src']);
    }
  }
}

class Src {
  String original, large, large2x, medium, small, portrait, landscapes, tiny;
  Src(
      {this.original,
      this.large,
      this.large2x,
      this.medium,
      this.small,
      this.portrait,
      this.landscapes,
      this.tiny});

  Src.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json['original'] != null) {
      original = json['original'];
    }
    if (json['large'] != null) {
      large = json['large'];
    }
    if (json['large2x'] != null) {
      large2x = json['large2x'];
    }
    if (json['medium'] != null) {
      medium = json['medium'];
    }
    if (json['small'] != null) {
      small = json['small'];
    }
    if (json['portrait'] != null) {
      portrait = json['portrait'];
    }
    if (json['landscapes'] != null) {
      landscapes = json['landscapes'];
    }
    if (json['tiny'] != null) {
      tiny = json['tiny'];
    }
  }
}
