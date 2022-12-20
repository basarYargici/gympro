import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebBrowser(
          interactionSettings: const WebBrowserInteractionSettings(
            topBar: SizedBox.shrink(),
            bottomBar: SizedBox.shrink(),
          ),
          initialUrl: widget.url,
          javascriptEnabled: true,
        ),
      ),
    );
  }
}
