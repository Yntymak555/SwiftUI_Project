//
//  ReaderView.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import SwiftUI

struct ReaderView: View {
    var book: Book

    var body: some View {
        VStack(spacing: 20) {
            Text("Чтение книги")
                .font(.largeTitle)
                .bold()

            Text(book.title)
                .font(.title2)
                .multilineTextAlignment(.center)

            Spacer()
            Text("📖 Здесь будет экран чтения книги...")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationTitle("Чтение")
    }
}

#Preview {
    ReaderView(book: Book(
        title: "Пример книги",
        coverURL: "https://covers.openlibrary.org/b/id/10523371-L.jpg",
        progress: 0.5
    ))
}
