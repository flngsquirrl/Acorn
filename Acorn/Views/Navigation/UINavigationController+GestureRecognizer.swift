//
// UINavigationController+GestureRecognizer.swift
// Acorn
//
// Created by flngsquirrl on 01/03/2025.

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }

    public func gestureRecognizer(_: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
        true
    }
}
