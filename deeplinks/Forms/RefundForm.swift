//
//  RefundForm.swift
//  deeplinks
//
//  Created by Jan Švec on 02.05.2025.
//

import GPtomSDK
import SwiftUI

struct RefundForm: View {
    @State var amount = "2"
    @State var clientID = ""
    @State var referenceNumber = "12345"
    @State var printByPaymentApp = false
    @State var redirectUrl = ""
    @State var preferableReceiptType = ReceiptOption.qr
    @State var transactionType = TransactionType.card
    @State var clientPhone = "+420606505404"
    @State var clientEmail = "info@gptom.com"

    let path: String

    var body: some View {
        List {
            Section("Amount") {
                TextField("1000", text: $amount)
            }

            Section("Client ID") {
                TextField("123", text: $clientID)
            }

            Section("origin Reference Num") {
                TextField("123", text: $referenceNumber)
            }

            Section("print By Payment App") {
                Picker(selection: $printByPaymentApp) {
                    Text("True").tag(true)
                    Text("False").tag(false)
                } label: {
                    Text("")
                }
            }

            Section("redirect Url") {
                TextField("tomdeeplink://...", text: $redirectUrl)
            }

            Section("Transaction Type") {
                Picker(selection: $transactionType) {
                    Text("Card").tag(TransactionType.card)
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
                TextField("+420606505404", text: $clientPhone)
            }

            Section("client Email") {
                TextField("info@gptom.com", text: $clientEmail)
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
                "amount": amount
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),

                "clientID": clientID,
                "originReferenceNum": referenceNumber
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                "printByPaymentApp": printByPaymentApp.description,
                "redirectUrl": redirectUrl
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                "preferableReceiptType": preferableReceiptType.rawValue,
                "clientPhone": clientPhone,
                "clientEmail": clientEmail,
                "transactionType": transactionType.rawValue
            ])

        print(deeplink.absoluteString + "\n")

        return deeplink
    }
}

#Preview {
    NavigationStack {
        CreateTransactionForm(path: "transaction/refund")
    }
}
