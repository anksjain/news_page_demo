class NewsDetail {
  String title;
  String description;
  int id;
  String imageUrl;
  String tags;
  int saved;
  NewsDetail(
      {this.title,
      this.description,
      this.tags,
      this.id,
      this.imageUrl,
      this.saved = -1});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'description': description,
      'id': id,
      'tags': tags,
      'saved': saved,
      'image': imageUrl
    };
    return map;
  }

  static NewsDetail fromMap(Map<String, dynamic> map) {
    return new NewsDetail(
      title: map['title'],
      description: map['description'],
      imageUrl: map['image'],
      id: map['id'],
      tags: map['tags'],
      saved: map['saved'],
    );
  }
}

class NewsDb {
  List<NewsDetail> getNews() {
    List<NewsDetail> allNews = new List<NewsDetail>();
    NewsDetail newsDetail1 = NewsDetail(
        title: "Minister of Education",
        id: 1,
        tags: "#NewEdu",
        imageUrl: "assets/images/corpor.jpeg",
        description:
            'Google News is a news aggregator service developed by Google. It presents a continuous flow of links to articles organized from thousands of publishers and magazines. Google News is available as an app on Android, iOS, and the Web.');
    allNews.add(newsDetail1);
    NewsDetail newsDetail2 = NewsDetail(
        title: "New App Launches ",
        id: 2,
        tags: "#AppWorld",
        imageUrl: "assets/images/technews.jpeg",
        description:
            'Google News is a news aggregator service developed by Google. It presents a continuous flow of links to articles organized from thousands of publishers and magazines. Google News is available as an app on Android, iOS, and the Web.');
    allNews.add(newsDetail2);
    allNews.add(new NewsDetail(
        title: "Hike in Corona Cases",
        id: 3,
        tags: "#Corona #Covid",
        imageUrl: "assets/images/politics.jpeg",
        description:
            'Google News is a news aggregator service developed by Google. It presents a continuous flow of links to articles organized from thousands of publishers and magazines. Google News is available as an app on Android, iOS, and the Web.'));
    allNews.add(new NewsDetail(
        title: "Social Media Hike",
        id: 4,
        tags: "#Insta #FB",
        imageUrl: "assets/images/tttec.jpeg",
        description:
            'Google News is a news aggregator service developed by Google. It presents a continuous flow of links to articles organized from thousands of publishers and magazines. Google News is available as an app on Android, iOS, and the Web.'));
    return allNews;
  }
}
