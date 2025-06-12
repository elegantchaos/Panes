// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

@Model public final class LayoutItem {
  public enum Kind: Codable {
    case leaf
    case horizontal
    case vertical
  }

  var kind: Kind
  var children: [LayoutItem]

  init(_ layout: Kind = .leaf, content: [LayoutItem] = []) {
    self.kind = layout
    self.children = content
  }
}

