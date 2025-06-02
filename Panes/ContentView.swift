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
  @State var activeSpace: SpaceItem?

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
                activeSpace: $activeSpace,
                model: overlayModel,
                focus: $focus
              )
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
    let space = activeSpace ?? spaces.first
    return space?.windows.first?.root
  }

  func handleToggleOverlay() {
    if focus != nil {
      showOverlay.toggle()
    }
  }


}

#Preview {
  @Previewable @State var showOverlay: Bool = false
  ContentView(showOverlay: $showOverlay)
    .modelContainer(for: LayoutItem.self, inMemory: true)
}
