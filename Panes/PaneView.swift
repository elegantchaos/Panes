// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUI
import SplitView
import SwiftData

struct PaneContainer: View {
  let focus: FocusState<PersistentIdentifier?>.Binding

  @Bindable var pane: LayoutItem
  
  var body: some View {
    
    paneView
      .overlay {
        if focus.wrappedValue == pane.id {
          Rectangle()
            .stroke(Color.accentColor, lineWidth: 3)
        }
      }
  }
  
  var paneView: some View {
    Group {
      switch pane.kind {
        case .root:
          if let root = pane.children.first {
            PaneContainer(focus: focus, pane: root)
          }

        case .leaf:
            PaneView(pane: pane, focus: focus)
          
        case .horizontal:
          if let left = pane.children.first, let right = pane.children.last {
              HSplit(
                left: { PaneContainer(focus: focus, pane: left)
                },
                right: { PaneContainer(focus: focus, pane: right) })
          } else {
            HStack {
              ForEach(pane.children) { pane in PaneContainer(focus: focus, pane: pane) }
            }
          }
          
        case .vertical:
          if let top = pane.children.first, let bottom = pane.children.last {
            VSplit(top: { PaneContainer(focus: focus, pane: top) }, bottom: { PaneContainer(focus: focus, pane: bottom) })
          } else {
              VStack {
                ForEach(pane.children) { pane in PaneContainer(focus: focus, pane: pane) }
              }
          }
          
      }
      
    }
  }
}

struct PaneView: View {
  @EnvironmentObject var models: ModelStore
  @Environment(\.modelContext) private var modelContext
  @Bindable var pane: LayoutItem
  let focus: FocusState<PersistentIdentifier?>.Binding

  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      WebView(viewModel: models.model(for: pane.id))
      Text("\(pane.id)")
        .background(.white)
        .font(.footnote)
    }
    .focused(focus, equals: pane.id)
  }
}

