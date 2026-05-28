import Foundation
import SwiftUI

struct ChangePasswordForm: View {
    @State private var username = ""
    @State private var password = ""
    @State private var newPassword = ""
    @State private var code = ""
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

            Section("New password") {
                TextField("", text: $newPassword)
            }

            Section("TID (first login only)") {
                TextField("", text: $tid)
            }

            Section("Code (first login only)") {
                TextField("", text: $code)
            }

            Section("RedirectURL") {
                TextField("", text: $redirectUrl)
            }

            Section("") {
                HStack {
                    Spacer()
                    Link("Test", destination: buildDeeplink())
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
                "newPassword": newPassword,
                "code": code,
                "tid": tid,
                "redirectUrl": redirectUrl
            ]
        )

        print(deeplink.absoluteString + "\n")

        return deeplink
    }
}

#Preview {
    NavigationStack {
        CloseBatchForm(path: "login")
    }
}
