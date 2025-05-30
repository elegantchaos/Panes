// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUICore



struct PaneLayout: Identifiable {
  let id = UUID()
  let kind: Kind
  let content: [PaneLayout]
  
  enum Kind {
    case single
    case horizontal
    case vertical
  }
  
  init(_ layout: Kind = .single, content: [PaneLayout] = []) {
    self.kind = layout
    self.content = content
  }
  
  static var single: PaneLayout {
    .init()
  }
  
  static func horizontal(_ content: [PaneLayout]) -> PaneLayout {
    .init(.horizontal, content: content)
  }
  
  static func vertical(_ content: [PaneLayout]) -> PaneLayout {
    .init(.vertical, content: content)
  }
  
  var body: some View {
    switch kind {
      case .single:
        AnyView(Pane())
        
      case .horizontal:
        AnyView(
          HStack {
            ForEach(content) { pane in pane.body }
          }
        )
        
      case .vertical:
        AnyView(
          VStack {
            ForEach(content) { pane in pane.body }
          }
        )
        
    }
  }
}
