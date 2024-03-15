//
//  IntExtension.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 15/03/2024.
//

import Foundation

extension Int {
    func convertToReadableTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        let remaining: TimeInterval = Double(self) * 60
        let result = formatter.string(from: remaining) ?? ""
        return result
        
    }
}
