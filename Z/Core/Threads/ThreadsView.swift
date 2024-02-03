//
//  FeedView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ThreadsView: View {
    @StateObject var viewModel = ThreadsViewModel()

    @State var selectedThread: Thread? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threads){ thread in
                        NavigationLink(destination: ThreadView(thread: thread)){
                            ThreadCell(thread: thread) {
                                self.selectedThread = thread
                            }
                        }
                        
                    }
                }
            }
            .sheet(item: $selectedThread, content: { thread in
                CommentView(thread: thread)
            })
            .refreshable {
                Task { try await viewModel.fetchThreads()}
            }
            .navigationTitle("Threads")
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
        ThreadsView(selectedThread: DeveloperPreview.shared.thread)
    }
}
