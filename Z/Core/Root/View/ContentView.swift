//
//  ContentView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel  = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ZTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
