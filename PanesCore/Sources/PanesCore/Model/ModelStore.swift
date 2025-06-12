// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

public class ModelStore: ObservableObject {
  var models: [PersistentIdentifier:WebSession] = [:]

  public init() {
  }
  
  public func model(for layout: LayoutItem) -> WebSession {
    if let model = models[layout.id] {
      return model
    }
    
    let newModel = WebSession(URL(link: "elegantchaos.com"), layout: layout)
    models[layout.id] = newModel
    return newModel
  }

  public func split(_ item: LayoutItem?, direction: LayoutItem.Kind) -> LayoutItem? {
    
    if let item, item.kind == .leaf, let context = item.modelContext {
      let originalLink = model(for: item).url
      let c1 = LayoutItem(.leaf)
      model(for: c1).url = originalLink
      let c2 = LayoutItem(.leaf)
      item.kind = direction
      item.children = [c1, c2]
      context.insert(c1)
      context.insert(c2)
      try? item.modelContext?.save()
      return c2
    }
    
    return nil
  }
  
  public func delete(_ item: LayoutItem) {
    models.removeValue(forKey: item.id)
    item.modelContext?.delete(item)
    try? item.modelContext?.save()
  }
}
