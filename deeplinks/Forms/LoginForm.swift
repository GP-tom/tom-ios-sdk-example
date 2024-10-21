//
//  LoginForm.swift
//  deeplinks
//
//  Created by Jan Švec on 28.03.2024.
//

import Foundation
import SwiftUI

struct LoginForm: View {
    @State var username = ""
    @State var password = ""
    @State var tid = ""

    let path: String

    var body: some View {
        List {
            Section("Username") {
                TextField("", text: $username)
            }

            Section("Password") {
                TextField("", text: $password)
            }

            Section("TID") {
                TextField("", text: $tid)
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
                "username": username,
                "password": password,
                "tid": tid,
            ])

        print(deeplink.absoluteString + "\n")

        return deeplink
    }
}

#Preview {
    NavigationStack {
        CloseBatchForm(path: "login")
    }
}
