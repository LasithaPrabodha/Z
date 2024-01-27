//
//  ProfileView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    private var filterBarWidth: CGFloat{
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    // user bio and stats
                    VStack (alignment: .leading, spacing: 12){
                        // fullname and username
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Lasitha Prabodha")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("lu6-fer")
                                .font(.subheadline)
                        }
                        
                        Text("Software Engineer - Full Stack & Mobile")
                        
                        Text("250 followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                    
                    Spacer()
                    
                    CircularProfileImageView()
                }
                
                Button{
                    
                }label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                // user content
                VStack {
                    HStack{
                        ForEach(ProfileThreadFilter.allCases){ filter in
                            VStack {
                                Text(filter.titles)
                                    .font(.subheadline)
                                    .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                
                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .frame(width: filterBarWidth, height: 1)
                                        .matchedGeometryEffect(id: "item", in: animation)
                                        
                                }else{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: filterBarWidth, height: 1)
                                }
                            }
                            .onTapGesture {
                                withAnimation(.spring()){
                                    selectedFilter = filter
                                }
                            }
                        }
                    }
                    
                    LazyVStack{
                        ForEach(0 ... 10, id: \.self){thread in
                            ThreadCell()
                        }
                        
                    }
                }
                .padding(.vertical, 8)
            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
