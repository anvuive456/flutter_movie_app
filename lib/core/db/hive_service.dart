import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class HiveService {
  
  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await Hive.initFlutter();
  }

  void registerAdapter<T>(TypeAdapter<T> adapter) {
    if(!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  bool _checkOpenedBox(String name) {
    return Hive.isBoxOpen(name);
  }

  ///Check if not opened box then open
  ///
  /// If opened then return that box
  Future<Box<T>> _securedOpenedBox<T>() async {
    if (!_checkOpenedBox(T.toString())) {
      return await Hive.openBox(T.toString());
    }
    return Hive.box(T.toString());
  }

  Future<List<T>> findMany<T>() async {
    final box = await _securedOpenedBox<T>();
    return box.values.toList();
  }

  Future<T?> findUnique<T>(String id) async {
    final box = await _securedOpenedBox<T>();
    return box.get(id);
  }

  Future<void> insert<T>(String key, T value) async {
    final box = await _securedOpenedBox<T>();
    return box.put(key, value);
  }

  Future<void> delete<T>(String key) async {
    final box = await _securedOpenedBox<T>();
    return box.delete(key);
  }
}
