//
//  GetMasternodeListDiffMessageSerializer.swift
//
//  Created by Sun on 2019/3/19.
//

import Foundation

import BitcoinCore

class GetMasternodeListDiffMessageSerializer: IMessageSerializer {
    // MARK: Computed Properties

    var id: String { "getmnlistd" }

    // MARK: Functions

    func serialize(message: IMessage) -> Data? {
        guard let message = message as? GetMasternodeListDiffMessage else {
            return nil
        }

        return message.baseBlockHash + message.blockHash
    }
}
