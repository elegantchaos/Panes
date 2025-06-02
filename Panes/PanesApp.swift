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
  var sharedModelContainer = createModelContainer()
  let modelStore = ModelStore()
  @State var showOverlay = false

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
      showOverlay.toggle()
  }
  
  static let modelTypes: [any PersistentModel.Type] = [
    BookmarkItem.self,
    LayoutItem.self,
    SpaceItem.self,
    WindowItem.self
  ]
  
  static func createModelContainer() -> ModelContainer {
    let schema = Schema(modelTypes)

    let modelConfiguration = ModelConfiguration(
      schema: schema,
      isStoredInMemoryOnly: false
    )

    do {
      let container = try ModelContainer(
        for: schema,
        configurations: [modelConfiguration]
      )

      let context = container.mainContext
      try wipeData(context: context)
      if try !context.containsInstanceOf(LayoutItem.self) {
        initialiseData(context: context)
      }

      return container
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  
  }
  
  static func wipeData(context: ModelContext) throws {
    for type in modelTypes {
      try context.delete(model: type)
    }

  }
  
  static func initialiseData(context: ModelContext) {
    
    let homeRoot = LayoutItem(.leaf, content: [])
    let homeWindow = WindowItem(root: homeRoot)
    let home = SpaceItem(name: "Home", windows: [homeWindow])
    context.insert(homeRoot)
    context.insert(homeWindow)
    context.insert(home)

    let workRoot = LayoutItem(.leaf, content: [])
    let workWindow = WindowItem(root: workRoot)
    let work = SpaceItem(name: "Work", windows: [workWindow])
    context.insert(workRoot)
    context.insert(workWindow)
    context.insert(work)

    for link in ["elegantchaos.com", "apple.com", "bbc.co.uk", "github.com"] {
      if let url = URL(string: "https:/\(link)"), let name = link.split(separator: ".").first {
        let bookmark = BookmarkItem(name: String(name), url: url)
        context.insert(bookmark)
      }
    }
  }
}

extension ModelContext {
  func containsInstanceOf<T: PersistentModel>(_ model: T.Type) throws -> Bool {
    var itemFetchDescriptor = FetchDescriptor<T>()
    itemFetchDescriptor.fetchLimit = 1
    return try fetch(itemFetchDescriptor).count > 0
  }
}
