// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 06/06/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftData

public struct PanesModel {
  @MainActor public static func createContainer() -> ModelContainer {
    let schema = Schema(Self.modelTypes)
    
    let modelConfiguration = ModelConfiguration(
      schema: schema,
      isStoredInMemoryOnly: false
    )
    
    do {
      let container = try ModelContainer(
        for: schema,
        configurations: [modelConfiguration]
      )
  
      try setup(context: container.mainContext)
      return container
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
  
  @MainActor static func setup(context: ModelContext) throws {
    try wipeData(context: context)
    if try !context.containsInstanceOf(LayoutItem.self) {
      initialiseData(context: context)
    }
  }
  
  static func wipeData(context: ModelContext) throws {
    for type in Self.modelTypes {
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
  
  static let modelTypes: [any PersistentModel.Type] = [
    BookmarkItem.self,
    LayoutItem.self,
    SpaceItem.self,
    WindowItem.self
  ]
}
