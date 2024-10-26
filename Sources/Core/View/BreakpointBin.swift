//
//  BreakpointBin.swift
//  Adwaita
//
//  Created by david-swift on 21.10.24.
//

import CAdw
import Meta

/// Bind a dimension's to observe whether the child view matches a condition.
public struct BreakpointBin: AdwaitaWidget {

    /// The child view.
    @ViewProperty(
        set: { bin, view in
            var width: Int32 = 0
            var height: Int32 = 0
            gtk_widget_measure(view.cast(), GTK_ORIENTATION_VERTICAL, -1, &height, nil, nil, nil)
            gtk_widget_measure(view.cast(), GTK_ORIENTATION_HORIZONTAL, -1, &width, nil, nil, nil)
            gtk_widget_set_size_request(bin.cast(), width, height)
            adw_breakpoint_bin_set_child(bin.cast(), view.cast())
        },
        pointer: OpaquePointer.self,
        subview: OpaquePointer.self,
        context: AdwaitaMainView.self
    )
    var content

    /// The condition.
    @Property(
        set: { bin, condition, storage in
            let string: OpaquePointer
            switch condition {
            case let .naturalWidth(padding):
                let child = adw_breakpoint_bin_get_child(bin.cast())
                var size: Int32 = 0
                gtk_widget_measure(child, GTK_ORIENTATION_HORIZONTAL, -1, nil, &size, nil, nil)
                string = adw_breakpoint_condition_parse(BreakpointCondition.minWidth(.init(size) + padding).condition)
            case let .naturalHeight(padding):
                let child = adw_breakpoint_bin_get_child(bin.cast())
                var size: Int32 = 0
                gtk_widget_measure(child, GTK_ORIENTATION_VERTICAL, -1, nil, &size, nil, nil)
                string = adw_breakpoint_condition_parse(BreakpointCondition.minHeight(.init(size) + padding).condition)
            default:
                string = adw_breakpoint_condition_parse(condition.condition)
            }
            if let breakpoint = storage.fields["breakpoint"] as? OpaquePointer {
                g_object_unref(adw_breakpoint_get_condition(breakpoint)?.cast())
                adw_breakpoint_set_condition(breakpoint, string)
            } else {
                let breakpoint = adw_breakpoint_new(string); adw_breakpoint_bin_add_breakpoint(bin.cast(), breakpoint)
                storage.fields["breakpoint"] = breakpoint
                if let bin = storage.content["_content"]?.first?.content["append"]?.first {
                    adw_breakpoint_add_setter(
                        breakpoint,
                        bin.opaquePointer?.cast(),
                        "visible",
                        false.gValue
                    )
                }
            }
        },
        pointer: OpaquePointer.self
    )
    var condition: BreakpointCondition = .maxWidth(0)

    /// Whether the child view does not match the condition.
    @BindingProperty(
        observe: { bin, matches, storage in
            storage.notify(name: "current-breakpoint") {
                matches.wrappedValue = adw_breakpoint_bin_get_current_breakpoint(bin.cast()) != nil
            }
        },
        set: { _, _, _ in },
        pointer: OpaquePointer.self
    )
    var matches: Binding<Bool> = .constant(false)

    /// Initialize a breakpoint bin.
    /// - Parameters:
    ///     - condition: The condition.
    ///     - matches: Whether the content matches the condition.
    ///     - content: The content.
    public init(
        condition: BreakpointCondition,
        matches: Binding<Bool>,
        @ViewBuilder content: () -> Body
    ) {
        self.condition = condition
        self.matches = matches
        self.content = content()
    }

    /// Initialize the widget.
    public func initializeWidget() -> Any {
        adw_breakpoint_bin_new()?.opaque() as Any
    }

}

/// A breakpoint condition.
public enum BreakpointCondition: Equatable {

    /// Define a maximum width.
    case maxWidth(_ width: Int)
    /// Define a maximum height.
    case maxHeight(_ height: Int)
    /// Define a minimum width.
    case minWidth(_ width: Int)
    /// Define a minimum height.
    case minHeight(_ height: Int)
    /// The minimum width is the content's natural width.
    case naturalWidth(padding: Int = 0)
    /// The minimum height is the content's natural height.
    case naturalHeight(padding: Int = 0)

    /// The condition to parse.
    var condition: String? {
        switch self {
        case let .maxWidth(width):
            "max-width: \(width)sp"
        case let .maxHeight(height):
            "max-height: \(height)sp"
        case let .minWidth(width):
            "min-width: \(width)sp"
        case let .minHeight(height):
            "min-height: \(height)sp"
        default:
            nil
        }
    }

}
