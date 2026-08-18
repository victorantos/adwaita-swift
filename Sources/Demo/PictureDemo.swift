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
    var view: Body {
        if let url {
            Picture(url: url)
        }
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
        ) { url in
            self.url = url
        }
    }

}

// swiftlint:enable missing_docs
