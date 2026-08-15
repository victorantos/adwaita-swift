//
//  PictureDemo.swift
//  Adwaita
//
//  Created by david-swift on 21.04.24.
//

// swiftlint:disable missing_docs

import Adwaita
import Foundation

struct PictureDemo: View {

    @State private var fileDialog = Signal()
    @State private var url: URL?
    var app: AdwaitaApp
    var window: AdwaitaWindow

    var data: Data {
        guard let url, let data = try? Data(contentsOf: url) else {
            return .init()
        }
        return data
    }

    var view: Body {
        Picture()
            .data(data)
        Button("Open") {
            fileDialog.signal()
        }
        .halign(.center)
        .pill()
        .suggested()
        .padding()
        .fileImporter(
            open: $fileDialog,
            initialFolder: FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first,
            filters: [
                .extensions(["jpg", "jpeg"], name: "JPG Images"),
                .mimeType("image/*", name: "All Images")
            ],
            title: "Pick an Image",
            acceptLabel: "Open Image"
        ) { url = $0 } onClose: { }
    }

}

// swiftlint:enable missing_docs
