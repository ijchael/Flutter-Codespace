import 'package:mongo_dart/mongo_dart.dart';
import 'package:stella_chatbot/models/user.dart';

class DatabaseService {
  late Db _db;
  late DbCollection _users;

  Future<void> connect() async {
    _db = await Db.create('mongodb://localhost:27017/stella_chatbot');
    await _db.open();
    _users = _db.collection('users');
  }

  Future<void> updateUser(User user) async {
    await _users.update(
      where.eq('_id', user.id),
      {
        '\$set': {
          'name': user.name,
          'age': user.age,
          'children': user.children,
        }
      },
    );
  }

  Future<User?> getUser(String userId) async {
    final userData = await _users.findOne(where.eq('_id', userId));
    if (userData != null) {
      return User(
        id: userData['_id'],
        name: userData['name'],
        age: userData['age'],
        children: List<String>.from(userData['children']),
      );
    }
    return null;
  }
}