// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 31/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

class WebViewModel: ObservableObject {
  @Published var link: String
  @Published var didFinishLoading: Bool = false
  @Published var pageTitle: String
  @Published var layout: LayoutItem

  init (link: String, layout: LayoutItem) {
    self.link = link
    self.pageTitle = ""
    self.layout = layout
  }
  
  var label: String {
    pageTitle.isEmpty ? link : pageTitle
  }
}
