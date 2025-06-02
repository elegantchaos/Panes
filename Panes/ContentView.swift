//
//  ContentView.swift
//  Panes
//
//  Created by Sam Deane on 30/05/2025.
//

import SwiftData
import SwiftUI

typealias FocusBinding = FocusState<LayoutItem?>.Binding

struct ContentView: View {
  //  @State var layout: PaneLayout

  @Binding var showOverlay: Bool
  @FocusState var focus: LayoutItem?
  @State var overlayModel: WebViewModel?

  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var models: ModelStore
  @Query private var items: [LayoutItem]
  @Query private var spaces: [SpaceItem]

  var body: some View {
    VStack {
      if let root {
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
    }
    .toolbar {
//      ToolbarItem(placement: .navigation) {
//        Button(action: handleToggleOverlay) {
//          Text("Overlay")
//        }
//        .keyboardShortcut(KeyEquivalent("l"), modifiers: [.shift, .command])
//      }
//
      ToolbarItem {
        ForEach(spaces) { space in
          Button(action: handleSpaceTapped) {
            Text(space.name)
          }
        }
      }
    }

    .navigationTitle(focusLabel)
    .onChange(of: focus) {
      if let focus {
        overlayModel = models.model(for: focus)
      }
    }
  }

  var focusLabel: String {
    if let overlayModel {
      return "Panes: \(overlayModel.label)"
    } else {
      return "Panes"
    }
  }

  var root: LayoutItem? {
    spaces.first?.windows.first?.root
  }

  func handleToggleOverlay() {
    if focus != nil {
      showOverlay.toggle()
    }
  }

  func handleSpaceTapped() {
    
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
  @Previewable @State var showOverlay: Bool = false
  ContentView(showOverlay: $showOverlay)
    .modelContainer(for: LayoutItem.self, inMemory: true)
}
