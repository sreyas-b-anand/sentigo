import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends Notifier<bool> {
  
  @override
  bool build() {
    return false;
  }

  void setLoading(bool loading) {
    state = loading;
  }
}

final loadingProvider = NotifierProvider<LoadingNotifier, bool>(() {
  return LoadingNotifier();
});
