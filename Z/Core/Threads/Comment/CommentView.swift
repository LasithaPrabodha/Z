//
//  CommentView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: CommentViewModel
    let isParentReply: Bool
    
    
    init(thread: Thread, isReply: Bool = false){
        self._viewModel = StateObject(wrappedValue: CommentViewModel(thread: thread))
        self.isParentReply = isReply
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack(alignment: .top, spacing: 12) {
                    VStack {
                        CircularProfileImageView(user: viewModel.thread.user, size: .small)
                        
                        Rectangle()
                            .frame(width: 2, height: 25)
                            .foregroundColor(.gray)
                            .opacity(0.2)
                    }
                    
                    VStack(alignment: .leading, spacing: 4){
                        HStack {
                            Text(viewModel.thread.user?.username ?? "")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            
                        }
                        
                        Text(viewModel.thread.caption)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                HStack(alignment: .top, spacing: 12) {
                    CircularProfileImageView(user: viewModel.replier, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4){
                        HStack {
                            Text(viewModel.replier.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            
                        }
                        
                        TextField("Add your reply", text: $viewModel.reply, axis: .vertical)
                            .font(.footnote)
                        
                    }
                    
                }
                .padding(.horizontal)
               
                
                Spacer()
                
            }
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Post"){
                        Task{
                            try await viewModel.postReply(isParentReply: isParentReply)
                            dismiss()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
        
        
    }
}

#Preview {
    CommentView(thread: DeveloperPreview.shared.thread)
}
