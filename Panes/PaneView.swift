// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUICore
import SplitView

struct PaneContainer: View {
  @EnvironmentObject var nav: NavigationState
  let pane: PaneLayout
  
  var body: some View {
    
    paneView
      .overlay {
        if nav.selection == pane.id {
          Rectangle()
            .stroke(Color.blue, lineWidth: 2)
        }
      }
  }
  
  var paneView: some View {
    switch pane.kind {
      case .single:
        AnyView(PaneView(pane: pane))
        
      case .horizontal:
          if let left = pane.children.first, let right = pane.children.last {
            AnyView(HSplit(left: { PaneContainer(pane: left) }, right: { PaneContainer(pane: right) }))
          } else {
            AnyView(HStack {
              ForEach(pane.children) { pane in PaneContainer(pane: pane) }
            })
          }
        
      case .vertical:
        if let top = pane.children.first, let bottom = pane.children.last {
          AnyView(VSplit(top: { PaneContainer(pane: top) }, bottom: { PaneContainer(pane: bottom) }))
        } else {
          AnyView(
            VStack {
              ForEach(pane.children) { pane in PaneContainer(pane: pane) }
            }
          )
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
