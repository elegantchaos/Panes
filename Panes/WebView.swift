import SwiftUI
import SwiftData
import WebKit



struct WebView: NSViewRepresentable {
  @ObservedObject var viewModel: WebViewModel

  private let webView: WKWebView = WKWebView()

  
  func makeNSView(context: Context) -> WKWebView {
    webView.navigationDelegate = context.coordinator
    webView.uiDelegate = context.coordinator as? WKUIDelegate
    webView.load(URLRequest(url: URL(string: viewModel.link)!))
    return webView
  }
  
  func updateNSView(_ webView: WKWebView, context: Context) {
    print("updated")
    if viewModel.link != webView.url?.absoluteString ?? "" {
      webView.load(URLRequest(url: URL(string: viewModel.link)!))
    }
  }
  
  public func makeCoordinator() -> Coordinator {
    return Coordinator(viewModel)
  }
  
  class Coordinator: NSObject, WKNavigationDelegate {
    private var viewModel: WebViewModel
    
    init(_ viewModel: WebViewModel) {
      //Initialise the WebViewModel
      self.viewModel = viewModel
    }
    
    public func webView(_: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      print("failed \(String(describing: navigation)) with \(error)")
    }
    
    public func webView(_: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      print(" provisional failed \(String(describing: navigation)) with \(error)")
    }
    
    //After the webpage is loaded, assign the data in WebViewModel class
    public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
      viewModel.pageTitle = web.title!
      viewModel.link = web.url?.absoluteString ?? ""
      viewModel.didFinishLoading = true
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      print("started provisional \(String(describing: navigation))")
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      print("decision for \(navigationAction)")
      decisionHandler(.allow)
    }
    
  }}
