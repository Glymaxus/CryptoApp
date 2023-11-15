//
//  StatisticModel.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 22/02/2023.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
