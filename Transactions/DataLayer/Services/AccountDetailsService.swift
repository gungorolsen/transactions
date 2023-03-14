//
//  TransactionsService.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

class AccountDetailsService {

    // MARK: Properties
    
    private let httpClient: HTTPClientType
    private let mapper: AccountDetailsMapping
    
    // MARK: Initialiser
    
    // Injecting MockSessionProvider - Bonus Point :)
    init(httpClient: HTTPClientType = HTTPClient(urlSessionProvider: MockURLSessionProvider()),
         mapper: AccountDetailsMapping = AccountDetailsMapper()) {
        self.httpClient = httpClient
        self.mapper = mapper
    }
}

extension AccountDetailsService: AccountDetailsRepo {
        
    func fetchAccountDetails() async throws -> AccountDetails {
        let response: AccountDetailsResponse = try await httpClient.dataTaskPublisher(urlString: urlString)
        return mapper.mapToDomain(from: response)
    }
    
    // Dummy URL
    private var urlString: String {
        "http://google.com"
    }
}
