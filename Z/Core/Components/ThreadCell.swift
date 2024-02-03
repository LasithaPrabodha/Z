//
//  ThreadCell.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ThreadCell: View {
    @StateObject var viewModel: ThreadCellViewModel
    let onCommentIconTapped: () -> Void
    let thread: Thread
    let isThreadView: Bool
    let isReply: Bool
    
    init(
        thread: Thread,
        isThreadView: Bool = false,
        isReply: Bool = false,
        onCommentIconTapped: @escaping () -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: ThreadCellViewModel(thread: thread))
        self.thread = thread
        self.isThreadView = isThreadView
        self.isReply = isReply
        self.onCommentIconTapped = onCommentIconTapped
    }
    
    
    @ViewBuilder
    private func destination() -> some View {
        if viewModel.isYourProfile {
            CurrentUserProfileView()
        } else {
            UserProfileView(user: thread.user!)
        }
    }
    
    var body: some View {
        
        VStack{
            HStack(alignment: .top, spacing: 12) {
                
                if !isThreadView {
                    NavigationLink(destination: self.destination()){
                        CircularProfileImageView(user: thread.user, size: .small)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        if isThreadView {
                            NavigationLink(destination: self.destination()){
                                CircularProfileImageView(user: thread.user, size: .small)
                            }
                        }
                        NavigationLink(destination: self.destination()){
                            Text(thread.user?.username ?? "")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                        
                    }
                    
                    Text(thread.caption)
                        .padding(.top, isThreadView ? 8 : 0)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16){
                        Button{
                            if viewModel.liked {
                                Task { try await viewModel.removeLike(threadId: thread.id, isReply) }
                            } else {
                                Task { try await viewModel.incrementLikes(threadId: thread.id, isReply) }
                            }
                            
                        } label: {
                            Image(systemName: viewModel.liked ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.liked ? .red : .black)
                        }
                        Button{
                            self.onCommentIconTapped()
                        }label: {
                            Image(systemName: "bubble.right")
                        }
                        Button{
                            
                        }label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button{
                            
                        }label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    
                    
                    HStack(spacing: 8){
                        if viewModel.likes > 0 {
                            Text("\(viewModel.likes) like\(viewModel.likes > 1 ? "s":"")")
                                .foregroundColor(Color(.systemGray))
                                .font(.caption2)
                        }
                        if viewModel.replies > 0 && viewModel.likes > 0 {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 4, height: 4)
                                .foregroundColor(Color(.systemGray4))
                        }
                        if viewModel.replies > 0 {
                            Text("\(viewModel.replies) replies")
                                .foregroundColor(Color(.systemGray))
                                .font(.caption2)
                        }
                        
                    }
                }
            }
            
            Divider()
        }
        .padding(.horizontal)
        .padding(.top, 10)
        
        
    }
}


#Preview {
    ThreadCell(thread: DeveloperPreview.shared.thread,isThreadView: false){}
}
