import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
  @Published var link: String
  @Published var didFinishLoading: Bool = false
  @Published var pageTitle: String
  
  init (link: String) {
    self.link = link
    self.pageTitle = ""
  }
}

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
    
    public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) {
      print("blah")

    }
    
    public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) {
      print("blah")

    }
    
    //After the webpage is loaded, assign the data in WebViewModel class
    public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
      self.viewModel.pageTitle = web.title!
      self.viewModel.link = web.url?.absoluteString ?? ""
      self.viewModel.didFinishLoading = true
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      print("blah")
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      decisionHandler(.allow)
    }
    
  }}
