//
//  Spinner.swift
//  Adwaita
//
//  Created by auto-generation on 26.10.24.
//

import CAdw
import LevenshteinTransformations

/// A widget showing a loading spinner.
/// 
/// <picture><source srcset="spinner-dark.png" media="(prefers-color-scheme: dark)"><img src="spinner.png" alt="spinner"></picture>
/// 
/// The size of the spinner depends on the available size, never smaller than
/// 16×16 pixels and never larger than 64×64 pixels.
/// 
/// Use the [property@Gtk.Widget:halign] and [property@Gtk.Widget:valign]
/// properties in combination with [property@Gtk.Widget:width-request] and
/// [property@Gtk.Widget:height-request] for fine sizing control.
/// 
/// For example, the following snippet shows the spinner at 48×48 pixels:
/// 
/// ```xml
/// <object class="AdwSpinner"><property name="halign">center</property><property name="valign">center</property><property name="width-request">48</property><property name="height-request">48</property></object>
/// ```
/// 
/// See [class@SpinnerPaintable] for cases where using a widget is impractical or
/// impossible, such as [property@StatusPage:paintable].
/// 
/// ## CSS nodes
/// 
/// `AdwSpinner` has a single node with the name `image` and the style class
/// `.spinner`.
public struct Spinner: AdwaitaWidget {

    /// Additional update functions for type extensions.
    var updateFunctions: [(ViewStorage, WidgetData, Bool) -> Void] = []
    /// Additional appear functions for type extensions.
    var appearFunctions: [(ViewStorage, WidgetData) -> Void] = []


    /// Initialize `Spinner`.
    public init() {
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(data: WidgetData, type: Data.Type) -> ViewStorage where Data: ViewRenderData {
        let storage = ViewStorage(adw_spinner_new()?.opaque())
        for function in appearFunctions {
            function(storage, data)
        }
        update(storage, data: data, updateProperties: true, type: type)

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




        }
        for function in updateFunctions {
            function(storage, data, updateProperties)
        }
        if updateProperties {
            storage.previousState = self
        }
    }

}
