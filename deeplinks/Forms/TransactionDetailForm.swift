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
    @State var clientID = ""
    /// Empty opens the detail in the payment app; otherwise the detail is returned here.
    @State var redirectUrl = ""

    let path: String

    var body: some View {
        List {
            Section("Request id") {
                TextField("123", text: $requestId)
            }

            Section("AMS ID") {
                TextField("123", text: $amsID)
            }

            Section("Client ID") {
                TextField("", text: $clientID)
            }

            Section("redirect Url (empty opens the detail)") {
                TextField("tomdeeplink://...", text: $redirectUrl)
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
        .onAppear {
            redirectUrl = deeplinks
                .buildDeeplink(
                    scheme: "gp",
                    path: path,
                    params: [:])
                .absoluteString
        }
    }

    func buildDeeplink() -> URL {
        let deeplink = deeplinks.buildDeeplink(
            path: path,
            params: [
                "requestId": requestId,
                "amsID": amsID,
                "clientID": clientID,
                "redirectUrl": redirectUrl.isEmpty
                    ? nil
                    : redirectUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
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
