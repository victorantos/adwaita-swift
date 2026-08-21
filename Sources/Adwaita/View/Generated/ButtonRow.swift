//
//  ButtonRow.swift
//  Adwaita
//
//  Created by auto-generation on 21.08.26.
//

import CAdw
import LevenshteinTransformations

/// A `Gtk.ListBoxRow` that looks like a button.
/// 
/// 
/// 
/// The `AdwButtonRow` widget has a title and two icons: before and after the
/// title.
/// 
/// It is convenient for presenting actions like "Delete" at the end of a boxed
/// list.
/// 
/// `AdwButtonRow` is always activatable.
/// 
/// 
public struct ButtonRow: AdwaitaWidget {

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

    /// The icon name to show after the title.
    var endIconName: String?
    /// The icon name to show before the title.
    var startIconName: String?
    /// The title of the preference represented by this row.
    /// 
    /// The title is interpreted as Pango markup unless
    /// ``useMarkup(_:)`` is set to `false`.
    var title: String?
    /// Whether the user can copy the title from the label.
    /// 
    /// See also ``selectable(_:)``.
    var titleSelectable: Bool?
    /// Whether to use Pango markup for the title label.
    /// 
    /// Subclasses may also use it for other labels, such as subtitle.
    /// 
    /// See also `Pango.parse_markup`.
    var useMarkup: Bool?
    /// Whether an embedded underline in the title indicates a mnemonic.
    var useUnderline: Bool?
    /// This signal is emitted after the row has been activated.
    var activated: (() -> Void)?

    /// Initialize `ButtonRow`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_button_row_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
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
        if let activated {
            storage.connectSignal(name: "activated", type: .noArgs) {
                activated()
            }
        }
        storage.modify { widget in

            if let endIconName, updateProperties, (storage.previousState as? Self)?.endIconName != endIconName {
                adw_button_row_set_end_icon_name(widget, endIconName)
            }
            if let startIconName, updateProperties, (storage.previousState as? Self)?.startIconName != startIconName {
                adw_button_row_set_start_icon_name(widget, startIconName)
            }
            if let title, updateProperties, (storage.previousState as? Self)?.title != title {
                adw_preferences_row_set_title(widget?.cast(), title)
            }
            if let titleSelectable, updateProperties, (storage.previousState as? Self)?.titleSelectable != titleSelectable {
                adw_preferences_row_set_title_selectable(widget?.cast(), titleSelectable.cBool)
            }
            if let useMarkup, updateProperties, (storage.previousState as? Self)?.useMarkup != useMarkup {
                adw_preferences_row_set_use_markup(widget?.cast(), useMarkup.cBool)
            }
            if let useUnderline, updateProperties, (storage.previousState as? Self)?.useUnderline != useUnderline {
                adw_preferences_row_set_use_underline(widget?.cast(), useUnderline.cBool)
            }



        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

    /// The icon name to show after the title.
    public func endIconName(_ endIconName: String?) -> Self {
        modify { $0.endIconName = endIconName }
    }

    /// The icon name to show before the title.
    public func startIconName(_ startIconName: String?) -> Self {
        modify { $0.startIconName = startIconName }
    }

    /// The title of the preference represented by this row.
    /// 
    /// The title is interpreted as Pango markup unless
    /// ``useMarkup(_:)`` is set to `false`.
    public func title(_ title: String?) -> Self {
        modify { $0.title = title }
    }

    /// Whether the user can copy the title from the label.
    /// 
    /// See also ``selectable(_:)``.
    public func titleSelectable(_ titleSelectable: Bool? = true) -> Self {
        modify { $0.titleSelectable = titleSelectable }
    }

    /// Whether to use Pango markup for the title label.
    /// 
    /// Subclasses may also use it for other labels, such as subtitle.
    /// 
    /// See also `Pango.parse_markup`.
    public func useMarkup(_ useMarkup: Bool? = true) -> Self {
        modify { $0.useMarkup = useMarkup }
    }

    /// Whether an embedded underline in the title indicates a mnemonic.
    public func useUnderline(_ useUnderline: Bool? = true) -> Self {
        modify { $0.useUnderline = useUnderline }
    }

    /// This signal is emitted after the row has been activated.
    public func activated(_ activated: @escaping () -> Void) -> Self {
        modify { $0.activated = activated }
    }

}
