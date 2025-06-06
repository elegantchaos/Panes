// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftData
import SwiftUI
import PanesCore
import Logger

let applicationChannel = Channel("Application")

@main
struct PanesApp: App {
  var sharedModelContainer = PanesModel.createContainer()
  let modelStore = ModelStore()
  @State var showOverlay = false

  init() {
    applicationChannel.log("Application started")
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView(showOverlay: $showOverlay)
    }
    .commands {
      CommandMenu("Stuff") {
        Button(action: handleToggleOverlay) {
          Text("Overlay")
        }
        .keyboardShortcut(KeyEquivalent("l"), modifiers: [.shift, .command])
      }
    }
    .environmentObject(modelStore)
    .modelContainer(sharedModelContainer)
  }

  func handleToggleOverlay() {
    applicationChannel.log("Toggling overlay")
      showOverlay.toggle()
  }
}
