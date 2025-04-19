//
//  Book.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import Foundation

struct Book: Identifiable, Codable {
    let id: UUID
    let title: String
    let coverURL: String
    var progress: Double // от 0.0 до 1.0

    init(id: UUID = UUID(), title: String, coverURL: String, progress: Double) {
        self.id = id
        self.title = title
        self.coverURL = coverURL
        self.progress = progress
    }
}
