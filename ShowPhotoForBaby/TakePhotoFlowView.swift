//
//  TakePhotoFlowView.swift
//  ShowPhotoForBaby
//

import SwiftUI
import SwiftData
import PhotosUI

struct TakePhotoFlowView: View {
    @Binding var isPresented: Bool
    @Environment(\.modelContext) private var modelContext

    @State private var capturedImage: UIImage?
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showCamera = false
    @State private var name = ""

    var body: some View {
        Group {
            if let image = capturedImage {
                nameAndSaveView(image: image)
            } else {
                sourceChoiceView
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraPickerView(image: $capturedImage)
                .ignoresSafeArea()
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            Task { await loadPhoto(from: newItem) }
        }
    }

    private var sourceChoiceView: some View {
        VStack(spacing: 32) {
            Spacer()
            Button {
                showCamera = true
            } label: {
                Text("Câmera")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 40)

            PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                Text("Álbum")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 40)

            Button("Cancelar") { isPresented = false }
                .foregroundStyle(.secondary)
                .padding(.top, 8)
            Spacer()
        }
    }

    private func nameAndSaveView(image: UIImage) -> some View {
        VStack(spacing: 24) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 400)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

            TextField("Nome", text: $name)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)

            Button {
                saveAndDismiss(image: image)
            } label: {
                Text("Salvar")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 40)
            .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Button("Descartar") {
                capturedImage = nil
                selectedPhotoItem = nil
                name = ""
            }
            .foregroundStyle(.red)
            Spacer()
        }
        .padding(.top, 32)
    }

    private func loadPhoto(from item: PhotosPickerItem?) async {
        guard let item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self),
              let uiImage = UIImage(data: data) else { return }
        await MainActor.run {
            capturedImage = uiImage
            selectedPhotoItem = nil
        }
    }

    private func saveAndDismiss(image: UIImage) {
        let fileName = "\(UUID().uuidString).jpg"
        guard ImageStorage.saveImage(image, fileName: fileName) else { return }
        let photoItem = PhotoItem(name: name.trimmingCharacters(in: .whitespacesAndNewlines), imageFileName: fileName)
        modelContext.insert(photoItem)
        try? modelContext.save()
        isPresented = false
    }
}
