import Foundation

struct WalletDTO: Codable {
    let id: String
    let name: String
    let homepage: String
    let imageId: String
    let order: Int
    let mobileLink: String?
    let desktopLink: String?
    let webappLink: String?
    let appStore: String?
    
    var lastTimeUsed: Date?
    var isInstalled: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case homepage
        case imageId = "image_id"
        case order
        case mobileLink = "mobile_link"
        case desktopLink = "desktop_link"
        case webappLink = "webapp_link"
        case appStore = "app_store"
        
        // Decorated
        case lastTimeUsed
        case isInstalled
    }
}

struct Wallet: Identifiable, Hashable {
    
    
    static func == (lhs: Wallet, rhs: Wallet) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let name: String
    let homepage: String
    let imageId: String
    let order: Int
    let mobileLink: String?
    let desktopLink: String?
    let webappLink: String?
    let appStore: String?
    
    var lastTimeUsed: Date?
    var isInstalled: Bool? = false
    var alternativeConnectionMethod: (() -> Void)? = nil
    
    init(dto: WalletDTO) {
        self.id = dto.id
        self.name = dto.name
        self.homepage = dto.homepage
        self.imageId = dto.imageId
        self.order = dto.order
        self.mobileLink = dto.mobileLink
        self.desktopLink = dto.desktopLink
        self.webappLink = dto.webappLink
        self.appStore = dto.appStore
        self.lastTimeUsed = dto.lastTimeUsed
        self.isInstalled = dto.isInstalled
    }
    
    init(
        id: String,
        name: String,
        homepage: String,
        imageId: String,
        order: Int,
        mobileLink: String? = nil,
        desktopLink: String? = nil,
        webappLink: String? = nil,
        appStore: String? = nil,
        lastTimeUsed: Date? = nil,
        isInstalled: Bool? = false,
        alternativeConnectionMethod: (() -> Void)? = nil
    ) {
        self.id = id
        self.name = name
        self.homepage = homepage
        self.imageId = imageId
        self.order = order
        self.mobileLink = mobileLink
        self.desktopLink = desktopLink
        self.webappLink = webappLink
        self.appStore = appStore
        self.lastTimeUsed = lastTimeUsed
        self.isInstalled = isInstalled
        self.alternativeConnectionMethod = alternativeConnectionMethod
    }
    
    func toDto() -> WalletDTO {
        WalletDTO(
            id: id,
            name: name,
            homepage: homepage,
            imageId: imageId,
            order: order,
            mobileLink: mobileLink,
            desktopLink: desktopLink,
            webappLink: webappLink,
            appStore: appStore,
            lastTimeUsed: lastTimeUsed,
            isInstalled: isInstalled
        )
    }
}

#if DEBUG

extension Wallet {
    static let stubList: [Wallet] = [
        Wallet(
            id: UUID().uuidString,
            name: "Sample Wallet",
            homepage: "https://example.com/cool",
            imageId: "0528ee7e-16d1-4089-21e3-bbfb41933100",
            order: 1,
            mobileLink: "https://sample.com/foo/universal",
            desktopLink: "sampleapp://deeplink",
            webappLink: "https://sample.com/foo/webapp",
            appStore: ""
        ),
        Wallet(
            id: UUID().uuidString,
            name: "Cool Wallet",
            homepage: "https://example.com/cool",
            imageId: "5195e9db-94d8-4579-6f11-ef553be95100",
            order: 2,
            mobileLink: "awsomeapp://",
            desktopLink: "awsomeapp://deeplink",
            webappLink: "https://awesome.com/foo/webapp",
            appStore: ""
        ),
        Wallet(
            id: UUID().uuidString,
            name: "Cool Wallet",
            homepage: "https://example.com/cool",
            imageId: "3913df81-63c2-4413-d60b-8ff83cbed500",
            order: 3,
            mobileLink: "https://cool.com/foo/universal",
            desktopLink: "coolapp://deeplink",
            webappLink: "https://cool.com/foo/webapp",
            appStore: ""
        )
    ]
}

#endif
