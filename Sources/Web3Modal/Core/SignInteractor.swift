import Foundation
import Combine
import CoinbaseWalletSDK

class SignInteractor: ObservableObject {
    
    private let store: Store
    
    lazy var sessionsPublisher: AnyPublisher<[Session], Never> = Web3Modal.instance.sessionsPublisher
    lazy var sessionSettlePublisher: AnyPublisher<Session, Never> = Web3Modal.instance.sessionSettlePublisher
    lazy var sessionResponsePublisher: AnyPublisher<Response, Never> = Web3Modal.instance.sessionResponsePublisher
    lazy var sessionRejectionPublisher: AnyPublisher<(Session.Proposal, Reason), Never> = Web3Modal.instance.sessionRejectionPublisher
    lazy var sessionDeletePublisher: AnyPublisher<(String, Reason), Never> = Web3Modal.instance.sessionDeletePublisher
    lazy var sessionEventPublisher: AnyPublisher<(event: Session.Event, sessionTopic: String, chainId: Blockchain?), Never> = Web3Modal.instance.sessionEventPublisher
    
    init(store: Store = .shared) {
        self.store = store
    }
    
    func createPairingAndConnect() async throws {
        let uri = try await Web3Modal.instance.connect(topic: nil)
        
        DispatchQueue.main.async {
            self.store.uri = uri
        }
    }
    
    func disconnect() async throws {
        defer {
            DispatchQueue.main.async {
                self.store.session = nil
                self.store.account = nil
            }
        }
        
        switch store.connectedWith {
        case .wc:
            do {
                try await Web3Modal.instance.disconnect(topic: store.session?.topic ?? "")
            } catch {
                DispatchQueue.main.async {
                    self.store.toast = .init(style: .error, message: "Failed to disconnect.")
                }
            }
            try await Web3Modal.instance.cleanup()
            try await createPairingAndConnect()
        case .cb:
            CoinbaseWalletSDK.shared.resetSession()
        case .none:
            break
        }
    }
}
