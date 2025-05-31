// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

class ModelStore: ObservableObject {
  var models: [PersistentIdentifier:WebViewModel] = [:]

  func model(for layout: LayoutItem) -> WebViewModel {
    if let model = models[layout.id] {
      return model
    }
    
    let newModel = WebViewModel(link: "https://elegantchaos.com", layout: layout)
    models[layout.id] = newModel
    return newModel
  }

  func split(_ item: LayoutItem?, direction: LayoutItem.Kind) -> LayoutItem? {
    if let item, item.kind == .leaf {
      let originalLink = model(for: item).link
      let c1 = LayoutItem(.leaf)
      model(for: c1).link = originalLink
      let c2 = LayoutItem(.leaf)
      item.kind = direction
      item.children = [c1, c2]
      try? item.modelContext?.save()
      return c2
    }
    
    return nil
  }
  
  func delete(_ item: LayoutItem) {
    models.removeValue(forKey: item.id)
    item.modelContext?.delete(item)
    try? item.modelContext?.save()
  }
}
