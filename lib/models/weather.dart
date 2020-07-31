class Weather{
  String description;
  String icon;

  Weather({this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json["description"],
      icon: json["icon"]
    );
  }
}