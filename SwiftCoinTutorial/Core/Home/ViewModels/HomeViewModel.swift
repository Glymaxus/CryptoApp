//
//  HomeViewModel.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 21/02/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var topMovingCoins = [Coin]()
    @Published var isLoadingData = true
    init() {
        fetchCoinData()
    }
    
    func fetchCoinData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                self.isLoadingData = false
                return
            }
            
            if let reponse = response as? HTTPURLResponse {
                print("DEBUG : Response code \(reponse.statusCode)")
            }
            
            guard let data = data else { return }
//            let dataAsString = String(data: data, encoding: .utf8)
//            print("DEBUG: Data \(dataAsString)")
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                print("DEBUG: coins \(coins)")
                DispatchQueue.main.async {
                    self.coins = coins
                    self.configureTopMovingCoins()
                    self.isLoadingData = false
                }
            } catch let error {
                print("DEBUG: Failed to decode with error \(error)")
                self.isLoadingData = false
            }
            
        }.resume()
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}
