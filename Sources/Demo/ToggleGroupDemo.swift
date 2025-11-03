//
//  ToggleGroupDemo.swift
//  Adwaita
//
//  Created by david-swift on 03.11.25.
//

// swiftlint:disable missing_docs no_magic_numbers

import Adwaita
import Foundation

struct ToggleGroupDemo: View {

    @State private var selection: Subview = .view1

    var view: Body {
        ToggleGroup(selection: $selection, values: Subview.allCases)
            .padding()
        VStack {
            Text(selection.rawValue)
                .padding()
                .padding(50, .vertical)
        }
        .card()
        .padding()
    }

    enum Subview: String, ToggleGroupItem, CaseIterable, CustomStringConvertible {

        case view1 = "View 1"
        case view2 = "View 2"

        var id: Self { self }

        var description: String { rawValue }

        var icon: Icon? { nil }

        var showLabel: Bool { true }

    }

}

// swiftlint:enable missing_docs no_magic_numbers
