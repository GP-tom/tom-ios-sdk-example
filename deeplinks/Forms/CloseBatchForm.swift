//
//  CloseBatchForm.swift
//  deeplinks
//
//  Created by Jan Švec on 18.03.2024.
//

import Foundation
import GPtomSDK
import SwiftUI

struct CloseBatchForm: View {
    @State var clientID = ""
    @State var redirectUrl = ""
    @State var printByPaymentApp = false
    @State var preferableReceiptType = ReceiptOption.qr
    @State var clientPhone = "+420606505404"
    @State var clientEmail = "info@gptom.com"

    let path: String

    var body: some View {
        List {
            Section("Client ID") {
                TextField("123", text: $clientID)
            }

            Section("redirect Url") {
                TextField("tomdeeplink://...", text: $redirectUrl)
            }

            Section("print By Payment App") {
                Picker(selection: $printByPaymentApp) {
                    Text("True").tag(true)
                    Text("False").tag(false)
                } label: {
                    Text("")
                }
            }

            Section("preferable Receipt Type") {
                Picker(selection: $preferableReceiptType) {
                    Text("SMS").tag(ReceiptOption.sms)
                    Text("Email").tag(ReceiptOption.email)
                    Text("QR").tag(ReceiptOption.qr)
                    Text("Print").tag(ReceiptOption.print)
                } label: {
                    Text("")
                }
            }

            Section("client Phone") {
                TextField("info@gptom.com", text: $clientPhone)
            }

            Section("client Email") {
                TextField("+420606505404", text: $clientEmail)
            }

            Section("") {
                HStack {
                    Spacer()
                    Link("Test", destination: buildDeeplink())
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
                "clientID": clientID,
                "redirectUrl": redirectUrl
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                "printByPaymentApp": printByPaymentApp.description,
                "preferableReceiptType": preferableReceiptType.rawValue,
                "clientPhone": clientPhone,
                "clientEmail": clientEmail
            ])

        print(deeplink.absoluteString + "\n")

        return deeplink
    }
}

#Preview {
    NavigationStack {
        CloseBatchForm(path: "batch/close")
    }
}
