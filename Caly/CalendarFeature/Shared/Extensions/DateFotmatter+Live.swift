//
//  DateFotmatter+Live.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import Foundation

extension DateFormatter {
    static var live: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter
    }
}
