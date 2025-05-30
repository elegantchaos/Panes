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

  init() {
    //    let layout = PaneLayout.horizontal([
    //      .single,
    //      .vertical([.single, .single]),
    //    ])
    //    _layout = .init(initialValue: layout)
    focus = items.first?.id
  }

  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var models: ModelStore
  @Query private var items: [LayoutItem]

  var body: some View {
    VStack {
      if let root = items.first {
        PaneContainer(focus: $focus, pane: root)
      }
      Text("\(items.count)")
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

        if let id = focus?.id {
          Text("\(id)")
        }
      }
    }.overlay {
      if showOverlay, let focus {
        Overlay(
          isVisible: $showOverlay,
          model: models.model(for: focus),
          focus: $focus
        )
      }
    }
  }

  var focussedURL: String {

    if let focus {
      return models.model(for: focus).link
    } else {
      return ""
    }
  }

  var root: LayoutItem? {
    items.first(where: { $0.kind == .root })
  }

  func handleToggleOverlay() {
    showOverlay.toggle()
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
