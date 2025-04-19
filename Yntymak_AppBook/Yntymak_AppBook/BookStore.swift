//
//  BookStore.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import Foundation
import SwiftUI

class BookStore: ObservableObject {
    @Published var books: [Book] = [] {
        didSet {
            saveBooks()
        }
    }

    private let booksKey = "SavedBooks"

    init() {
        loadBooks()
    }

    func addBook(_ book: Book) {
        if !books.contains(where: { $0.title == book.title }) {
            books.append(book)
        }
    }
    
    func removeBook(at offsets: IndexSet) {
        books.remove(atOffsets: offsets)
    }

    private func saveBooks() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(books) {
            UserDefaults.standard.set(encoded, forKey: booksKey)
            print("✅ Книги сохранены")
        } else {
            print("❌ Ошибка при сохранении книг")
        }
    }

    private func loadBooks() {
        if let savedData = UserDefaults.standard.data(forKey: booksKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Book].self, from: savedData) {
                self.books = decoded
                print("✅ Книги загружены")
                return
            }
        }

        // Если ничего не найдено — загружаем тестовые книги
        self.books = [
            Book(title: "Книга 1", coverURL: "https://covers.openlibrary.org/b/id/10523371-L.jpg", progress: 0.2),
            Book(title: "Книга 2", coverURL: "https://covers.openlibrary.org/b/id/10523372-L.jpg", progress: 0.7),
            Book(title: "Книга 3", coverURL: "https://covers.openlibrary.org/b/id/10523373-L.jpg", progress: 1.0)
        ]
        print("📘 Загружены стандартные книги")
    }
}
