import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'home/hook.dart';
import 'location.dart';

class MyWebview extends StatefulWidget {
  const MyWebview({super.key, required this.identity});

  final String identity;

  @override
  State<StatefulWidget> createState() => _MyWebviewState();
}

class _MyWebviewState extends State<MyWebview> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String tydUrl = "";
  double progress = 0;
  final urlController = TextEditingController();

  void _refresh() {
    getLocation().then(
      (value) => webViewController?.loadUrl(
        urlRequest: URLRequest(
          url: Uri.parse(
              "https://tydwin.top/map#/${value.longitude}/${value.latitude}"),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onClear() {
      clearLocation(widget.identity)
          .then((value) => showEntry(context, 'clear ok'));
    }

    void onSave() {
      postLocation(widget.identity)
          .then((value) => showEntry(context, 'save ok'));
    }

    return Scaffold(
      // appBar: AppBar(title: const Text("Official InAppWebView website")),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // TextField(
            //   decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
            //   controller: urlController,
            //   keyboardType: TextInputType.url,
            //   onSubmitted: (value) {
            //     var url = Uri.parse(value);
            //     if (url.scheme.isEmpty) {
            //       url = Uri.parse("https://www.google.com/search?q=$value");
            //     }
            //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
            //   },
            // ),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    // initialUrlRequest:
                    //     URLRequest(url: Uri.parse("https://inappwebview.dev/")),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        tydUrl = url.toString();
                        urlController.text = tydUrl;
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        return NavigationActionPolicy.CANCEL;
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();
                      setState(() {
                        tydUrl = url.toString();
                        urlController.text = tydUrl;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = tydUrl;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      setState(() {
                        tydUrl = url.toString();
                        urlController.text = tydUrl;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
            ),
            // ButtonBar(
            //   alignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     ElevatedButton(
            //       child: const Icon(Icons.arrow_back),
            //       onPressed: () {
            //         webViewController?.goBack();
            //       },
            //     ),
            //     ElevatedButton(
            //       child: const Icon(Icons.arrow_forward),
            //       onPressed: () {
            //         webViewController?.goForward();
            //       },
            //     ),
            //     ElevatedButton(
            //       child: const Icon(Icons.refresh),
            //       onPressed: () {
            //         webViewController?.reload();
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Back',
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Back',
            child: const Icon(Icons.home),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'Clear',
            onPressed: onClear,
            tooltip: 'Clear',
            child: const Icon(Icons.clear_all),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'Save',
            onPressed: onSave,
            tooltip: 'Save',
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'Refresh',
            onPressed: _refresh,
            tooltip: 'Refresh',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
