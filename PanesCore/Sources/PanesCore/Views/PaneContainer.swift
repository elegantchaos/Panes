// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 31/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SplitView
import SwiftData
import SwiftUI

struct PaneContainer: View {
  let focus: FocusBinding

  @EnvironmentObject var models: ModelStore
  @Bindable var pane: LayoutItem

  @State var modifiers: EventModifiers = []

  var body: some View {
    Group {
      switch pane.kind {
      case .leaf:
        PaneView(model: models.model(for: pane), focus: focus)

      case .horizontal:
//        if let left = pane.children.first, let right = pane.children.last {
//          HSplit(
//            left: {
//              PaneContainer(focus: focus, pane: left)
//            },
//            right: { PaneContainer(focus: focus, pane: right) }
//          )
//        } else {
          HStack {
            ForEach(pane.children) { pane in
              PaneContainer(focus: focus, pane: pane)
            }
          }
//        }

      case .vertical:
//        if let top = pane.children.first, let bottom = pane.children.last {
//          VSplit(
//            top: { PaneContainer(focus: focus, pane: top) },
//            bottom: { PaneContainer(focus: focus, pane: bottom) }
//          )
//        } else {
          VStack {
            ForEach(pane.children) { pane in
              PaneContainer(focus: focus, pane: pane)
            }
          }
//        }

      }

    }
  }
}
