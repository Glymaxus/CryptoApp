//
//  ChartView.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 22/02/2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    let viewModel: CoinDetailsViewModel
    var body: some View {
        Chart {
            ForEach(viewModel.chartData) { item in
                LineMark(x: .value("Date", item.date),
                         y: .value("Price", item.value))
                .interpolationMethod(.cardinal)
                .foregroundStyle(viewModel.chartLineColor)
                
            }
        }
        .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.startDate, upper: viewModel.endDate)))
        .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: viewModel.minPrice, upper: viewModel.maxPrice)))
        .chartXAxis {
            AxisMarks(position: .bottom, values: viewModel.xAxisValues) { value in
                AxisGridLine() // pour mettre les lignes si besoins
                AxisValueLabel() {
                    if let dateValue = value.as(Date.self) {
                        Text(dateValue.asShortDateString())
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: viewModel.yAxisValues) { value in
                AxisGridLine() // pour mettre les lignes si besoins
                AxisValueLabel() {
                    if let doubleValue = value.as(Double.self) {
                        Text(doubleValue.formattedWithAbbreviations())
                    }
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(viewModel: CoinDetailsViewModel(coin: dev.coin))
    }
}
