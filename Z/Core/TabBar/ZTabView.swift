//
//  ZTabView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ZTabView: View {
    @State private var selectedTab = 0
    @State private var mostRecentTab = 0
    @State private var showThreadreationView = false
    
    init() {
        Task{ try await UserService.shared.fetchCurrentUser() }
    }
    
    var body: some View {
        TabView(selection: $selectedTab)  {
            ThreadsView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" :"house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear{ selectedTab = 0}
                .tag(0)
            
            ExploreView()
                .tabItem {
                   Image(systemName: "magnifyingglass")
                }
                .onAppear{ selectedTab = 1}
                .tag(1)
            
            Text("")
                .tabItem {
                   Image(systemName: "plus")
                }
                .onAppear{ selectedTab = 2}
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill":"heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear{ selectedTab = 3}
                .tag(3)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill":"person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear{ selectedTab = 4}
                .tag(4)
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            mostRecentTab = oldValue
            showThreadreationView = selectedTab == 2
        }
        .sheet(isPresented: $showThreadreationView, onDismiss: {
            selectedTab = mostRecentTab
        }, content: {
            ThreadCreationView()
        })
        .tint(.black)
    }
}

#Preview {
    ZTabView()
}
