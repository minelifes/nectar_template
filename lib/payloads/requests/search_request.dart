import 'package:nectar/nectar.dart';

part 'search_request.g.dart';

@JsonSerializable(createToJson: false)
class SearchRequest{
  final String query;

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);


  SearchRequest({required this.query});
}