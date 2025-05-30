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

  let pane: LayoutItem
  
  var body: some View {
    
    paneView
//      .overlay {
//        if focus.wrappedValue == pane.id {
//          Rectangle()
//            .stroke(Color.accentColor, lineWidth: 2)
//            .cornerRadius(8)
//        }
//      }
  }
  
  var paneView: some View {
    Group {
      switch pane.kind {
        case .root:
          if let root = pane.children.first {
            PaneView(pane: root, focus: focus)
          }
        case .leaf:
            PaneView(pane: pane, focus: focus)
          
        case .horizontal:
          if let left = pane.children.first, let right = pane.children.last {
            AnyView(
              HSplit(
                left: { PaneContainer(focus: focus, pane: left)
                },
                right: { PaneContainer(focus: focus, pane: right) })
            )
          } else {
            AnyView(HStack {
              ForEach(pane.children) { pane in PaneContainer(focus: focus, pane: pane) }
            })
          }
          
        case .vertical:
          if let top = pane.children.first, let bottom = pane.children.last {
            AnyView(VSplit(top: { PaneContainer(focus: focus, pane: top) }, bottom: { PaneContainer(focus: focus, pane: bottom) }))
          } else {
            AnyView(
              VStack {
                ForEach(pane.children) { pane in PaneContainer(focus: focus, pane: pane) }
              }
            )
          }
          
      }
      
    }
  }
}

struct PaneView: View {
  @EnvironmentObject var models: ModelStore
  @Environment(\.modelContext) private var modelContext
  let pane: LayoutItem
  let focus: FocusState<PersistentIdentifier?>.Binding

  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      WebView(viewModel: models.model(for: pane.id))
      Text("\(pane.id)")
        .background(.white)
        .font(.footnote)
    }
    .focusable()
    .focused(focus, equals: pane.id)
  }
}

