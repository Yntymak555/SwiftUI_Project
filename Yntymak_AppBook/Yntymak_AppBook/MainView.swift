//
//  MainView.swift
//  Yntymak_AppBook
//
//  Created by Smart Castle M1A2007 on 19.04.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var store = BookStore()

    var body: some View {
        TabView {
            BookListView(store: store)
                .tabItem {
                    Label("Книги", systemImage: "book")
                }

            SearchView(store: store) // 👈 Передаём хранилище книг
                .tabItem {
                    Label("Поиск", systemImage: "magnifyingglass")
                }

            Text("Категории")
                .tabItem {
                    Label("Категории", systemImage: "square.grid.2x2")
                }

            Text("Сессии")
                .tabItem {
                    Label("Сессии", systemImage: "calendar")
                }

            Text("Профиль")
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
        }
    }
}
#Preview {
    MainView()
}
