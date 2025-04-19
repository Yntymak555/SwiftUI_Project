//
//  BookDetailView.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book
    @State private var isReading = false

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: book.coverURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 300)
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: 200, height: 300)
            }

            Text(book.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)

            VStack(spacing: 6) {
                Text("Прогресс: \(Int(book.progress * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Slider(value: $book.progress, in: 0...1)
                    .accentColor(.blue)
            }
            .padding(.horizontal)

            Button("Читать") {
                isReading = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Инфо о книге")
        .navigationDestination(isPresented: $isReading) {
            ReaderView(book: book)
        }
    }
}

#Preview {
    // Временный контейнер с @State
    struct PreviewWrapper: View {
        @State var previewBook = Book(
            title: "Пример книги",
            coverURL: "https://covers.openlibrary.org/b/id/10523371-L.jpg",
            progress: 0.4
        )

        var body: some View {
            NavigationStack {
                BookDetailView(book: $previewBook)
            }
        }
    }

    return PreviewWrapper()
}
