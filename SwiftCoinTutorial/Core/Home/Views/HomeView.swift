//
//  HomeView.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 21/02/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    // top movers view
                    TopMoversView(viewModel: viewModel)
                    
                    Divider()
                    
                    // all coins view
                    AllCoinsView(viewModel: viewModel)
                }
                
                if viewModel.isLoadingData {
                    CustomLoadingIndicator()
                }
            }
            .navigationTitle("Live Prices")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
