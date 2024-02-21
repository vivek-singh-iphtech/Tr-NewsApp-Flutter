import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/providers/connectivityNotifier_providers.dart';

class GlobalConnectivityListener extends StatefulWidget {
  final Widget child;

  const GlobalConnectivityListener({Key? key, required this.child}) : super(key: key);

  @override
  _GlobalConnectivityListenerState createState() => _GlobalConnectivityListenerState();
}

class _GlobalConnectivityListenerState extends State<GlobalConnectivityListener> {
  late ConnectivityResult _previousConnectivityResult;
  bool _initialCheck = true;

  @override
  void initState() {
    super.initState();
    _previousConnectivityResult = ConnectivityResult.none;
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    ConnectivityResult connectivityStatus = await Connectivity().checkConnectivity();
    if (connectivityStatus == ConnectivityResult.none) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _showSnackBar2("No Internet Connection", context);
      });
    }
    _previousConnectivityResult = connectivityStatus;
    _initialCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final connectivityStatus = ref.watch(connectivityProvider);
        final isConnected = connectivityStatus != ConnectivityResult.none;
        final wasConnected = _previousConnectivityResult != ConnectivityResult.none;

        if (!_initialCheck) {
          if (!wasConnected && isConnected) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              _showSnackBar("Connected to the Internet", context);
            });
          } else if (wasConnected && !isConnected) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              _showSnackBar2("No Internet Connection", context);
            });
          }
        }

        _previousConnectivityResult = connectivityStatus;

        return widget.child;
      },
    );
  }

  void _showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black,
      elevation: 4,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSnackBar2(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.black,
      elevation: 4,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
