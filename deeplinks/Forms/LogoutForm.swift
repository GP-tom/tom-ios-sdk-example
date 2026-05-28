import Foundation
import SwiftUI

struct LogoutForm: View {

    @State private var redirectUrl = ""

    let path: String

    var body: some View {
        List {
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
