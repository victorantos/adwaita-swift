//
//  TextEditor.swift
//  Adwaita
//
//  Created by david-swift on 09.08.25.
//

import CAdw

/// A text editor widget.
public typealias TextEditor = TextView

/// A text editor widget.
public struct TextView: AdwaitaWidget {

    /// The editor's content.
    @Binding var text: String
    /// The padding between the border and the content.
    var padding = 0
    /// The edges affected by the padding.
    var paddingEdges: Set<Edge> = []
    /// The (word) wrap mode used when rendering the text.
    var wrapMode: WrapMode = .none

    /// Initialize a text editor.
    /// - Parameter text: The editor's content.
    public init(text: Binding<String>) {
        self._text = text
    }

    /// Get the editor's view storage.
    /// - Parameters:
    ///     - data: The widget data.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage {
        let buffer = ViewStorage(gtk_text_buffer_new(nil)?.opaque())
        let editor = ViewStorage(
            gtk_text_view_new_with_buffer(buffer.opaquePointer?.cast())?.opaque(),
            content: ["buffer": [buffer]]
        )
        update(editor, data: data, updateProperties: true, type: type)
        return editor
    }

    /// Update a view storage to the editor.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - data: The widget data.
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) {
        if let buffer = storage.content["buffer"]?.first {
            buffer.connectSignal(name: "changed") {
                let text = getText(buffer: buffer)
                if self.text != text {
                    self.text = text
                }
            }
            if updateProperties {
                if getText(buffer: buffer) != self.text {
                    gtk_text_buffer_set_text(buffer.opaquePointer?.cast(), text, -1)
                }
            }
        }
        if updateProperties {
            if paddingEdges.contains(.top) {
                gtk_text_view_set_top_margin(storage.opaquePointer?.cast(), padding.cInt)
            }
            if paddingEdges.contains(.bottom) {
                gtk_text_view_set_bottom_margin(storage.opaquePointer?.cast(), padding.cInt)
            }
            if paddingEdges.contains(.leading) {
                gtk_text_view_set_left_margin(storage.opaquePointer?.cast(), padding.cInt)
            }
            if paddingEdges.contains(.trailing) {
                gtk_text_view_set_right_margin(storage.opaquePointer?.cast(), padding.cInt)
            }
            // update the wrapping mode
            gtk_text_view_set_wrap_mode(storage.opaquePointer?.cast(), wrapMode.rawValue)
        }
    }

    /// Set the wrapMode for the text view.
    ///
    /// Available wrap modes are `none`, `char`, `word`, `wordChar`. Please refer to the
    /// corresponding `GtkWrapMode` documentation for the details on how they work.
    ///
    /// - Parameter mode: The `WrapMode` to set.
    public func wrapMode(_ mode: WrapMode) -> Self {
      var newSelf = self
      newSelf.wrapMode = mode
      return newSelf
    }

    /// Get the text view's content.
    /// - Parameter buffer: The text view's buffer.
    /// - Returns: The content.
    func getText(buffer: ViewStorage) -> String {
        let startIter: UnsafeMutablePointer<GtkTextIter> = .allocate(capacity: 1)
        let endIter: UnsafeMutablePointer<GtkTextIter> = .allocate(capacity: 1)
        gtk_text_buffer_get_start_iter(buffer.opaquePointer?.cast(), startIter)
        gtk_text_buffer_get_end_iter(buffer.opaquePointer?.cast(), endIter)
        return .init(
            cString: gtk_text_buffer_get_text(buffer.opaquePointer?.cast(), startIter, endIter, true.cBool)
        )
    }

    /// Add padding between the editor's content and border.
    /// - Parameters:
    ///     - padding: The padding's value.
    ///     - edges: The affected edges.
    /// - Returns: The editor.
    public func innerPadding(_ padding: Int = 10, edges: Set<Edge> = .all) -> Self {
        var newSelf = self
        newSelf.padding = padding
        newSelf.paddingEdges = edges
        return newSelf
    }

}
