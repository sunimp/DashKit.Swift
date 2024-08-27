//
//  ISLockMessage.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

// MARK: - ISLockMessage

struct ISLockMessage: IMessage {
    let command = "islock"

    let inputs: [Outpoint]
    let txHash: Data
    let sign: Data
    let hash: Data

    let requestID: Data

    var description: String {
        "\(txHash) - \(inputs.count) inputs locked"
    }
}

// MARK: Hashable

extension ISLockMessage: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(hash)
    }

    public static func == (lhs: ISLockMessage, rhs: ISLockMessage) -> Bool {
        lhs.hash == rhs.hash && lhs.sign == rhs.sign
    }
}
