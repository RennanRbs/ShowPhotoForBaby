//
//  ImageStorage.swift
//  ShowPhotoForBaby
//

import UIKit

enum ImageStorage {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    static func saveImage(_ image: UIImage, fileName: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 0.85) else { return false }
        let url = documentsDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: url)
            return true
        } catch {
            return false
        }
    }

    static func loadImage(fileName: String) -> UIImage? {
        let url = documentsDirectory.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
}
