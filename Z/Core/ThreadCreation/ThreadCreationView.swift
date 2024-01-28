//
//  ThreadCreationView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ThreadCreationView: View {
    @StateObject var viewModel = ThreadCreationViewModel()
    @State private var caption = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack(alignment: .top){
                    CircularProfileImageView(user: viewModel.user, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        TextField("Start a thread", text: $caption, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button(action: {
                            caption = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        })
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post"){
                        Task {
                            try await viewModel.startThread(caption)
                            dismiss()
                        }
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    ThreadCreationView()
}
