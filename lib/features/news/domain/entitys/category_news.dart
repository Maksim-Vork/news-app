enum CategoryNews {
  business,
  general,
  science,
  health,
  entertainment,
  sports,
  technology;

  String get apiName => name;

  static List<CategoryNews> get all => values;

  String get uiName {
    switch (this) {
      case CategoryNews.business:
        return 'Business';
      case CategoryNews.general:
        return 'General';
      case CategoryNews.science:
        return 'Science';
      case CategoryNews.health:
        return 'Health';
      case CategoryNews.entertainment:
        return 'Entertainment';
      case CategoryNews.sports:
        return 'Sports';
      case CategoryNews.technology:
        return 'Technology';
    }
  }
}
