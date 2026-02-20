//
//  ViewPhotosView.swift
//  ShowPhotoForBaby
//

import SwiftUI
import SwiftData

struct ViewPhotosView: View {
    @Binding var isPresented: Bool
    @Query(sort: \PhotoItem.createdAt, order: .forward) private var items: [PhotoItem]

    var body: some View {
        ZStack(alignment: .topLeading) {
            if items.isEmpty {
                emptyView
            } else {
                TabView {
                    ForEach(items, id: \.id) { item in
                        photoPage(item: item)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
            }

            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            }
            .padding(24)
        }
        .background(Color.black)
    }

    private var emptyView: some View {
        VStack {
            Text("Nenhuma foto")
                .font(.title2)
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func photoPage(item: PhotoItem) -> some View {
        ZStack(alignment: .bottom) {
            if let uiImage = ImageStorage.loadImage(fileName: item.imageFileName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                Color.gray
            }

            Text(item.name)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.5))
        }
        .ignoresSafeArea()
    }
}
