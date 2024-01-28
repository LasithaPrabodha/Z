//
//  EditProfileViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import PhotosUI
import SwiftUI

class EditProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    @Published var profileImage: Image?
    private var uiImage:UIImage?
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data)  else { return }
        
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func updateUserData() async throws {
        try await uploadProfileImage()
    }
    
    private func uploadProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadProfileImage(image) else {return}
        
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }
}
