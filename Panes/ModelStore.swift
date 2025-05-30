// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

class ModelStore: ObservableObject {
  var models: [PersistentIdentifier:WebViewModel] = [:]

  func model(for id: PersistentIdentifier) -> WebViewModel {
    if let model = models[id] {
      return model
    }
    
    let newModel = WebViewModel(link: "https://elegantchaos.com", layout: id)
    models[id] = newModel
    return newModel
  }

}
