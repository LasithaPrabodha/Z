//
//  ThreadCell.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ThreadCell: View {
    @StateObject var viewModel: ThreadCellViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    let thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        self._viewModel = StateObject(wrappedValue: ThreadCellViewModel(thread: thread))
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 12) {
                
                CircularProfileImageView(user: thread.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
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
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16){
                        Button{
                            if viewModel.liked {
                                Task { try await viewModel.removeLike(threadId: thread.id) }
                            } else {
                                Task { try await viewModel.incrementLikes(threadId: thread.id) }
                            }
                            
                        } label: {
                            Image(systemName: viewModel.liked ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.liked ? .red : .black)
                        }
                        Button{
                            feedViewModel.selectedThread = thread
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
                        Text("\(viewModel.likes) likes")
                            .foregroundColor(Color(.systemGray))
                            .font(.caption2)
                        
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                            .foregroundColor(Color(.systemGray4))
                           
                        
                        Text("2 replies")
                            .foregroundColor(Color(.systemGray))
                            .font(.caption2)
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
    ThreadCell(thread: DeveloperPreview.shared.thread)
}
