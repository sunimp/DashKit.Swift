//
//  MasternodeSortedList.swift
//
//  Created by Sun on 2019/3/26.
//

import Foundation

class MasternodeSortedList: IMasternodeSortedList {
    // MARK: Properties

    private var masternodeSet = Set<Masternode>()

    // MARK: Computed Properties

    var masternodes: [Masternode] { masternodeSet.sorted()
    }

    // MARK: Functions

    func add(masternodes: [Masternode]) {
        masternodeSet = Set(masternodes).union(masternodeSet)
    }

    func remove(masternodes: [Masternode]) {
        masternodeSet.subtract(Set(masternodes))
    }

    func remove(by proRegTxHashes: [Data]) {
        for hash in proRegTxHashes {
            if let index = masternodeSet.firstIndex(where: { $0.proRegTxHash == hash }) {
                masternodeSet.remove(at: index)
            }
        }
    }

    func removeAll() {
        masternodeSet.removeAll()
    }
}
