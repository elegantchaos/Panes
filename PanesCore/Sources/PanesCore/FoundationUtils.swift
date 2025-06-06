// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 06/06/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

extension URL {
  init(link: String) {
    self.init(string: "https://\(link)")!
  }
}

extension ModelContext {
  func containsInstanceOf<T: PersistentModel>(_ model: T.Type) throws -> Bool {
    var itemFetchDescriptor = FetchDescriptor<T>()
    itemFetchDescriptor.fetchLimit = 1
    return try fetch(itemFetchDescriptor).count > 0
  }
}
