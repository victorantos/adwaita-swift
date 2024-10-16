//
//  StatusPage+.swift
//  Adwaita
//
//  Created by david-swift on 16.10.24.
//

extension StatusPage {

    /// Make the status page more compact.
    /// - Parameter active: Whether the style is applied.
    /// - Returns: A view.
    public func compact(_ active: Bool = true) -> AnyView {
        style("compact", active: active)
    }

}
