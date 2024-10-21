//
//  TransactionDetailForm.swift
//  deeplinks
//
//  Created by Jan Švec on 14.03.2024.
//

import SwiftUI

struct TransactionDetailForm: View {
    @State var amsID = ""

    let path: String

    var body: some View {
        List {
            Section("AMS ID") {
                TextField("123", text: $amsID)
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
    }

    func buildDeeplink() -> URL {
        let deeplink = deeplinks.buildDeeplink(
            path: path,
            params: [
                "amsID": amsID
            ])

        print(deeplink.absoluteString + "\n")

        return deeplink
    }
}

#Preview {
    TransactionDetailForm(path: "transaction/detail")
}
