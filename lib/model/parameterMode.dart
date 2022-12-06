
class ParameterModel{
  String Key;
  String Type;
  dynamic Value;

  ParameterModel({required this.Key, required this.Type,required this.Value});
  Map<String, dynamic> toJson() => {
    "Key": Key,
    "Type": Type,
    "Value": Value,
  };
  dynamic get(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('property not found');
  }
}