//
//  DropDown+.swift
//  Adwaita
//
//  Created by david-swift on 09.04.25.
//

import CAdw
import LevenshteinTransformations

extension DropDown {

    /// The identifier for the values.
    static var values: String { "values" }
    /// The identifier for the string list.
    static var stringList: String { "string-list" }

    /// Initialize a combo row.
    /// - Parameters:
    ///     - title: The row's title.
    ///     - selection: The selected value.
    ///     - values: The available values.
    public init<Element>(
        selection: Binding<Element.ID>,
        values: [Element]
    ) where Element: Identifiable, Element: CustomStringConvertible {
        self.init()
        self = self.selected(.init {
            .init(values.firstIndex { $0.id == selection.wrappedValue } ?? 0)
        } set: { index in
            if let id = values[safe: .init(index)]?.id {
                selection.wrappedValue = id
            }
        })
        appearFunctions.append { storage, _ in
            storage.fields[Self.stringList] = gtk_drop_down_get_model(storage.opaquePointer)
            Self.updateContent(storage: storage, values: values, element: Element.self)
        }
        updateFunctions.append { storage, _, _ in
            Self.updateContent(storage: storage, values: values, element: Element.self)
        }
    }

    /// Update the combo row's content.
    /// - Parameters:
    ///     - storage: The view storage.
    ///     - values: The elements.
    ///     - element: The type of the elements.
    static func updateContent<Element>(
        storage: ViewStorage,
        values: [Element],
        element: Element.Type
    ) where Element: Identifiable, Element: CustomStringConvertible {
        if let list = storage.fields[Self.stringList] as? OpaquePointer {
            let old = storage.fields[Self.values] as? [Element] ?? []
            old.identifiableTransform(
                to: values,
                functions: .init { index in
                    gtk_string_list_remove(list, .init(index))
                } insert: { _, element in
                    gtk_string_list_append(list, element.description)
                }
            )
            storage.fields[Self.values] = values
        }
    }

}
