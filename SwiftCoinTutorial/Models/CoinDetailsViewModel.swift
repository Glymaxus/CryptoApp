//
//  CoinDetailsViewModel.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 22/02/2023.
//

import SwiftUI

class CoinDetailsViewModel {
    private let coin: Coin
    
    // chart config
    var chartData = [ChartData]()
    var startDate = Date()
    var endDate = Date()
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues = [Date]()
    var yAxisValues = [Double]()
    
    var coinName: String {
        return coin.name
    }
    
    var chartLineColor: Color {
        let priceChange = (coin.sparklineIn7D?.price.last ?? 0) - (coin.sparklineIn7D?.price.first ?? 0)
        return priceChange > 0 ? .green : .red
    }
    
    var overviewSectionModel: CoinDetailsSectionModel {
        // price stats
        let price = coin.currentPrice.toCurrency()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStats = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        // market cap stats
        let marketCap = coin.marketCap ?? 0
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalisation", value: String(marketCap.formattedWithAbbreviations()), percentageChange: marketCapPercentChange)
        
        // rank stats
        let rank = coin.marketCapRank ?? 0
        let rankStat = StatisticModel(title: "Rank", value: String(rank), percentageChange: nil)
        
        // volume stats
        let volume = coin.totalVolume ?? 0
        let volumeStat = StatisticModel(title: "Volume", value: String(volume.formattedWithAbbreviations()), percentageChange: nil)
        
        return CoinDetailsSectionModel(title: "Overview", stats: [priceStats, marketCapStat, rankStat, volumeStat])
    }
    
    var additionalDetailsSectionModel: CoinDetailsSectionModel {
        // 24h high
        let high = coin.high24H?.toCurrency() ?? "n/a"
        let highStat = StatisticModel(title: "24H High", value: high, percentageChange: nil)
        
        // 24h low
        let low = coin.low24H?.toCurrency() ?? "n/a"
        let lowStat = StatisticModel(title: "24H Low", value: low, percentageChange: nil)
        
        // 24h price change
        let priceChange24h = coin.priceChange24H.toCurrency()
        let percentChange24h = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price change", value: priceChange24h, percentageChange: percentChange24h)
        
        // 24h market cap change
        let marketCapChange = coin.marketCapChange24H ?? 0
        let marketCapChangePercent = coin.marketCapChangePercentage24H
        let marketStat = StatisticModel(title: "24H Market cap change", value: "$\(marketCapChange.formattedWithAbbreviations())", percentageChange: marketCapChangePercent)
        
        return CoinDetailsSectionModel(title: "Additional Details", stats: [highStat, lowStat, priceChangeStat, marketStat])
    }
    
    init(coin: Coin) {
        self.coin = coin
        configureChartData()
        
        print("DEBUG: coin is \(self.coinName)")
    }
    
    func configureChartData() {
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        self.minPrice = priceData.min()!
        self.maxPrice = priceData.max()!
        self.endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice]
        self.xAxisValues = [startDate, endDate]
        
        for price in priceData.reversed() {
            
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            
            let chartDataItem = ChartData(date: date, value: price)
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}

/*
 
 loop tru prices backwards necause we only have end date for time interval
 need to figure out date for each price point
 
 [10, 20, 30, 40] - prices
 
 i
 [40, 30 20, 10] - prices reversed
 [4, 3, 2, 1] - dates (need to figure out how to do this
 
 [(4, 40), (3, 30)] - chart data (result)
 */
