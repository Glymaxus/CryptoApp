//
//  ChartData.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 22/02/2023.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let value: Double
}
