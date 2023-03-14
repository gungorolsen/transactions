//
//  TransactionsSectionHeaderView.swift
//  Transactions
//
//  Created by Olsen Gungor on 4/12/2022.
//

import SwiftUI

struct SectionHeaderView: View {
    
    private let viewModel: TransactionGroupSectionViewItem
    
    init(viewModel: TransactionGroupSectionViewItem) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.displayDate)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.black)
            Text(viewModel.sinceDisplayDate)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(Color.black)
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        .background(Color.sectionBackground)
    }
    
}
