//
//  Stylable+UIActivityIndicatorView.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import UIKit

public extension Stylable where Self: UIActivityIndicatorView {
    @discardableResult
    func hidesWhenStopped(_ value: Bool) -> Self {
        self.hidesWhenStopped = value

        return self
    }

    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        self.tintColor = value

        return self
    }
    
    @discardableResult
    func stopAnimation() -> Self {
        self.stopAnimating()

        return self
    }
}
