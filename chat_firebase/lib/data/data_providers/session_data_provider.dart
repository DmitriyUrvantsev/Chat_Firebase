import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const accountId = 'account_id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

//?------------------------------------
  Future<String?> getAccountId() => _secureStorage.read(key: _Keys.accountId);

  Future<void> setAccountId(String? value) {
    if (value != null) {
      print('SessionDataProvider - set:$value');
      return _secureStorage.write(key: _Keys.accountId, value: value);
    } else {
      return _secureStorage.delete(key: _Keys.accountId);
    }
  }
//?-----------------------------------
}
