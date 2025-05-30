// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUICore


struct PaneLayout: Identifiable {
  let id = UUID()
  let kind: Kind
  let model: WebViewModel
  let children: [PaneLayout]
  
  enum Kind {
    case single
    case horizontal
    case vertical
  }
  
  init(_ layout: Kind = .single, content: [PaneLayout] = []) {
    self.kind = layout
    self.children = content
    self.model = WebViewModel(link: "https://elegantchaos.com")
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
  
  func contentDepthFirst() -> [UUID] {
    var results : [UUID] = []
    if kind == .single {
      results.append(id)
    }
    for child in children {
      results.append(contentsOf: child.contentDepthFirst())
    }
    return results
  }
  
  func layoutWithID(_ id: UUID?) -> PaneLayout? {
    if self.id == id {
      return self
    }
    for child in children {
      if let found = child.layoutWithID(id) {
        return found
      }
    }
    return nil
  }
  
  func nextSelectionAfter(_ id: UUID) -> UUID? {
    let items = contentDepthFirst()
    if let index = items.firstIndex(of: id) {
      return items[(index + 1) % items.count]
    } else {
      return items.first
    }
  }
}
