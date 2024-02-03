//
//  ThreadView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-02-03.
//

import SwiftUI

struct ThreadView: View {
    @State var showAddComment = false
    @State var selectedReply: Thread? = nil;
    @StateObject var viewModel: ThreadViewModel
    
    let thread: Thread
    
    init(thread: Thread){
        self._viewModel = StateObject(wrappedValue: ThreadViewModel(thread: thread))
        self.thread = thread
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ThreadCell(thread: thread, isThreadView: true){
                self.showAddComment.toggle()
            }
            LazyVStack {
                ForEach(viewModel.replies) { reply in
                    ThreadCell(thread: reply, isReply: true){
                        self.selectedReply = reply
                    }
                }
                .sheet(item: $selectedReply, content: { thread in
                    CommentView(thread: thread, isReply: true)
                   
                })
            }
        }
        .sheet(isPresented: $showAddComment, content: {
            CommentView(thread: self.thread)
           
        })
        .navigationTitle("Thread")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ThreadView(thread: DeveloperPreview.shared.thread)
}
