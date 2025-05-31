//
//  ContentView.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  //  @State var layout: PaneLayout

  @State var showOverlay = false
  @FocusState var focus: PersistentIdentifier?
  @State var overlayModel: WebViewModel?
  
  init() {
  }

  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var models: ModelStore
  @Query private var items: [LayoutItem]

  var body: some View {
    VStack {
      if let root = items.first {
        PaneContainer(focus: $focus, pane: root)
          .overlay {
            if showOverlay, let overlayModel {
              Overlay(
                isVisible: $showOverlay,
                model: overlayModel,
                focus: $focus
              )
            }
          }
      }
      HStack {
        Button(action: handleToggleOverlay) {
          Text("Overlay")
        }
        .keyboardShortcut(KeyEquivalent("l"), modifiers: [.shift, .command])

        if let item = focussedItem {
          Text(models.model(for: item).label)
        }
      }
    }
  }

  var focussedItem: LayoutItem? {
    guard let focus, let item = items.first(where: { $0.id == focus }) else {
      return nil
    }
    return item
  }

  var focusLabel: String {
    if let item = focussedItem {
      return "\(item.kind) \(item.id.id)"
    } else {
      return ""
    }
  }

  var root: LayoutItem? {
    items.first(where: { $0.kind == .root })
  }

  func handleToggleOverlay() {
    if let item = focussedItem {
      if !showOverlay {
        overlayModel = models.model(for: item)
      }
      showOverlay.toggle()
    }
  }

  func handleSplitRight() {
    if let item = models.split(focussedItem, direction: .horizontal) {
      focus = item.id
    }
  }

  func handleSplitDown() {
    if let item = models.split(focussedItem, direction: .vertical) {
      focus = item.id
    }
  }

  //  func handleSelectNext() {
  //    if let current = focus {
  //      focus = layout.nextSelectionAfter(current)
  //    } else {
  //      focus = layout.id
  //    }
  //  }

  //  private func addItem() {
  //    withAnimation {
  //      let newItem = Item(timestamp: Date())
  //      modelContext.insert(newItem)
  //    }
  //  }
  //
  //  private func deleteItems(offsets: IndexSet) {
  //    withAnimation {
  //      for index in offsets {
  //        modelContext.delete(items[index])
  //      }
  //    }
  //  }
}

#Preview {
  ContentView()
    .modelContainer(for: LayoutItem.self, inMemory: true)
}
