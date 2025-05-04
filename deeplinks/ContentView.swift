//
//  ContentView.swift
//  deeplinks
//
//  Created by Jan Švec on 13.03.2024.
//

import GPtomSDK
import SwiftUI

public enum Menu: CaseIterable, Identifiable {
    public var id: Self { self }

    case createTransaction
    case cancelTransaction
    case refundTransaction
    case transactionDetail
    case closeBatch
//    case batchDetail
    case login
    case result

    var path: String {
        switch self {
        case .createTransaction: "transaction/create"
        case .cancelTransaction: "transaction/cancel"
        case .refundTransaction: "transaction/refund"
        case .transactionDetail: "transaction/detail"
        case .closeBatch: "batch/close"
//        case .batchDetail: "batch/detail"
        case .login: "login"
        case .result: "result"
        }
    }
}

var result: DeeplinkResult?

struct ContentView: View {
    @State var stack = [Menu]()

    var body: some View {
        NavigationStack(path: $stack) {
            List {
                ForEach(Menu.allCases) { item in
                    NavigationLink(value: item) {
                        Text(item.path)
                    }
                }
            }
            .navigationTitle("GP tom deeplinks")
            .navigationDestination(for: Menu.self) { item in
                switch item {
                case .createTransaction:
                    CreateTransactionForm(path: item.path)
                case .cancelTransaction:
                    CancelTransactionForm(path: item.path)
                case .refundTransaction:
                    RefundForm(path: item.path)
                case .transactionDetail:
                    TransactionDetailForm(path: item.path)
                case .closeBatch:
                    CloseBatchForm(path: item.path)
//                case .batchDetail:
//                    CreateTransactionForm()
                case .login:
                    LoginForm(path: item.path)
                case .result:
                    ResultForm(result: result)
                }
            }
            .onOpenURL { url in
                result = DeeplinkResult.from(url: url)
                stack.append(.result)
            }
        }
    }
}

public func buildDeeplink(scheme: String = "gptom",
                          path: String,
                          params: [String: String?]) -> URL
{
    var components = URLComponents(string: "\(scheme)://\(path)")!

    let params = params
        .filter { $0.value != nil }
        .map {
            URLQueryItem(name: $0, value: $1)
        }

    components.queryItems = params.isEmpty ? nil : params

    return components.url(relativeTo: nil)!
}

#Preview {
    ContentView()
}
