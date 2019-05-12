class SearchRecommendItem{
  String name;
  String value;
  SearchRecommendItem.fromJson(Map<String ,dynamic> jsondata){
    name=jsondata["name"];
    value=jsondata["value"];
  }
}