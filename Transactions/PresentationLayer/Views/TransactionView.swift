//
//  TransactionView.swift
//  Transactions
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import SwiftUI

struct TransactionView: View {
    
    private let viewModel: TransactionViewItem
    
    init(viewModel: TransactionViewItem) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 10) {
            
            HStack {
                if viewModel.isAtm {
                    Image("mapIcon")
                        .resizable()
                        .frame(width: 32, height: 64, alignment: .center)
                }
                (Text(viewModel.pendingDescription).fontWeight(.bold) + Text(viewModel.description))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(viewModel.amount)
                .fixedSize()
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        .frame(maxWidth: .infinity)
    }
}
