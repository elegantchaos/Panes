//
//  ContentView.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @State var layout: PaneLayout
  let nav: NavigationState

  @State var showOverlay = false

  init() {
    let nav = NavigationState()
    let layout = PaneLayout.horizontal([
      .single,
      .vertical([.single, .single]),
    ])
    nav.selection = layout.nextSelectionAfter(layout.id)

    _layout = .init(initialValue: layout)
    self.nav = nav
  }
  
  //  @Environment(\.modelContext) private var modelContext
  //  @Query private var items: [Item]

  var body: some View {
    VStack {
      PaneContainer(pane: layout)
      HStack {
        Button(action: handleToggleOverlay) {
          Text("Overlay")
        }
        .keyboardShortcut(KeyEquivalent("l"), modifiers: [.shift, .command])

        Button(action: handleSelectNext) {
          Text("Next")
        }
        .keyboardShortcut(.tab)

        Text(nav.selection?.uuidString ?? "No selection")
      }
    }.overlay {
      if showOverlay {
        Overlay(layout: $layout, url: layout.layoutWithID(nav.selection)?.model.link ?? "")
      }
    }
    .environmentObject(nav)
  }

  func handleToggleOverlay() {
    showOverlay.toggle()
  }

  func handleSelectNext() {
    if let current = nav.selection {
      nav.selection = layout.nextSelectionAfter(current)
    } else {
      nav.selection = layout.id
    }
  }
  
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
    .modelContainer(for: Item.self, inMemory: true)
}
