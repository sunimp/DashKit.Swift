//
//  InstantTransactionState.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

class InstantTransactionState: IInstantTransactionState {
    var instantTransactionHashes = [Data]()

    func append(_ hash: Data) {
        instantTransactionHashes.append(hash)
    }
}
