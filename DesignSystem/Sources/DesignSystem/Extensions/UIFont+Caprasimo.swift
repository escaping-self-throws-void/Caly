//
//  UIFont+Caprasimo.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

public extension UIFont {
    class var caprasimo16: UIFont {
        .init(name: "Caprasimo-Regular", size: 16) ?? .systemFont(ofSize: 16)
    }
    class var caprasimo18: UIFont {
        .init(name: "Caprasimo-Regular", size: 18) ?? .systemFont(ofSize: 18)
    }
}
