//
//  UIView+Constraints.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

public extension UIView {
    func snap(to view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
        ])
    }
    
    @discardableResult
    func place(on view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }
    
    @discardableResult
    func edges(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        insets: UIEdgeInsets = .zero
    ) -> UIView {
        if let top { self.topAnchor.constraint(equalTo: top, constant: insets.top).isActive = true }
        if let leading { self.leadingAnchor.constraint(equalTo: leading, constant: insets.left).isActive = true }
        if let bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: insets.bottom).isActive = true }
        if let trailing { self.trailingAnchor.constraint(equalTo: trailing, constant: insets.right).isActive = true }
        return self
    }
    
    @discardableResult
    func size(width: CGFloat, height: CGFloat) -> UIView {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
        return self
    }
    
    @discardableResult
    func center(in view: UIView, offset: CGPoint = .zero) -> UIView {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.x),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.y),
        ])
        return self
    }
    
    @discardableResult
    func width(value width: CGFloat) -> UIView {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func height(value height: CGFloat) -> UIView {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func top(to view: UIView, value: CGFloat = 0) -> UIView {
        topAnchor.constraint(equalTo: view.topAnchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func top(with anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> UIView {
        topAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func top(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> UIView {
        topAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func leading(to view: UIView, value: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func leading(with anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func leading(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func leading(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func bottom(to view: UIView, value: CGFloat = 0) -> UIView {
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func bottom(with anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> UIView {
        bottomAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func trailing(to view: UIView, value: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func trailing(with anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func trailing(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func trailing(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func centerX(to view: UIView, value: CGFloat = 0) -> UIView {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func centerX(with anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> UIView {
        centerXAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func centerY(to view: UIView, value: CGFloat = 0) -> UIView {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: value).isActive = true
        return self
    }
    
    @discardableResult
    func centerY(with anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> UIView {
        centerYAnchor.constraint(equalTo: anchor, constant: value).isActive = true
        return self
    }
}
