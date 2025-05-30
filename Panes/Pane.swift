// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUICore

struct Pane: View {
  @Environment(\.modelContext) private var modelContext
  @State private var model = WebViewModel(link: "https://elegantchaos.com")
  
  var body: some View {
    WebView(viewModel: model)
  }
}
