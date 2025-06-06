// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 06/06/2025.
//  Copyright © 2025 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import SwiftUI
import SwiftData

struct BookmarksView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var bookmarks: [BookmarkItem]
  @Binding var activeSpace: BookmarkItem?
  
  var body: some View {
    HStack {
      ForEach(bookmarks) { bookmark in
        Button(action: { handleBookmarkTapped(bookmark) }) {
          Text(bookmark.name)
//            .bold(space == activeSpace)
        }
      }
    }
  }
  
  func handleBookmarkTapped(_ bookmark: BookmarkItem) {
//    activeSpace = space
  }
  
  private func addItem() {
    withAnimation {
      let newItem = BookmarkItem(name: "New Bookmark", url: URL(link: "elegantchaos.com"))
      modelContext.insert(newItem)
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(bookmarks[index])
      }
    }
  }
}
