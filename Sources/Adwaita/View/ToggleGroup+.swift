//
//  ToggleGroup+.swift
//  Adwaita
//
//  Created by david-swift on 03.11.25.
//

import CAdw
import LevenshteinTransformations

extension ToggleGroup {

    /// The identifier for the values.
    static var values: String { "values" }
    /// The identifier for the toggles.
    static var toggle: String { "Toggle::" }

    /// Initialize a toggle group.
    /// - Parameters:
    ///     - selection: The selected value.
    ///     - values: The available values.
    public init<Element>(
        selection: Binding<Element.ID>,
        values: [Element]
    ) where Element: ToggleGroupItem {
        self.init()
        appearFunctions.append { storage, _ in
            storage.notify(name: "active-name", id: "init") {
                if let name = adw_toggle_group_get_active_name(storage.opaquePointer),
                let values = storage.fields[Self.values] as? [Element],
                let value = values.first(where: { $0.id.description == String(cString: name) }) {
                    selection.wrappedValue = value.id
                }
            }
            Self.updateContent(
                storage: storage,
                selection: selection.wrappedValue,
                values: values,
                updateProperties: true
            )
        }
        updateFunctions.append { storage, _, updateProperties in
            Self.updateContent(
                storage: storage,
                selection: selection.wrappedValue,
                values: values,
                updateProperties: updateProperties
            )
        }
    }

    /// Update the combo row's content.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - values: The elements.
    ///     - updateProperties: Whether to update the properties.
    static func updateContent<Element>(
        storage: ViewStorage,
        selection: Element.ID,
        values: [Element],
        updateProperties: Bool
    ) where Element: ToggleGroupItem {
        guard updateProperties else {
            return
        }
        let old = storage.fields[Self.values] as? [Element] ?? []
        old.identifiableTransform(
            to: values,
            functions: .init { index in
                if let id = old[safe: index]?.id.description,
                let toggle = storage.fields[Self.toggle + id] as? OpaquePointer {
                    adw_toggle_group_remove(storage.opaquePointer, toggle)
                }
            } insert: { _, element in
                let toggle = adw_toggle_new()
                adw_toggle_set_name(toggle, element.id.description)
                if element.showLabel {
                    adw_toggle_set_label(toggle, element.id.description)
                } else {
                    adw_toggle_set_tooltip(toggle, element.id.description)
                }
                if let icon = element.icon {
                    adw_toggle_set_icon_name(toggle, icon.string)
                }
                storage.fields[Self.toggle + element.id.description] = toggle
                adw_toggle_group_add(storage.opaquePointer, toggle)
            }
        )
        storage.fields[Self.values] = values
        adw_toggle_group_set_active_name(storage.opaquePointer, selection.description)
    }

}

/// An item of a toggle group.
public protocol ToggleGroupItem: Identifiable where Self.ID: CustomStringConvertible {

    /// The item's icon.
    var icon: Icon? { get }
    /// Whether to show the label in the UI (the identifier's string conversion).
    ///
    /// Otherwise, it will be used as the tooltip.
    var showLabel: Bool { get }

}
