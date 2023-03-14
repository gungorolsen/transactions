//
//  AccountDetailsView.swift
//  Transactions
//
//  Created by Olsen Gungor on 4/12/2022.
//

import SwiftUI

struct AccountHeaderView: View {
    
    private let viewModel: AccountDetailsViewItem

    init(viewModel: AccountDetailsViewItem) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Image("account")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(15)

                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.accountName)
                            .font(.custom("HelveticaNeue-Light", fixedSize: 18))
                            .foregroundColor(Color.accountText)
                        Text(viewModel.accountNumber)
                            .font(.custom("HelveticaNeue-Light", fixedSize: 14))
                            .foregroundColor(Color.greyText)
                    }
                    .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 15))

                    Spacer()
                }
                .background(Color.white)
                .frame(maxWidth: .infinity)

                HStack {
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Available funds")
                                .font(.custom("HelveticaNeue-Light", fixedSize: 15))
                                .foregroundColor(Color.greyText)

                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(viewModel.availableBalance)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.custom("HelveticaNeue-Light", fixedSize: 15).weight(.heavy))

                        }
                        .padding(EdgeInsets(top: 15, leading: 85, bottom: 3, trailing: 15))

                        HStack {
                            Text("Available balance")
                                .font(.custom("HelveticaNeue-Light", fixedSize: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color.greyText)

                            Text(viewModel.availableFunds)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color.greyText)
                                .font(.custom("HelveticaNeue-Light", fixedSize: 15).weight(.heavy))

                        }
                        .padding(EdgeInsets(top: 0, leading: 85, bottom: 10, trailing: 15))

                    }
                }
                .background(Color.greyBackground)
                .frame(maxWidth: .infinity)
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 20, trailing: 15))

        }
        .background(Color.accountDetailsBackground)
        .frame(maxWidth: .infinity)
    }
}


