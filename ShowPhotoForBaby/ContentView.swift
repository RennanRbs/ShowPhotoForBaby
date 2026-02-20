//
//  ContentView.swift
//  ShowPhotoForBaby
//
//  Created by Rennan Rebouças  on 20/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showTakePhotoFlow = false
    @State private var showViewPhotos = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Button {
                showTakePhotoFlow = true
            } label: {
                Text("Bater foto")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .padding(.horizontal, 40)

            Button {
                showViewPhotos = true
            } label: {
                Text("Ver fotos")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .fullScreenCover(isPresented: $showTakePhotoFlow) {
            TakePhotoFlowView(isPresented: $showTakePhotoFlow)
        }
        .fullScreenCover(isPresented: $showViewPhotos) {
            ViewPhotosView(isPresented: $showViewPhotos)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PhotoItem.self, inMemory: true)
}
