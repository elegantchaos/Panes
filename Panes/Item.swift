//
//  Item.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import Foundation
import SwiftData

@Model
final class LayoutItem {
  enum Kind: Codable {
    case root
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

