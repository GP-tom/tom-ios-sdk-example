import Foundation
import GPtomSDK
import SwiftUI

struct ResultForm: View {
    let result: DeeplinkResult?

    var body: some View {
        List {
            switch result {
            case let .createTransaction(receipt, code, status, error):
                jsonView(receipt: receipt, code: code, status: status, error: error)

            case let .cancelTransaction(receipt, code, status, error):
                jsonView(receipt: receipt, code: code, status: status, error: error)

            case let .refundTransaction(receipt, code, status, error):
                jsonView(receipt: receipt, code: code, status: status, error: error)

            case let .transactionDetail(receipt, status, error):
                jsonView(receipt: receipt, status: status, error: error)

            case let .closeBatch(batch, status, error):
                jsonView(batch: batch, status: status, error: error)

            case let .status(appStatus, status):
                jsonView(appStatus: appStatus, status: status)

            case let .changePassword(status, error),
                 let .login(status, error):
                jsonView(status: status, error: error)

            case let .logout(status):
                jsonView(status: status)

            case nil:
                Text("Failed to parse result")
            case .some(.login(_, _)):
                Text("Failed to parse result")
            case .some(.logout(_)):
                Text("Failed to parse result")
            case .some(.changePassword(_, _)):
                Text("Failed to parse result")
            }
        }
        .listSectionSpacing(0)
    }

    @ViewBuilder
    func jsonView(
        receipt: TransactionData? = nil,
        batch: Batch? = nil,
        code: RefusalCode? = nil,
        appStatus: AppStatus? = nil,
        status: TaskStatus,
        error: DeeplinkError? = nil
    ) -> some View {
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

        if let error {
            Section("Error") {
                Text(error.rawValue)
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
