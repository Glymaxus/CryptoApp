//
//  AllCoinsView.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 21/02/2023.
//

import SwiftUI

struct AllCoinsView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Coins")
                .font(.headline)
                .padding()
            
            HStack{
                Text("Coin")
                
                Spacer()
                
                Text("Prices")
            }
            .foregroundColor(.gray)
            .font(.caption)
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.coins) { coin in
                        NavigationLink {
                            LazyNavigationView(CoinDetailsView(coin: coin))
                        } label: {
                            CoinRowView(coin: coin)
                        }
                        .buttonStyle(PlainButtonStyle())

                    }
                }
            }
        }
    }
}

//struct AllCoinsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCoinsView()
//    }
//}
