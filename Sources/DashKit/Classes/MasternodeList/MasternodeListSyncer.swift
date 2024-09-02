//
//  MasternodeListSyncer.swift
//
//  Created by Sun on 2019/3/18.
//

import Combine
import Foundation

import BitcoinCore

// MARK: - MasternodeListSyncer

class MasternodeListSyncer: IMasternodeListSyncer {
    // MARK: Properties

    private var cancellables = Set<AnyCancellable>()
    private weak var bitcoinCore: BitcoinCore?
    private let initialBlockDownload: IInitialDownload
    private let peerTaskFactory: IPeerTaskFactory
    private let masternodeListManager: IMasternodeListManager

    private var workingPeer: IPeer? = nil
    private let queue: DispatchQueue

    // MARK: Lifecycle

    init(
        bitcoinCore: BitcoinCore,
        initialBlockDownload: IInitialDownload,
        peerTaskFactory: IPeerTaskFactory,
        masternodeListManager: IMasternodeListManager,
        queue: DispatchQueue = DispatchQueue(label: "com.sunimp.dash-kit.masternode-list-syncer", qos: .background)
    ) {
        self.bitcoinCore = bitcoinCore
        self.initialBlockDownload = initialBlockDownload
        self.peerTaskFactory = peerTaskFactory
        self.masternodeListManager = masternodeListManager
        self.queue = queue
    }

    // MARK: Functions

    func subscribeTo(publisher: AnyPublisher<PeerGroupEvent, Never>) {
        publisher
            .sink { [weak self] event in
                switch event {
                case let .onPeerDisconnect(peer, error): self?.onPeerDisconnect(peer: peer, error: error)
                default: ()
                }
            }
            .store(in: &cancellables)
    }

    func subscribeTo(publisher: AnyPublisher<InitialDownloadEvent, Never>) {
        publisher
            .sink { [weak self] event in
                switch event {
                case let .onPeerSynced(peer): self?.onPeerSynced(peer: peer)
                default: ()
                }
            }
            .store(in: &cancellables)
    }

    private func assignNextSyncPeer() {
        queue.async {
            guard
                self.workingPeer == nil,
                let lastBlockInfo = self.bitcoinCore?.lastBlockInfo,
                let syncedPeer = self.initialBlockDownload.syncedPeers.first,
                let blockHash = lastBlockInfo.headerHash.reversedData
            else {
                return
            }

            let baseBlockHash = self.masternodeListManager.baseBlockHash

            if blockHash != baseBlockHash {
                let task = self.peerTaskFactory.createRequestMasternodeListDiffTask(
                    baseBlockHash: baseBlockHash,
                    blockHash: blockHash
                )
                syncedPeer.add(task: task)

                self.workingPeer = syncedPeer
            }
        }
    }
}

extension MasternodeListSyncer {
    private func onPeerSynced(peer _: IPeer) {
        assignNextSyncPeer()
    }
}

extension MasternodeListSyncer {
    private func onPeerDisconnect(peer: IPeer, error _: Error?) {
        if peer.equalTo(workingPeer) {
            workingPeer = nil

            assignNextSyncPeer()
        }
    }
}

// MARK: IPeerTaskHandler

extension MasternodeListSyncer: IPeerTaskHandler {
    func handleCompletedTask(peer: IPeer, task: PeerTask) -> Bool {
        switch task {
        case let listDiffTask as RequestMasternodeListDiffTask:
            if let message = listDiffTask.masternodeListDiffMessage {
                do {
                    try masternodeListManager.updateList(masternodeListDiffMessage: message)
                    workingPeer = nil
                } catch {
                    peer.disconnect(error: error)
                }
            }
            return true

        default: return false
        }
    }
}
