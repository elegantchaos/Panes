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

  @State var showOverlay = false
  @FocusState var focus: UUID?
  
  init() {
    let layout = PaneLayout.horizontal([
      .single,
      .vertical([.single, .single]),
    ])
    _layout = .init(initialValue: layout)
    focus = layout.nextSelectionAfter(layout.id)
  }
  
  //  @Environment(\.modelContext) private var modelContext
  //  @Query private var items: [Item]

  var body: some View {
    VStack {
      PaneContainer(focus: $focus, pane: layout)
      HStack {
        Button(action: handleToggleOverlay) {
          Text("Overlay")
        }
        .keyboardShortcut(KeyEquivalent("l"), modifiers: [.shift, .command])
//
//        Button(action: handleSelectNext) {
//          Text("Next")
//        }
//        .keyboardShortcut(.tab)

        Text(focus?.uuidString ?? "No selection")
      }
    }.overlay {
      if showOverlay {
        Overlay(
          isVisible: $showOverlay,
          layout: $layout,
          url: layout.layoutWithID(focus)?.model.link ?? "",
          focus: $focus
        )
      }
    }
  }

  func handleToggleOverlay() {
    showOverlay.toggle()
  }

  func handleSelectNext() {
    if let current = focus {
      focus = layout.nextSelectionAfter(current)
    } else {
      focus = layout.id
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
