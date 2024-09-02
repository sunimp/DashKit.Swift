//
//  InstantSendLockManager.swift
//
//  Created by Sun on 2019/5/28.
//

import Foundation

import BitcoinCore

class InstantSendLockManager: IInstantSendLockManager {
    // MARK: Properties

    private(set) var relayedLocks = [Data: ISLockMessage]()

    private let instantSendLockValidator: IInstantSendLockValidator

    // MARK: Lifecycle

    init(instantSendLockValidator: IInstantSendLockValidator) {
        self.instantSendLockValidator = instantSendLockValidator
    }

    // MARK: Functions

    func add(relayed: ISLockMessage) {
        relayedLocks[relayed.txHash] = relayed
    }

    func takeRelayedLock(for txHash: Data) -> ISLockMessage? {
        if let lock = relayedLocks[txHash] {
            relayedLocks[txHash] = nil
            return lock
        }
        return nil
    }

    func validate(isLock: ISLockMessage) throws {
        try instantSendLockValidator.validate(isLock: isLock)
    }
}
