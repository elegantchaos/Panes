// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/05/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SplitView
import SwiftData
import SwiftUI

struct PaneView: View {
  @EnvironmentObject var models: ModelStore
  @ObservedObject var model: WebSession
  @State var modifiers: EventModifiers = []
  let focus: FocusBinding

  var body: some View {
    let isOptionDown = modifiers.contains(.option)
    let isCommandDown = modifiers.contains(.command)
    let isPanelSelected = focus.wrappedValue == model.position

    return
      WebView(viewModel: model)
      .focused(focus, equals: model.position)
      .onModifierKeysChanged { before, after in
        modifiers = after
      }
      .overlay(alignment: .bottomTrailing) {
        Text(model.label)
          .background(.white)
          .font(.footnote)
          .padding()
      }
      .overlay {
        if isPanelSelected {
          Rectangle()
            .stroke(Color.accentColor.opacity(0.5), lineWidth: 3)
        }
      }
      .overlay(alignment: .topTrailing) {
        if isPanelSelected && isCommandDown {
          Button(action: handleSplit) {
            Image(
              systemName: isOptionDown
                ? "rectangle.split.1x2" : "rectangle.split.2x1"
            )
          }
          .padding()
          .keyboardShortcut("|", modifiers: [.command])
//          .buttonStyle(.borderless)
        }
      }
      .overlay(alignment: .topLeading) {
        if isPanelSelected && isCommandDown {
          Button(action: handleSplit) {
            Image(systemName: "x.circle")
          }
          .padding()
          .keyboardShortcut(.delete, modifiers: [.command])
//          .buttonStyle(.borderless)
        }
      }

    func handleSplit() {
      let optionDown = modifiers.contains(.option)
      withAnimation {
        if let item = models.split(
          model.position,
          direction: optionDown ? .vertical : .horizontal
        ) {
          focus.wrappedValue = item
        }
      }
    }

    func handleDelete() {
      withAnimation {
        models.delete(model.position)
      }
    }

  }
}

#Preview {
  @Previewable @State var showOverlay: Bool = false
  @Previewable @State var pane = LayoutItem()
  @Previewable @State var models = ModelStore()
  @Previewable @FocusState var focus: LayoutItem?

  PaneView(model: models.model(for: pane), focus: $focus)
    .environmentObject(models)
//    .modelContainer(for: LayoutItem.self, inMemory: true)
}
