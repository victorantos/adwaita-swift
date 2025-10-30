//
//  ModifierWrapper.swift
//  Adwaita
//
//  Created by david-swift on 04.09.24.
//

import CAdw

/// A wrapper for view modifiers for any view.
struct ModifierWrapper: AdwaitaWidget {

    /// The view.
    var content: AnyView
    /// The padding.
    var padding: Int?
    /// The padding edges.
    var edges: Set<Edge>?
    /// Whether to expand horizontally.
    var hexpand: Bool?
    /// Whether to expand vertically.
    var vexpand: Bool?
    /// The horizontal alignment.
    var halign: Alignment?
    /// The vertical alignment.
    var valign: Alignment?
    /// The minimum width.
    var minWidth: Int?
    /// The minimum height.
    var minHeight: Int?
    /// The style class.
    var style: String?
    /// Whether the style is active.
    var styleActive: Bool?
    /// Whether the view is insensitive.
    var insensitive: Bool?
    /// Whether the view is visible.
    var visible: Bool?
    /// The tooltip.
    var tooltip: String?

    /// Initialize a modifier wrapper.
    /// - Parameters:
    ///     - content: The view.
    ///     - padding: The padding.
    ///     - edges: The padding edges.
    ///     - hexpand: Whether to expand horizontally.
    ///     - vexpand: Whether to expand vertically.
    ///     - halign: The horizontal alignment.
    ///     - valign: The vertical alignment.
    ///     - minWidth: The minimum width.
    ///     - minHeight: The minimum height.
    ///     - style: The style class.
    ///     - styleActive: Whether the style is active.
    ///     - insensitive: Whether the view is insensitive.
    ///     - visible: Whether the view is visible.
    ///     - tooltip: The tooltip.
    init(
        content: AnyView,
        padding: Int? = nil,
        edges: Set<Edge>? = nil,
        hexpand: Bool? = nil,
        vexpand: Bool? = nil,
        halign: Alignment? = nil,
        valign: Alignment? = nil,
        minWidth: Int? = nil,
        minHeight: Int? = nil,
        style: String? = nil,
        styleActive: Bool? = nil,
        insensitive: Bool? = nil,
        visible: Bool? = nil,
        tooltip: String? = nil
    ) {
        self.content = content
        self.padding = padding
        self.edges = edges
        self.hexpand = hexpand
        self.vexpand = vexpand
        self.halign = halign
        self.valign = valign
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.style = style
        self.styleActive = styleActive
        self.insensitive = insensitive
        self.visible = visible
        self.tooltip = tooltip
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let content = content.storage(data: data, type: type)
        let storage = ViewStorage(content.pointer, content: [.mainContent: [content]])
        update(storage, data: data, updateProperties: true, type: type)
        return storage
    }

    /// Update the stored content.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    func update<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        if let storage = storage.content[.mainContent]?.first {
            content.updateStorage(storage, data: data, updateProperties: updateProperties, type: type)
        }
        guard updateProperties else {
            return
        }
        update1(storage, data: data, updateProperties: updateProperties, type: type)
        update2(storage, data: data, updateProperties: updateProperties, type: type)
        storage.previousState = self
    }

    /// Update part 1 of the properties.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    func update1<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        let previousState = storage.previousState as? Self
        if let padding, let edges, previousState?.padding != padding || previousState?.edges != edges {
            if edges.contains(.leading) { gtk_widget_set_margin_start(storage.opaquePointer?.cast(), padding.cInt) }
            if edges.contains(.trailing) { gtk_widget_set_margin_end(storage.opaquePointer?.cast(), padding.cInt) }
            if edges.contains(.top) { gtk_widget_set_margin_top(storage.opaquePointer?.cast(), padding.cInt) }
            if edges.contains(.bottom) { gtk_widget_set_margin_bottom(storage.opaquePointer?.cast(), padding.cInt) }
        }
        if let hexpand, previousState?.hexpand != hexpand {
            gtk_widget_set_hexpand(storage.opaquePointer?.cast(), hexpand.cBool)
        }
        if let vexpand, previousState?.vexpand != vexpand {
            gtk_widget_set_vexpand(storage.opaquePointer?.cast(), vexpand.cBool)
        }
        if let halign, previousState?.halign != halign {
            gtk_widget_set_halign(storage.opaquePointer?.cast(), halign.cAlign)
        }
        if let valign, previousState?.valign != valign {
            gtk_widget_set_valign(storage.opaquePointer?.cast(), valign.cAlign)
        }
    }

    /// Update part 2 of the properties.
    /// - Parameters:
    ///     - storage: The storage to update.
    ///     - modifiers: Modify views before being updated
    ///     - updateProperties: Whether to update the view's properties.
    ///     - type: The view render data type.
    func update2<Data>(
        _ storage: ViewStorage,
        data: WidgetData,
        updateProperties: Bool,
        type: Data.Type
    ) where Data: ViewRenderData {
        let previousState = storage.previousState as? Self
        if minWidth != previousState?.minWidth || minHeight != previousState?.minHeight {
            gtk_widget_set_size_request(storage.opaquePointer?.cast(), minWidth?.cInt ?? 1, minHeight?.cInt ?? -1)
        }
        if let style, let styleActive, previousState?.styleActive != styleActive {
            if styleActive {
                gtk_widget_add_css_class(storage.opaquePointer?.cast(), style)
            } else {
                gtk_widget_remove_css_class(storage.opaquePointer?.cast(), style)
            }
        }
        if let insensitive, previousState?.insensitive != insensitive {
            gtk_widget_set_sensitive(storage.opaquePointer?.cast(), insensitive ? 0 : 1)
        }
        if let visible, previousState?.visible != visible {
            gtk_widget_set_visible(storage.opaquePointer?.cast(), visible.cBool)
        }
        if let tooltip, previousState?.tooltip != tooltip {
            gtk_widget_set_tooltip_markup(storage.opaquePointer?.cast(), tooltip)
        }
    }

}
