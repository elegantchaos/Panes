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

  //  @Environment(\.modelContext) private var modelContext
  //  @Query private var items: [Item]

  var body: some View {
    layout.body
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
