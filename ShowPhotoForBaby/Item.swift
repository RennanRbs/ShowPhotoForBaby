//
//  Item.swift
//  ShowPhotoForBaby
//
//  Created by Rennan Rebouças  on 20/02/26.
//

import Foundation
import SwiftData

@Model
final class PhotoItem {
    var id: UUID
    var name: String
    var imageFileName: String
    var createdAt: Date

    init(id: UUID = UUID(), name: String, imageFileName: String, createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.imageFileName = imageFileName
        self.createdAt = createdAt
    }
}
