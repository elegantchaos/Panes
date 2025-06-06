// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 06/06/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUI
import SwiftData

struct SpacesView: View {
  @Query private var spaces: [SpaceItem]
  @Binding var activeSpace: SpaceItem?

  var body: some View {
    HStack {
      ForEach(spaces) { space in
        Button(action: { handleSpaceTapped(space) }) {
          Text(space.name)
            .bold(space == activeSpace)
        }
      }
    }
  }
  
  func handleSpaceTapped(_ space: SpaceItem) {
    activeSpace = space
  }
}
