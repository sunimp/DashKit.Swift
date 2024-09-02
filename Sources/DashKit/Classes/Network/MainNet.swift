//
//  MainNet.swift
//
//  Created by Sun on 2019/3/6.
//

import Foundation

import BitcoinCore

public class MainNet: INetwork {
    // MARK: Properties

    public let protocolVersion: Int32 = 70228

    public let bundleName = "Dash"

    public let maxBlockSize: UInt32 = 2000000000
    public let pubKeyHash: UInt8 = 0x4C
    public let privateKey: UInt8 = 0x80
    public let scriptHash: UInt8 = 0x10
    public let bech32PrefixPattern = "bc"
    public let xPubKey: UInt32 = 0x0488B21E
    public let xPrivKey: UInt32 = 0x0488ADE4
    public let magic: UInt32 = 0xBF0C6BBD
    public let port = 9999
    public let coinType: UInt32 = 5
    public let sigHash: SigHashType = .bitcoinAll
    public var syncableFromApi = true
    public var blockchairChainID = "dash"

    public let dnsSeeds = [
        "dnsseed.dash.org",
        "x5.dnsseed.dashdot.io",
        "dnsseed.masternode.io",
    ]

    public let dustRelayTxFee = 3000 // https://github.com/dashpay/dash/blob/master/src/policy/policy.h#L38

    // MARK: Lifecycle

    public init() { }
}
