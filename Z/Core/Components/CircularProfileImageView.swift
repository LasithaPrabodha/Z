//
//  CircularProfileImageView.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("lasitha")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
        
    }
}

#Preview {
    CircularProfileImageView()
}
