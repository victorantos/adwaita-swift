//
//  Bool.swift
//  Adwaita
//
//  Created by david-swift on 15.01.24.
//

import CAdw

extension Bool {

    /// Get the gboolean for C.
    public var cBool: Int32 {
        self ? 1 : 0
    }

    /// The gboolean as a GValue.
    public var gValue: UnsafePointer<GValue> {
        let pointer = UnsafeMutablePointer<GValue>.allocate(capacity: 1)
        pointer.initialize(to: gtui_initialize_boolean(cBool))
        return .init(pointer)
    }

}
