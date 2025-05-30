// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

class ModelStore: ObservableObject {
  var models: [PersistentIdentifier:WebViewModel] = [:]

  func model(for id: PersistentIdentifier) -> WebViewModel {
    models[id, default: WebViewModel(link: "https://elegantchaos.com", layout: id)]
  }

}
