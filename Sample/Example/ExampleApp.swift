import SwiftUI
import WalletConnectSign
import Web3Modal
import CoinbaseWalletSDK
import UIKit

#if DEBUG
import Atlantis
#endif

@main
struct ExampleApp: App {
    
    init() {
        #if DEBUG
        Atlantis.start()
        #endif

        let metadata = AppMetadata(
            name: "Web3Modal Swift Dapp",
            description: "Web3Modal DApp sample",
            url: "wallet.connect",
            icons: ["https://avatars.githubusercontent.com/u/37784886"],
            redirect: .init(native: "w3mdapp://", universal: nil)
        )

        let projectId = Secrets.load().projectID

        Networking.configure(
            projectId: projectId,
            socketFactory: WalletConnectSocketClientFactory()
        )

        Web3Modal.configure(
            projectId: projectId,
            metadata: metadata
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    Web3Modal.instance.handleDeeplink(url)
                }
        }
    }
}
