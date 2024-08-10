import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../config/constants.dart';
import 'auth/provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<AuthProvider>(context).token;

    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse('$BASE_FRONT_URL/swagger-ui/index.html'),
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
        ),
      ),
    );
  }
}
