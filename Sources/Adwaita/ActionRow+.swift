//
//  ActionRow+.swift
//  Adwaita
//
//  Created by david-swift on 16.10.24.
//

extension ActionRow {

    /// Deemphasize the row title and emphasize the subtitle.
    /// - Parameter active: Whether the style is currently applied.
    /// - Returns: A view.
    public func property(_ active: Bool = true) -> AnyView {
        style("property", active: active)
    }

}
