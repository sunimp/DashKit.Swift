import BitcoinCore
import Foundation
import WWCryptoKit

class SingleHasher: IDashHasher {
    func hash(data: Data) -> Data {
        Crypto.sha256(data)
    }
}
