class RecentVideosModel {
  bool? status;
  RecentVideosResponse? response;
  Path? path;
  String? error;

  RecentVideosModel({this.status, this.response, this.path});

  RecentVideosModel.withError(String errorValue) : error = errorValue ?? '';

  RecentVideosModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'] != null
        ? new RecentVideosResponse.fromJson(json['response'])
        : null;
    path = json['path'] != null ? new Path.fromJson(json['path']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    if (this.path != null) {
      data['path'] = this.path!.toJson();
    }
    return data;
  }
}

class RecentVideosResponse {
  int? currentPage;
  List<RecentVideoData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  RecentVideosResponse(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  RecentVideosResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RecentVideoData>[];
      json['data'].forEach((v) {
        data!.add(new RecentVideoData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class RecentVideoData {
  int? id;
  var categoryId;
  String? title;
  String? slug;
  String? imageName;
  String? videoLink;
  String? mobileVideoLink;

  RecentVideoData(
      {this.id,
      this.categoryId,
      this.title,
      this.slug,
      this.imageName,
      this.videoLink,
      this.mobileVideoLink});

  RecentVideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    slug = json['slug'];
    imageName = json['image_name'];
    videoLink = json['video_link'];
    mobileVideoLink = json['mobile_video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['image_name'] = this.imageName;
    data['video_link'] = this.videoLink;
    data['mobile_video_link'] = this.mobileVideoLink;
    return data;
  }
}

class Path {
  String? thumb;
  String? large;
  String? original;

  Path({this.thumb, this.large, this.original});

  Path.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    large = json['large'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['large'] = this.large;
    data['original'] = this.original;
    return data;
  }
}
