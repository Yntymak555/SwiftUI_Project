//
//  GoogleBooksAPI.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import Foundation

struct GoogleBookItem: Decodable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let imageLinks: ImageLinks?
}

struct ImageLinks: Decodable {
    let thumbnail: String
}

struct GoogleBooksResponse: Decodable {
    let items: [GoogleBookItem]
}

class GoogleBooksAPI {
    static let shared = GoogleBooksAPI()

    func searchBooks(query: String, completion: @escaping ([Book]) -> Void) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)&key=AIzaSyAoWV2jI2eRNguU_YGP9qkaDIL86g8x0cU"

        guard let url = URL(string: urlString) else {
            print("❌ Ошибка создания URL")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Ошибка при запросе: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("❌ Нет данных от сервера")
                completion([])
                return
            }

            do {
                let books = try self.parseBooks(from: data)
                DispatchQueue.main.async {
                    completion(books)
                }
            } catch {
                print("❌ Ошибка при парсинге JSON: \(error)")
                completion([])
            }
        }.resume()
    }

    private func parseBooks(from data: Data) throws -> [Book] {
        let decoded = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
        return decoded.items.map {
            let httpsCoverURL = $0.volumeInfo.imageLinks?.thumbnail
                .replacingOccurrences(of: "http://", with: "https://") ?? ""

            print("📚 \( $0.volumeInfo.title ) – \(httpsCoverURL)")

            return Book(
                title: $0.volumeInfo.title,
                coverURL: httpsCoverURL,
                progress: 0
            )
        }
    }
}
