// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUICore

struct PaneContainer: View {
  @EnvironmentObject var nav: NavigationState
  let pane: PaneLayout
  
  var body: some View {
    pane.body
      .overlay {
        if nav.selection == pane.id {
          Rectangle()
            .stroke(Color.blue, lineWidth: 2)
        }
      }
  }
}

struct PaneView: View {
  @Environment(\.modelContext) private var modelContext
  let pane: PaneLayout
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      WebView(viewModel: pane.model)
      Text(pane.id.uuidString)
        .background(.white)
    }
  }
}
