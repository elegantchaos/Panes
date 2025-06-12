import Logger
import SwiftData
import SwiftUI
import WebKit

let webviewChannel = Channel("WebView")

struct WebView: NSViewRepresentable {
  @ObservedObject var viewModel: WebSession

  private let webView: WKWebView = WKWebView()


  func makeNSView(context: Self.Context) -> WKWebView {
    webView.navigationDelegate = context.coordinator
    webView.uiDelegate = context.coordinator as? WKUIDelegate
    webView.load(URLRequest(url: viewModel.url))
    return webView
  }

  func updateNSView(_ webView: WKWebView, context: Self.Context) {
    webviewChannel.log("updated")
    if viewModel.url != webView.url {
      webView.load(URLRequest(url: viewModel.url))
    }
  }

  public func makeCoordinator() -> Coordinator {
    return Coordinator(viewModel)
  }

  class Coordinator: NSObject, WKNavigationDelegate {
    private var viewModel: WebSession

    init(_ viewModel: WebSession) {
      //Initialise the WebSession
      self.viewModel = viewModel
    }

    public func webView(_: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      webviewChannel.log("failed \(String(describing: navigation)) with \(error)")
    }

    public func webView(_: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      webviewChannel.log(" provisional failed \(String(describing: navigation)) with \(error)")
    }

    public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
      viewModel.title = web.title ?? viewModel.title
      viewModel.url = web.url ?? viewModel.url
      viewModel.state = .loaded
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      webviewChannel.log("started provisional \(String(describing: navigation))")
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor @Sendable (WKNavigationActionPolicy) -> Void) {
      webviewChannel.log("decision for \(navigationAction)")
      decisionHandler(.allow)
    }

  }
}
