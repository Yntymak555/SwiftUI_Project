//
//  BookListView.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var store: BookStore

    var body: some View {
        NavigationStack {
            List {
                ForEach($store.books) { $book in
                    NavigationLink(destination: BookDetailView(book: $book)) {
                        HStack(alignment: .top, spacing: 16) {
                            AsyncImage(url: URL(string: book.coverURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray.opacity(0.2)
                            }
                            .frame(width: 60, height: 90)
                            .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(book.title)
                                    .font(.headline)

                                Text("Прогресс: \(Int(book.progress * 100))%")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                ProgressView(value: book.progress)
                                    .accentColor(.blue)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: store.removeBook)
            }
            .navigationTitle("Мои книги")
        }
    }
}

#Preview {
    BookListView(store: BookStore())
}
