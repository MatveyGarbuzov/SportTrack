//
//  EditProfileScreen.swift
//  SportTrack
//
//  Created by Garbuzov Matvey on 01.05.2024.
//

import SwiftUI
import PhotosUI

struct EditProfileScreen: View {

    @Environment(\.modelContext) var context
    @State private var userViewModel = UserViewModel()
    @State private var user = User()

    @EnvironmentObject private var nav: Navigation
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var newName = ""

    var body: some View {
        MainBlock
            .customNavBar(title: "Profile edit")
            .backNavBarButton {
                goBack()
            }
            .checkmarkNavBarButton {
                userViewModel.save(
                    User(
                        name: newName,
                        image: selectedImageData
                    )
                )

                goBack()
            }
            .onAppear {
                userViewModel.context = context

                guard let userFromMemory = userViewModel.read() else { return }
                user = userFromMemory
                newName = user.name
                selectedImageData = user.image
            }
    }
}

// MARK: - Actions

extension EditProfileScreen {

    func goBack() {
        nav.openPreviousScreen()
    }
}

// MARK: - UI Subviews

extension EditProfileScreen {

    var MainBlock: some View {
        VStack {
            PhotoPicker
            NameTextField
            Spacer()
        }
        .padding()
    }

    var NameTextField: some View {
        TextField("", text: $newName)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: .CRx3)
                    .fill(.ultraThickMaterial)
            }
    }

    var PhotoPicker: some View {
        VStack {
            ImageBlock(uiImage: UIImage(data: selectedImageData ?? .empty))
            TextForPhotoPicker
        }
    }

    func ImageBlock(uiImage: UIImage?) -> some View {
        Image(uiImage: uiImage ?? .profile)
            .resizable()
            .clipShape(.circle)
            .aspectRatio(contentMode: .fill)
            .frame(edge: 200)
    }

    var TextForPhotoPicker: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                Text("Select a photo")
            }
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
    }
}

#Preview {
    EditProfileScreen()
}
