//
//  PopoverMenu.swift
//  Adwaita
//
//  Created by auto-generation on 21.08.26.
//

import CAdw
import LevenshteinTransformations

/// A subclass of `GtkPopover` that implements menu behavior.
/// 
/// 
/// 
/// `GtkPopoverMenu` treats its children like menus and allows switching
/// between them. It can open submenus as traditional, nested submenus,
/// or in a more touch-friendly sliding fashion.
/// The property ``flags(_:)`` controls this appearance.
/// 
/// `GtkPopoverMenu` is meant to be used primarily with menu models,
/// using `Gtk.PopoverMenu.new_from_model`. If you need to put
/// other widgets such as a `GtkSpinButton` or a `GtkSwitch` into a popover,
/// you can use `Gtk.PopoverMenu.add_child`.
/// 
/// For more dialog-like behavior, use a plain `GtkPopover`.
/// 
/// 
public struct PopoverMenu: AdwaitaWidget {

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
    /// Whether to dismiss the popover on outside clicks.
    var autohide: Bool?
    /// Whether the popover pops down after a child popover.
    /// 
    /// This is used to implement the expected behavior of submenus.
    var cascadePopdown: Bool?
    /// The child widget.
    var child: Body?
    /// The default widget inside the popover.
    var defaultWidget: Body?
    /// Whether to draw an arrow.
    var hasArrow: Bool?
    /// The model from which the menu is made.
    var menuModel: Body?
    /// Whether mnemonics are currently visible in this popover.
    var mnemonicsVisible: Bool?
    /// The name of the visible submenu.
    var visibleSubmenu: String?
    /// Emitted whend the user activates the default widget.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Enter</kbd>.
    var activateDefault: (() -> Void)?
    /// Emitted when the popover is closed.
    var closed: (() -> Void)?

    /// Initialize `PopoverMenu`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(gtk_popover_menu_new_from_model(nil)?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        if let childStorage = child?.storage(data: data, type: type) {
            storage.content["child"] = [childStorage]
            gtk_popover_set_child(storage.opaquePointer?.cast(), childStorage.opaquePointer?.cast())
        }
        if let defaultWidgetStorage = defaultWidget?.storage(data: data, type: type) {
            storage.content["defaultWidget"] = [defaultWidgetStorage]
            gtk_popover_set_default_widget(storage.opaquePointer?.cast(), defaultWidgetStorage.opaquePointer?.cast())
        }
        if let menuModel {
            let childStorage = MenuCollection { menuModel }.getMenu(data: data)
            storage.content["menuModel"] = [childStorage]
            gtk_popover_menu_set_menu_model(storage.opaquePointer, childStorage.opaquePointer?.cast())
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
        if let activateDefault {
            storage.connectSignal(name: "activate-default", type: .noArgs) {
                activateDefault()
            }
        }
        if let closed {
            storage.connectSignal(name: "closed", type: .noArgs) {
                closed()
            }
        }
        storage.modify { widget in

            if let autohide, updateProperties, (storage.previousState as? Self)?.autohide != autohide {
                gtk_popover_set_autohide(widget?.cast(), autohide.cBool)
            }
            if let cascadePopdown, updateProperties, (storage.previousState as? Self)?.cascadePopdown != cascadePopdown {
                gtk_popover_set_cascade_popdown(widget?.cast(), cascadePopdown.cBool)
            }
            if let widget = storage.content["child"]?.first {
                child?.updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let widget = storage.content["defaultWidget"]?.first {
                defaultWidget?.updateStorage(widget, data: data, updateProperties: updateProperties, type: type)
            }
            if let hasArrow, updateProperties, (storage.previousState as? Self)?.hasArrow != hasArrow {
                gtk_popover_set_has_arrow(widget?.cast(), hasArrow.cBool)
            }
            if let menu = storage.content["menuModel"]?.first {
                MenuCollection { menuModel ?? [] }
                    .updateStorage(menu, data: data.noModifiers, updateProperties: updateProperties, type: MenuContext.self)
            }
            if let mnemonicsVisible, updateProperties, (storage.previousState as? Self)?.mnemonicsVisible != mnemonicsVisible {
                gtk_popover_set_mnemonics_visible(widget?.cast(), mnemonicsVisible.cBool)
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

    /// Whether to dismiss the popover on outside clicks.
    public func autohide(_ autohide: Bool? = true) -> Self {
        modify { $0.autohide = autohide }
    }

    /// Whether the popover pops down after a child popover.
    /// 
    /// This is used to implement the expected behavior of submenus.
    public func cascadePopdown(_ cascadePopdown: Bool? = true) -> Self {
        modify { $0.cascadePopdown = cascadePopdown }
    }

    /// The child widget.
    public func child(@ViewBuilder _ child: () -> Body) -> Self {
        modify { $0.child = child() }
    }

    /// The default widget inside the popover.
    public func defaultWidget(@ViewBuilder _ defaultWidget: () -> Body) -> Self {
        modify { $0.defaultWidget = defaultWidget() }
    }

    /// Whether to draw an arrow.
    public func hasArrow(_ hasArrow: Bool? = true) -> Self {
        modify { $0.hasArrow = hasArrow }
    }

    /// The model from which the menu is made.
    public func menuModel(@ViewBuilder _ menuModel: () -> Body) -> Self {
        modify { $0.menuModel = menuModel() }
    }

    /// Whether mnemonics are currently visible in this popover.
    public func mnemonicsVisible(_ mnemonicsVisible: Bool? = true) -> Self {
        modify { $0.mnemonicsVisible = mnemonicsVisible }
    }

    /// The name of the visible submenu.
    public func visibleSubmenu(_ visibleSubmenu: String?) -> Self {
        modify { $0.visibleSubmenu = visibleSubmenu }
    }

    /// Emitted whend the user activates the default widget.
    /// 
    /// This is a [keybinding signal](class.SignalAction.html).
    /// 
    /// The default binding for this signal is <kbd>Enter</kbd>.
    public func activateDefault(_ activateDefault: @escaping () -> Void) -> Self {
        modify { $0.activateDefault = activateDefault }
    }

    /// Emitted when the popover is closed.
    public func closed(_ closed: @escaping () -> Void) -> Self {
        modify { $0.closed = closed }
    }

}
