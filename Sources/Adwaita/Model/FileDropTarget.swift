//
//  FileDropTarget.swift
//  Adwaita
//
//  Created by desbeers on 21.08.2026.
//

import CAdw
import Foundation

/// File Drop handler for Widgets.
enum FileDropTarget {

    /// Handle dropped files.
    /// - Parameters:
    ///   - pointer: Pointer to the dropped files.
    ///   - filter: Optional filter for the dropped files.
    /// - Returns: An URL array with the dropped files.
    static func handleDroppedFiles(_ pointer: UnsafeRawPointer, filter: FileDialogFilter?) -> [URL] {
        var result: [URL] = []

        let gValue = pointer.assumingMemoryBound(to: GValue.self)
        guard let gPointer = g_value_get_boxed(gValue) else {
            return []
        }
        let fileList = OpaquePointer(gPointer)
        var files = gdk_file_list_get_files(fileList)
        while let current = files {
            if let data = current.pointee.data,
                let uri = g_file_get_uri(OpaquePointer(data)),
                let url = URL(string: String(cString: uri)),
                filterFile(data, url: url, filter: filter) {
                // Accept this drop
                result.append(url)
            }
            files = current.pointee.next
        }
        return result
    }

    /// Filter a dropped file URL.
    /// - Parameters:
    ///   - gpointer: Pointer to the file.
    ///   - url: The URL of the file.
    ///   - filter: The optional filter.
    /// - Returns: True if the file is valid; else false
    static func filterFile(_ gpointer: gpointer, url: URL, filter: FileDialogFilter?) -> Bool {
        if let filter {
            switch filter {
            case let .extensions(extensions, _):
                return extensions.contains(url.pathExtension)
            case let .mimeType(mimeType, _):
                var result = ""
                let info = g_file_query_info(
                    OpaquePointer(gpointer),
                    "standard::content-type",
                    .FILE_QUERY_INFO_NOFOLLOW_SYMLINKS,
                    nil,
                    nil
                )
                let contentType = g_file_info_get_attribute_string(info, "standard::content-type")
                if let contentType {
                    result = String(cString: contentType)
                }
                g_object_unref(info?.cast())
                if mimeType.hasSuffix("/*") {
                    return result.hasPrefix(String(mimeType.dropLast()))
                }
                return result == mimeType
            }
        }
        // No filter applied
        return true
    }
}

extension AnyView {

    /// Make a Widget accept dropped files
    /// - Parameters:
    ///   - filter: The optional filter
    ///   - handler: The handler for the dropped files
    /// - Returns: A modified `AnyView`
    public func fileDropTarget(filter: FileDialogFilter? = nil, handler: @escaping ([URL]?) -> Void) -> AnyView {
        inspectOnAppear { storage in
            let controller = ViewStorage(gtk_drop_target_new(gdk_file_list_get_type(), .GDK_ACTION_COPY))
            gtk_widget_add_controller(storage.opaquePointer?.cast(), controller.opaquePointer)
            storage.fields[.dropTargetController] = controller
            controller.connectSignal(name: "drop", type: .pointerDoubleDouble) { args in
                guard let pointer = args.first as? UnsafeRawPointer else {
                    return
                }
                if let handler = storage.fields[.dropTargetHandler] as? ([URL]?) -> Void {
                    handler(FileDropTarget.handleDroppedFiles(pointer, filter: filter))
                }
            }
            if let name = filter?.name {
                gtk_widget_set_tooltip_markup(
                    storage.opaquePointer?.cast(),
                    name
                )
            }
        }
        .inspect { storage, _, updateProperties in
            if updateProperties {
                storage.fields[.dropTargetHandler] = handler
            }
        }
    }
}
