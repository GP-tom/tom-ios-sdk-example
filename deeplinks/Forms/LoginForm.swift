import Foundation
import SwiftUI
import UIKit

struct LoginForm: View {
    @Environment(\.openURL) private var openURL

    @State private var username = ""
    @State private var password = ""
    @State private var tid = ""
    @State private var redirectUrl = ""

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

            Section("RedirectURL") {
                TextField("", text: $redirectUrl)
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
        .onAppear {
            redirectUrl = deeplinks
                .buildDeeplink(
                    scheme: "gp",
                    path: path,
                    params: [:]
                )
                .absoluteString
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
                "redirectUrl": redirectUrl
            ]
        )

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
    NavigationStack {
        CloseBatchForm(path: "login")
    }
}
