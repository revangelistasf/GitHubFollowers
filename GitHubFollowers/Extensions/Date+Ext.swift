//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 16/08/2020.
//  Copyright © 2020 Roberto Evangelista. All rights reserved.
//

import Foundation

extension Date {
    
    func convertMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
