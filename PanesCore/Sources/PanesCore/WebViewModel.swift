// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 31/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public class WebViewModel: ObservableObject {
  @Published var url: URL
  @Published var didFinishLoading: Bool = false
  @Published var pageTitle: String
  @Published var layout: LayoutItem

  init (_ url: URL, layout: LayoutItem) {
    self.url = url
    self.pageTitle = ""
    self.layout = layout
  }
  
  var label: String {
    pageTitle.isEmpty ? url.absoluteString : pageTitle
  }
}
