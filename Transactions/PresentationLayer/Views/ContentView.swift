//
//  ContentView.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {

    @StateObject
    var viewModel = AccountDetailsViewModel()

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView().progressViewStyle(.circular).transition(.opacity)
            case .error:
                Button {
                    Task { await viewModel.refreshAccountDetails() }
                } label: {
                    Text("Refresh")
                }.padding()
            case .loaded(let accountDetails):
                List {
                    AccountHeaderView(viewModel: accountDetails)
                        .padding(0)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    TransactionsListView(viewModel: accountDetails)
                }
                .navigationTitle("Account Details")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)

            }
        }
        .task {
            await viewModel.refreshAccountDetails()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
