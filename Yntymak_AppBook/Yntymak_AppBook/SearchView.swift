//
//  SearchView.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var results: [Book] = []
    @State private var addedBookIDs: Set<UUID> = []
    @State private var showConfirmation = false

    @ObservedObject var store: BookStore

    var body: some View {
        VStack {
            HStack {
                TextField("Поиск книги", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Button("Поиск") {
                    searchBooks()
                }
            }
            .padding()

            List(results) { book in
                HStack {
                    if let url = URL(string: book.coverURL), !book.coverURL.isEmpty {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 70)
                        } placeholder: {
                            Color.gray.frame(width: 50, height: 70)
                        }
                    } else {
                        Color.gray.frame(width: 50, height: 70)
                    }

                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)

                        if addedBookIDs.contains(book.id) || store.books.contains(where: { $0.title == book.title }) {
                            Text("✅ Добавлено")
                                .font(.caption)
                                .foregroundColor(.green)
                        } else {
                            Button("Добавить") {
                                store.addBook(book)
                                addedBookIDs.insert(book.id)
                                showConfirmation = true

                                // Автоубрать сообщение через 2 сек
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showConfirmation = false
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                    }
                    .padding(.leading, 10)
                }
            }

            if showConfirmation {
                Text("📚 Книга добавлена!")
                    .padding(10)
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showConfirmation)
            }
        }
        .navigationTitle("Поиск книг")
    }

    private func searchBooks() {
        GoogleBooksAPI.shared.searchBooks(query: query) { books in
            print("🔍 Получено книг: \(books.count)")
            self.results = books
        }
    }
}

#Preview {
    SearchView(store: BookStore())
}

