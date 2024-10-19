//
//  ViewSwitcher.swift
//  Adwaita
//
//  Created by david-swift on 03.01.24.
//

import CAdw
import LevenshteinTransformations

/// The view switcher widget.
public struct ViewSwitcher<Element>: AdwaitaWidget where Element: ViewSwitcherOption {

    /// The selected element.
    @Binding var selectedElement: Element
    /// The elements.
    var elements: [Element]
    /// Whether the wide style is used, that means the icons and titles are on the same line.
    var wide = false

    /// Initialize a view switcher.
    /// - Parameters:
    ///     - elements: The elements.
    ///     - selectedElement: The selected element.
    public init(_ elements: [Element], selectedElement: Binding<Element>) {
        self._selectedElement = selectedElement
        self.elements = elements
    }

    /// The view storage.
    /// - Parameters:
    ///     - modifiers: Modify views before being updated.
    ///     - type: The view render data type.
    /// - Returns: The view storage.
    public func container<Data>(
        data: WidgetData,
        type: Data.Type
    ) -> ViewStorage where Data: ViewRenderData {
        let switcher = ViewStorage(adw_view_switcher_new()?.opaque())
        let stack = ViewStorage(adw_view_stack_new()?.opaque())
        adw_view_switcher_set_stack(switcher.opaquePointer, stack.opaquePointer)
        for option in elements {
            adw_view_stack_add_titled_with_icon(
                stack.opaquePointer,
                gtk_label_new(""),
                option.title,
                option.title,
                option.icon.string
            )
        }
        updateSwitcher(switcher: switcher)
        switcher.fields["stack"] = stack
        return switcher
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
        updateSwitcher(switcher: storage)
    }

    /// Update a view switcher's style and selection.
    /// - Parameter switcher: The view switcher.
    func updateSwitcher(switcher: ViewStorage) {
        let stack = switcher.fields["stack"] as? ViewStorage
        stack?.notify(name: "visible-child") {
            if let title = adw_view_stack_get_visible_child_name(stack?.opaquePointer),
            let option = Element(title: .init(cString: title)) {
                selectedElement = option
            }
        }
        if (switcher.previousState as? Self)?.wide != wide {
            adw_view_switcher_set_policy(
                switcher.opaquePointer,
                wide ? ADW_VIEW_SWITCHER_POLICY_WIDE : ADW_VIEW_SWITCHER_POLICY_NARROW
            )
        }
        if (switcher.previousState as? Self)?.selectedElement.title != selectedElement.title {
            let stack = adw_view_switcher_get_stack(switcher.opaquePointer)
            adw_view_stack_set_visible_child_name(stack, selectedElement.title)
        }
        switcher.previousState = self
    }

    /// Set whether to use the wide design.
    /// - Parameter wide: Whether to use the wide design.
    /// - Returns: The view switcher.
    public func wideDesign(_ wide: Bool = true) -> Self {
        var newSelf = self
        newSelf.wide = wide
        return newSelf
    }

}

extension ViewSwitcher where Element: CaseIterable {

    /// Initialize a view switcher.
    /// - Parameter selectedElement: The selected element.
    public init(selectedElement: Binding<Element>) {
        self._selectedElement = selectedElement
        self.elements = .init(Element.allCases)
    }

}

/// The protocol an element type for view switcher has to conform to.
public protocol ViewSwitcherOption {

    /// The title displayed in the switcher and used for identification.
    var title: String { get }
    /// A symbolic representation in the view switcher.
    var icon: Icon { get }

    /// Get the element from the title.
    init?(title: String)

}
