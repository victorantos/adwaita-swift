//
//  List+.swift
//  Adwaita
//
//  Created by david-swift on 16.10.24.
//

extension List {

    /// Add the "navigation-sidebar" style class.
    /// - Parameter active: Whether the style is applied.
    /// - Returns: A view.
    public func sidebarStyle(_ active: Bool = true) -> AnyView {
        style("navigation-sidebar", active: active)
    }

    /// Apply the boxed list style class.
    /// - Parameter active: Whether the style is applied.
    /// - Returns: A view.
    public func boxedList(_ active: Bool = true) -> AnyView {
        style("boxed-list", active: active)
    }

}
