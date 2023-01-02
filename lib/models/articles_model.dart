class ArticlesModel {
    String? description;
    String? imageUrl;
    String? title;

    ArticlesModel({this.description, this.imageUrl, this.title});

    factory ArticlesModel.fromJson(Map<dynamic, dynamic> json) {
        return ArticlesModel(
            description: json['description'],
            imageUrl: json['imageUrl'],
            title: json['title'],
        );
    }

    Map<dynamic, dynamic> toJson() {
        final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
        data['description'] = description;
        data['imageUrl'] = imageUrl;
        data['title'] = title;
        return data;
    }
}