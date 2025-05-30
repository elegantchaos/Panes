//
//  ContentView.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @State var layout: PaneLayout = .horizontal([
    .single,
    .vertical([.single, .single]),
  ])

  @State var showOverlay = false
  
  //  @Environment(\.modelContext) private var modelContext
  //  @Query private var items: [Item]

  var body: some View {
    VStack {
      layout.body
      Button(action: handleToggleOverlay) {
        Text("Overlay")
      }
      .keyboardShortcut(KeyEquivalent("l"), modifiers: [.shift, .command])
    }.overlay {
      if showOverlay {
        Text("Overlay")
          .font(.headline)
          .padding(20)
          .background(
            Rectangle()
              .fill(Color.gray)
              .cornerRadius(8)
          )
      }
    }
  }
  
  func handleToggleOverlay() {
    showOverlay.toggle()
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
