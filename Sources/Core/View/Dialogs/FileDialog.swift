//
//  FileDialog.swift
//  Adwaita
//
//  Created by david-swift on 12.08.24.
//

import CAdw
import Foundation

/// A structure representing a file dialog window.
public struct FileDialog: AdwaitaWidget {

    /// Whether the dialog is an importer.
    var importer: Bool
    /// Whether the dialog should open.
    var open: Signal
    /// The dialog's child.
    var child: AnyView
    /// The initial folder.
    var initialFolder: URL?
    /// The initial file name for the file exporter.
    var initialName: String?
    /// The accepted extensions for the file importer.
    var extensions: [String]?
    /// The closure to run when the import or export is successful.
    var result: (URL) -> Void
    /// The closure to run when the import or export is not successful.
    var cancel: () -> Void

    // swiftlint:disable function_default_parameter_at_end
    /// Initialize the file dialog wrapper.
    /// - Parameters:
    ///     - importer: Whether it is an importer.
    ///     - open: The signal.
    ///     - child: The wrapped view.
    ///     - initialFolder: The initial URL.
    ///     - initialName: The initial name.
    ///     - extensions: The file extensions.
    ///     - result: Run when the import or export succeeds.
    ///     - cancel: Run when the import or export is not successful.
    public init(
        importer: Bool = true,
        `open`: Signal,
        child: AnyView,
        result: @escaping (URL) -> Void,
        cancel: @escaping () -> Void,
        initialFolder: URL? = nil,
        initialName: String? = nil,
        extensions: [String]? = nil
    ) {
        self.importer = importer
        self.open = open
        self.child = child
        self.result = result
        self.cancel = cancel
        self.initialFolder = initialFolder
        self.initialName = initialName
        self.extensions = extensions
    }
    // swiftlint:enable function_default_parameter_at_end

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let child = child.storage(data: data, type: type)
        let storage = ViewStorage(child.opaquePointer, content: [.mainContent: [child]])
        update(storage, data: data, updateProperties: true, type: type)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        storage.fields["result"] = result
        storage.fields["cancel"] = cancel
        guard let mainStorage = storage.content[.mainContent]?.first else {
            return
        }
        child.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        if open.update, storage.fields["callbacks"] == nil {
            var unref: [OpaquePointer?] = []
            let pointer = gtk_file_dialog_new()
            unref.append(pointer)
            if let initialName {
                gtk_file_dialog_set_initial_name(pointer, initialName)
            }
            if let extensions {
                let filter = gtk_file_filter_new()
                for name in extensions {
                    gtk_file_filter_add_suffix(filter, name)
                }
                gtk_file_dialog_set_default_filter(pointer, filter)
                unref.append(filter)
            } else {
                gtk_file_dialog_set_default_filter(pointer, nil)
            }
            if let initialFolder {
                let file = g_file_new_for_path(initialFolder.absoluteString)
                gtk_file_dialog_set_initial_folder(pointer, file)
                unref.append(file)
            }
            let callbacks = AdwaitaFileDialog()
            let unrefClosure = {
                for ref in unref {
                    g_object_unref(ref?.cast())
                }
                storage.fields["callbacks"] = nil
            }
            callbacks.onResult = { (storage.fields["result"] as? (URL) -> Void)?($0); unrefClosure() }
            callbacks.onCancel = { (storage.fields["cancel"] as? () -> Void)?(); unrefClosure() }
            callbacks.reset = { storage.fields["callbacks"] = nil }
            storage.fields["callbacks"] = callbacks
            let ptr = UInt64(Int(bitPattern: pointer))
            let window = UInt64(Int(bitPattern: gtk_widget_get_root(mainStorage.opaquePointer?.cast())))
            if importer {
                gtui_filedialog_open(ptr, unsafeBitCast(callbacks, to: UInt64.self), window)
            } else {
                gtui_filedialog_save(ptr, unsafeBitCast(callbacks, to: UInt64.self), window)
            }
        }
    }

}

/// An Adwaita file dialog window callback.
class AdwaitaFileDialog {

    /// A closure triggered on selecting a file in the dialog.
    var onResult: (URL) -> Void = { _ in }
    /// A closure triggered when the dialog is canceled.
    var onCancel: () -> Void = { }
    /// Reset the file dialog.
    var reset: () -> Void = { }

    /// Initialize the window callback.
    init() { }

    deinit { print("DEINIT fd") }

    /// Run this when a file gets opened.
    /// - Parameter path: The file path.
    func onOpen(_ path: String) {
        let url = URL(fileURLWithPath: path)
        onResult(url)
        reset()
    }

    /// Run this when a file gets saved.
    /// - Parameter path: The file path.
    func onSave(_ path: String) {
        let url = URL(fileURLWithPath: path)
        onResult(url)
        reset()
    }

    /// Run this when the user cancels the action.
    func onClose() {
        onCancel()
        reset()
    }

}

/// Run when a file should be opened.
/// - Parameters:
///   - ptr: The pointer.
///   - file: The path to the file.
///   - userData: The file dialog data.
@_cdecl("filedialog_on_open_cb")
func filedialog_on_open_cb(
    ptr: UnsafeMutableRawPointer,
    file: UnsafePointer<CChar>?,
    userData: UnsafeMutableRawPointer
) {
    let dialog = Unmanaged<AdwaitaFileDialog>.fromOpaque(userData).takeUnretainedValue()
    if let file {
        dialog.onOpen(.init(cString: file))
    } else {
        dialog.onClose()
    }
}

/// Run when a file should be saved.
/// - Parameters:
///   - ptr: The pointer.
///   - file: The path to the file.
///   - userData: The file dialog data.
@_cdecl("filedialog_on_save_cb")
func filedialog_on_save_cb(
    ptr: UnsafeMutableRawPointer,
    file: UnsafePointer<CChar>?,
    userData: UnsafeMutableRawPointer
) {
    let dialog = Unmanaged<AdwaitaFileDialog>.fromOpaque(userData).takeUnretainedValue()
    if let file {
        dialog.onSave(.init(cString: file))
    } else {
        dialog.onClose()
    }
}
