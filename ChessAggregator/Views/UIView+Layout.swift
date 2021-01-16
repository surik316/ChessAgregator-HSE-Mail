//
//  UIView+Layout.swift
//  CollectionsDemo
//
//  Created by a.dirsha on 19.10.2020.
//
import UIKit

extension UIView {
    func top(_ constant: CGFloat = 0.0) {
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: constant).isActive = true
    }

    func bottom(_ constant: CGFloat = 0.0) {
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: constant).isActive = true
    }

    func leading(_ constant: CGFloat = 0.0) {
        self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: constant).isActive = true
    }

    func trailing(_ constant: CGFloat = 0.0) {
        self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: constant).isActive = true
    }

    func horizontal(_ leading: CGFloat = 0.0, trailing: CGFloat = 0.0) {
        self.leading(leading)
        self.trailing(trailing)
    }

    func vertical(_ top: CGFloat = 0.0, bottom: CGFloat = 0.0) {
        self.top(top)
        self.bottom(bottom)
    }

    func centerY() {
        self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
    }

    func pins(_ insets: UIEdgeInsets = .zero) {
        self.top(insets.top)
        self.leading(insets.left)
        self.trailing(insets.right)
        self.bottom(insets.bottom)
    }
}