//
//  Datehelper.swift
//  Task
//
//  Created by Kaden Staker on 10/11/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
