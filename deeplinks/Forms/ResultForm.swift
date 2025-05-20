//
//  ResultForm.swift
//  deeplinks
//
//  Created by Jan Švec on 30.07.2024.
//

import Foundation
import GPtomSDK
import SwiftUI

struct ResultForm: View {
    let result: DeeplinkResult?

    var body: some View {
        List {
            switch result {
            case .createTransaction(let receipt, let code, let status):
                jsonView(receipt: receipt, code: code, status: status)
            case .cancelTransaction(let receipt, let code, let status):
                jsonView(receipt: receipt, code: code, status: status)
            case .refundTransaction(let receipt, let code, let status):
                jsonView(receipt: receipt, code: code, status: status)
            case .closeBatch(let batch, let status):
                jsonView(batch: batch, status: status)
            case .status(let appStatus, let status):
                jsonView(appStatus: appStatus, status: status)
            case nil:
                Text("Failed to parse result")
            }
        }
        .listSectionSpacing(0)
    }

    @ViewBuilder
    func jsonView(receipt: TransactionData? = nil,
                  batch: Batch? = nil,
                  code: RefusalCode? = nil,
                  appStatus: AppStatus? = nil,
                  status: TaskStatus) -> some View
    {
        Section("Task status") {
            Text(status.rawValue.lowercased())
        }

        if let receipt {
            Section("Receipt") {
                Text(receipt.toPrettyString())
            }
        }

        if let code {
            Section("Code") {
                Text(code.rawValue)
            }
        }

        if let batch {
            Section("Batch") {
                Text(batch.toPrettyString())
            }
        }

        if let appStatus {
            Section("AppStatus") {
                Text(appStatus.toPrettyString())
            }
        }
    }
}
