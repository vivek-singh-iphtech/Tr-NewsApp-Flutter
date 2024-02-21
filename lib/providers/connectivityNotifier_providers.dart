import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityNotifier extends StateNotifier<ConnectivityResult> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult? _previousResult;

  ConnectivityNotifier() : super(ConnectivityResult.none) {
    _initialize();
  }

  void _initialize() async {
    
    final initialResult = await _connectivity.checkConnectivity();
    state = initialResult;
    _previousResult = initialResult;

    // Continuously listen for changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      state = result;
      _handleConnectivityChange(result);
    });
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    if (_previousResult != result) {
      _previousResult = result;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, ConnectivityResult>((ref) {
  return ConnectivityNotifier();
});
