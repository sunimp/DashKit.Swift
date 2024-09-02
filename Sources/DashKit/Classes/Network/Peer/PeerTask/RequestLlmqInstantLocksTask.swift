//
//  RequestLlmqInstantLocksTask.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BitcoinCore

class RequestLlmqInstantLocksTask: PeerTask {
    // MARK: Properties

    var hashes = [Data]()
    var llmqInstantLocks = [ISLockMessage]()

    // MARK: Lifecycle

    init(hashes: [Data], dateGenerator: @escaping () -> Date = Date.init) {
        self.hashes = hashes

        super.init(dateGenerator: dateGenerator)
    }

    // MARK: Overridden Functions

    override func start() {
        let items = hashes.map { hash in InventoryItem(type: DashInventoryType.msgIsLock.rawValue, hash: hash) }
        requester?.send(message: GetDataMessage(inventoryItems: items))

        super.start()
    }

    override func handle(message: IMessage) -> Bool {
        if let lockMessage = message as? ISLockMessage {
            return handleISLockRequest(isLock: lockMessage)
        }
        return false
    }

    // MARK: Functions

    private func handleISLockRequest(isLock: ISLockMessage) -> Bool {
        guard let index = hashes.firstIndex(of: isLock.hash) else {
            return false
        }

        hashes.remove(at: index)
        llmqInstantLocks.append(isLock)
        if hashes.isEmpty {
            delegate?.handle(completedTask: self)
        }

        return true
    }
}
