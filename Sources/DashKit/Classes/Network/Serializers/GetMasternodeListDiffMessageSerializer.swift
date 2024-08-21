//
//  GetMasternodeListDiffMessageSerializer.swift
//  DashKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BitcoinCore

class GetMasternodeListDiffMessageSerializer: IMessageSerializer {
    var id: String { "getmnlistd" }

    func serialize(message: IMessage) -> Data? {
        guard let message = message as? GetMasternodeListDiffMessage else {
            return nil
        }

        return message.baseBlockHash + message.blockHash
    }
}
