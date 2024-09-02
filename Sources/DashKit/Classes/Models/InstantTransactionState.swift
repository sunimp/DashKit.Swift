//
//  InstantTransactionState.swift
//
//  Created by Sun on 2019/5/3.
//

import Foundation

class InstantTransactionState: IInstantTransactionState {
    // MARK: Properties

    var instantTransactionHashes = [Data]()

    // MARK: Functions

    func append(_ hash: Data) {
        instantTransactionHashes.append(hash)
    }
}
