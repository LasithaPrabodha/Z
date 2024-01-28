//
//  FeedView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threads){ thread in
                        ThreadCell(thread: thread)
                            .environmentObject(viewModel)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddComment, content: {
                if let thread = viewModel.selectedThread {
                    CommentView(thread: thread)
                }
            })
            .refreshable {
                Task { try await viewModel.fetchThreads()} 
            }
            .navigationTitle("Feeds")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        FeedView()
    }
}
