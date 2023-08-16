//
//  DateFotmatter+Live.swift
//  Caly
//
//  Created by Paul Matar on 16/08/2023.
//

import Foundation

extension DateFormatter {
    static var date: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter
    }
    
    static var time: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }
}
