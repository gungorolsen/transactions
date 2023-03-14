//
//  ListView.swift
//  Transactions
//
//  Created by Olsen Gungor on 15/3/2023.
//

import SwiftUI

struct TransactionsListView: View {
    
    private let viewModel: AccountDetailsViewItem
    
    init(viewModel: AccountDetailsViewItem) {
        self.viewModel = viewModel
    }
    
    var body: some View {

        ForEach(viewModel.sortedGroupedTransactions, id: \.self) { section in
            Section(header: SectionHeaderView(viewModel: section)) {
                ForEach(viewModel.getTransactions(for: section)) { transaction in
                    
                    ZStack(alignment: .leading) {
                        if transaction.isAtm {
                            NavigationLink {
                                MapView(viewModel: transaction.atm)
                                    .navigationTitle("ATM Location")
                            } label: {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        
                        TransactionView(viewModel: transaction)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .textCase(nil)
            .listRowInsets(EdgeInsets())
        }

    }
}
