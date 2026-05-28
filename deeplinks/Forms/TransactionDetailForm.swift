//
//  TransactionDetailForm.swift
//  deeplinks
//
//  Created by Jan Švec on 14.03.2024.
//

import SwiftUI
import UIKit

struct TransactionDetailForm: View {
    @Environment(\.openURL) private var openURL

    @State var amsID = ""
    @State var requestId = "123"

    let path: String

    var body: some View {
        List {
            Section("Request id") {
                TextField("123", text: $requestId)
            }

            Section("AMS ID") {
                TextField("123", text: $amsID)
            }

            Section("") {
                HStack {
                    Spacer()
                    Button("Test") {
                        dismissKeyboard()
                        openURL(buildDeeplink())
                    }
                    Spacer()
                }
            }
        }
        .listSectionSpacing(0)
        .navigationTitle(path)
    }

    func buildDeeplink() -> URL {
        let deeplink = deeplinks.buildDeeplink(
            path: path,
            params: [
                "requestId": requestId,
                "amsID": amsID
            ])

        print(deeplink.absoluteString + "\n")

        return deeplink
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

#Preview {
    TransactionDetailForm(path: "transaction/detail")
}
