//
//  PanesApp.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import SwiftData
import SwiftUI

@main
struct PanesApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      LayoutItem.self
    ])

    let modelConfiguration = ModelConfiguration(
      schema: schema,
      isStoredInMemoryOnly: false
    )

    do {
      let c = try ModelContainer(
        for: schema,
        configurations: [modelConfiguration]
      )

      try c.mainContext.delete(model: LayoutItem.self)
      var itemFetchDescriptor = FetchDescriptor<LayoutItem>()
      itemFetchDescriptor.fetchLimit = 1
      if try c.mainContext.fetch(itemFetchDescriptor).count == 0 {
        c.mainContext.insert(LayoutItem(.root, content: [
          LayoutItem(.leaf, content: [])
        ]))
      }

      return c
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  let modelStore = ModelStore()

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .environmentObject(modelStore)
    .modelContainer(sharedModelContainer)
  }
}
