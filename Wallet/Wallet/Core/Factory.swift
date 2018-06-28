import Foundation
import RxSwift

class Factory {
    static let instance = Factory()

    private var instances = [String: Any]()

    private init() {
    }

    var stubWalletDataProvider: StubWalletDataProvider { return getInstance(creator: {
        return StubWalletDataProvider()
    })}

    var stubSettingsProvider: StubSettingsProvider { return getInstance(creator: {
        return StubSettingsProvider()
    })}

    var userDefaultsStorage: UserDefaultsStorage { return getInstance(creator: {
        return UserDefaultsStorage()
    })}

    var randomProvider: RandomProvider { return getInstance(creator: {
        return RandomProvider()
    })}

    var mnemonicManager: MnemonicManager { return getInstance(creator: {
        return MnemonicManager()
    })}

    var databaseManager: DatabaseManager { return getInstance(creator: {
        return DatabaseManager()
    })}

    var networkManager: NetworkManager { return getInstance(creator: {
        return NetworkManager(apiUrl: "http://bitnode.grouvi.org:3000/api")
    })}

    var walletManager: WalletManager { return getInstance(creator: {
        return WalletManager()
    })}

    var realmManager: RealmManager { return getInstance(creator: {
        return RealmManager()
    })}

    var loginManager: LoginManager { return getInstance(creator: {
        return LoginManager(networkManager: networkManager, walletManager: walletManager, realmManager: realmManager, localStorage: userDefaultsStorage)
    })}

    private func getInstance<T>(creator: () -> T) -> T {
        let className = String(describing: T.self)

        if let instance = instances[className] as? T {
            return instance
        }

        let instance = creator()
        instances[className] = instance
        return instance
    }

}
