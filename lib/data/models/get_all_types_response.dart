import 'package:equatable/equatable.dart';

class GetAllTypesResponse extends Equatable {
  final List<String>? types;

  const GetAllTypesResponse({
    this.types,
  });

  static GetAllTypesResponse fromJson(Map<String, dynamic> json) {
    final dataList = json['results'] != null
        ? (json['results'] as List).map((item) => item['name']).toList()
        : null;

    return GetAllTypesResponse(
      types: dataList != null ? List<String>.from(dataList) : null,
    );
  }

  static Map<String, dynamic> toJson(GetAllTypesResponse getAllTypesResponse) {
    final Map<String, dynamic> data = {};

    data['types'] = getAllTypesResponse.types;

    return data;
  }

  @override
  List<Object?> get props => [types];
}
