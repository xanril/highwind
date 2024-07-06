//
//  View+OnFirstAppear.swift
//  This adds an extension modifier to views that are designed to be called when
//  the view first appears.
//
//  Taken from: https://www.swiftjectivec.com/swiftui-run-code-only-once-versus-onappear-or-task/
//
//  Created by Kristian Mitra on 2/21/24.
//
import SwiftUI

public extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    
    // Use this to only fire your block one time
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
