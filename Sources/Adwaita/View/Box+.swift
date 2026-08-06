//
//  Box+.swift
//  Adwaita
//
//  Created by david-swift on 16.10.24.
//

extension Box {

    /// Link the children.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func linked(_ active: Bool = true) -> AnyView {
        style("linked", active: active)
    }

}
