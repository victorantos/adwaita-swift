//
//  Viewport.swift
//  Adwaita
//
//  Created by auto-generation on 19.08.26.
//

import CAdw
import LevenshteinTransformations

/// Implements scrollability for widgets that don't support scrolling
/// on their own.
/// 
/// Use `GtkViewport` to scroll child widgets such as `GtkGrid`,
/// `GtkBox`, and so on.
/// 
/// The `GtkViewport` will start scrolling content only if allocated
/// less than the child widget’s minimum size in a given orientation.
/// 
/// 
public struct Viewport: AdwaitaWidget {

    #if exposeGeneratedAppearUpdateFunctions
    /// Additional update functions for type extensions.
    public var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    public var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []
    #else
    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []
    #endif

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    var accessibleRole: String?
    /// The child widget.
    var child: Body?
    /// Determines when horizontal scrolling should start.
    var hscrollPolicy: ScrollablePolicy?
    /// Whether to scroll when the focus changes.
    /// 
    /// Before 4.6.2, this property was mistakenly defaulting to FALSE, so if your
    /// code needs to work with older versions, consider setting it explicitly to
    /// TRUE.
    var scrollToFocus: Bool?
    /// Determines when vertical scrolling should start.
    var vscrollPolicy: ScrollablePolicy?

    /// Initialize `Viewport`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_viewport_new(nil, nil)?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        if let childStorage = child?.storage(data: data, type: type) {
            storage.content["child"] = [childStorage]
            gtk_viewport_set_child(storage.opaquePointer, childStorage.opaquePointer?.cast())
        }

        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    public func update<Data>(_ storage: ViewStorage, data: WidgetData, updateProperties: Bool, type: Data.Type) where Data: ViewRenderData {
        storage.modify { widget in

            if let widget = storage.content["child"]?.first {
                child?.updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let hscrollPolicy, updateProperties, (storage.previousState as? Self)?.hscrollPolicy != hscrollPolicy {
                gtk_scrollable_set_hscroll_policy(widget, hscrollPolicy.gtkValue)
            }
            if let scrollToFocus, updateProperties, (storage.previousState as? Self)?.scrollToFocus != scrollToFocus {
                gtk_viewport_set_scroll_to_focus(widget, scrollToFocus.cBool)
            }
            if let vscrollPolicy, updateProperties, (storage.previousState as? Self)?.vscrollPolicy != vscrollPolicy {
                gtk_scrollable_set_vscroll_policy(widget, vscrollPolicy.gtkValue)
            }



        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The accessible role of the given `GtkAccessible` implementation.
    /// 
    /// The accessible role cannot be changed once set.
    public func accessibleRole(_ accessibleRole: String?) -> Self {
        modify { $0.accessibleRole = accessibleRole }
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: () -> Body) -> Self {
        modify { $0.child = child() }
    }

    /// Determines when horizontal scrolling should start.
    public func hscrollPolicy(_ hscrollPolicy: ScrollablePolicy?) -> Self {
        modify { $0.hscrollPolicy = hscrollPolicy }
    }

    /// Whether to scroll when the focus changes.
    /// 
    /// Before 4.6.2, this property was mistakenly defaulting to FALSE, so if your
    /// code needs to work with older versions, consider setting it explicitly to
    /// TRUE.
    public func scrollToFocus(_ scrollToFocus: Bool? = true) -> Self {
        modify { $0.scrollToFocus = scrollToFocus }
    }

    /// Determines when vertical scrolling should start.
    public func vscrollPolicy(_ vscrollPolicy: ScrollablePolicy?) -> Self {
        modify { $0.vscrollPolicy = vscrollPolicy }
    }

}
