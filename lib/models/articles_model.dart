class ArticlesModel {
    String? description;
    String? imageUrl;
    String? title;
    String? category;

    ArticlesModel({this.description, this.imageUrl, this.title, this.category});

    factory ArticlesModel.fromJson(Map<dynamic, dynamic> json) {
        return ArticlesModel(
            description: json['description'],
            imageUrl: json['imageUrl'],
            title: json['title'],
            category: json['category'],
        );
    }

    Map<dynamic, dynamic> toJson() {
        final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
        data['description'] = description;
        data['imageUrl'] = imageUrl;
        data['title'] = title;
        data['category'] = category;
        return data;
    }
}