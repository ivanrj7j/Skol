import 'package:uuid/uuid.dart';

String getUserID(String username){
  return "$username-${new Uuid().v1()}";
}