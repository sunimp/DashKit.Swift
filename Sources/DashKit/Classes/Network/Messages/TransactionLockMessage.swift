import BitcoinCore
import Foundation
import WWExtensions

struct TransactionLockMessage: IMessage {
    let transaction: FullTransaction

    var description: String {
        "\(transaction.header.dataHash.ww.reversedHex)"
    }
}
