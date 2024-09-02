//
//  Protocols.swift
//
//  Created by Sun on 2019/3/18.
//

import Foundation

import BigInt
import BitcoinCore

// MARK: - IDashDifficultyEncoder

// BitcoinCore Compatibility

protocol IDashDifficultyEncoder {
    func decodeCompact(bits: Int) -> BigInt
    func encodeCompact(from bigInt: BigInt) -> Int
}

// MARK: - IDashHasher

protocol IDashHasher {
    func hash(data: Data) -> Data
}

// MARK: - IDashBlockValidatorHelper

protocol IDashBlockValidatorHelper {
    func previous(for block: Block, count: Int) -> Block?
}

// MARK: - IDashTransactionSizeCalculator

protocol IDashTransactionSizeCalculator {
    func transactionSize(previousOutputs: [Output], outputScriptTypes: [ScriptType], memo: String?) -> Int
    func outputSize(type: ScriptType) -> Int
    func inputSize(type: ScriptType) -> Int
    func toBytes(fee: Int) -> Int
}

// MARK: - IDashTransactionSyncer

protocol IDashTransactionSyncer {
    func handleRelayed(transactions: [FullTransaction])
}

// MARK: - IDashPeer

protocol IDashPeer: IPeer {
    var delegate: PeerDelegate? { get set }
    var localBestBlockHeight: Int32 { get set }
    var announcedLastBlockHeight: Int32 { get }
    var host: String { get }
    var logName: String { get }
    var ready: Bool { get }
    var connected: Bool { get }
    var synced: Bool { get set }
    var blockHashesSynced: Bool { get set }
    func connect()
    func disconnect(error: Error?)
    func add(task: PeerTask)
    func filterLoad(bloomFilter: BloomFilter)
    func sendMempoolMessage()
    func sendPing(nonce: UInt64)
    func equalTo(_ peer: IPeer?) -> Bool
}

// MARK: - DashKitDelegate

// ###############################

public protocol DashKitDelegate: AnyObject {
    func transactionsUpdated(inserted: [DashTransactionInfo], updated: [DashTransactionInfo])
    func transactionsDeleted(hashes: [String])
    func balanceUpdated(balance: BalanceInfo)
    func lastBlockInfoUpdated(lastBlockInfo: BlockInfo)
    func kitStateUpdated(state: BitcoinCore.KitState)
}

// MARK: - IPeerTaskFactory

protocol IPeerTaskFactory {
    func createRequestMasternodeListDiffTask(baseBlockHash: Data, blockHash: Data) -> PeerTask
}

// MARK: - IMasternodeListManager

protocol IMasternodeListManager {
    var baseBlockHash: Data { get }
    func updateList(masternodeListDiffMessage: MasternodeListDiffMessage) throws
}

// MARK: - IQuorumListManager

protocol IQuorumListManager {
    func updateList(masternodeListDiffMessage: MasternodeListDiffMessage) throws
    func quorum(for requestID: Data, type: QuorumType) throws -> Quorum
}

// MARK: - IMasternodeListSyncer

protocol IMasternodeListSyncer { }

// MARK: - IDashStorage

protocol IDashStorage {
    var masternodes: [Masternode] { get set }
    var quorums: [Quorum] { get set }
    var masternodeListState: MasternodeListState? { get set }

    func quorums(by type: QuorumType) -> [Quorum]
    func inputs(transactionHash: Data) -> [Input]

    func instantTransactionHashes() -> [Data]
    func add(instantTransactionHash: Data)

    func add(instantTransactionInput: InstantTransactionInput)
    func removeInstantTransactionInputs(for txHash: Data)
    func instantTransactionInputs(for txHash: Data) -> [InstantTransactionInput]
    func instantTransactionInput(for inputTxHash: Data) -> InstantTransactionInput?

    var lastBlock: Block? { get }
    func block(byHash: Data) -> Block?

    func unspentOutputs() -> [UnspentOutput]
    func outputsCount(transactionHash: Data) -> Int

    func transactionExists(byHash: Data) -> Bool
    func transactionFullInfo(byHash hash: Data) -> FullTransactionForInfo?
}

// MARK: - IInstantSendFactory

protocol IInstantSendFactory {
    func instantTransactionInput(txHash: Data, inputTxHash: Data, voteCount: Int, blockHeight: Int?)
        -> InstantTransactionInput
}

// MARK: - IMasternodeSortedList

protocol IMasternodeSortedList {
    var masternodes: [Masternode] { get }

    func add(masternodes: [Masternode])
    func removeAll()
    func remove(masternodes: [Masternode])
    func remove(by proRegTxHashes: [Data])
}

// MARK: - IQuorumSortedList

protocol IQuorumSortedList {
    var quorums: [Quorum] { get }

    func add(quorums: [Quorum])
    func removeAll()
    func remove(quorums: [Quorum])
    func remove(by pairs: [(type: UInt8, quorumHash: Data)])
}

// MARK: - IMasternodeListMerkleRootCalculator

protocol IMasternodeListMerkleRootCalculator {
    func calculateMerkleRoot(sortedMasternodes: [Masternode]) -> Data?
}

// MARK: - IQuorumListMerkleRootCalculator

protocol IQuorumListMerkleRootCalculator {
    func calculateMerkleRoot(sortedQuorums: [Quorum]) -> Data?
}

// MARK: - IMasternodeCbTxHasher

protocol IMasternodeCbTxHasher {
    func hash(coinbaseTransaction: CoinbaseTransaction) -> Data
}

// MARK: - IMasternodeSerializer

protocol IMasternodeSerializer {
    func serialize(masternode: Masternode) -> Data
}

// MARK: - ICoinbaseTransactionSerializer

protocol ICoinbaseTransactionSerializer {
    func serialize(coinbaseTransaction: CoinbaseTransaction) -> Data
}

// MARK: - IMerkleRootCreator

protocol IMerkleRootCreator {
    func create(hashes: [Data]) -> Data?
}

// MARK: - IInstantTransactionManager

protocol IInstantTransactionManager {
    func instantTransactionInputs(for txHash: Data, instantTransaction: FullTransaction?) -> [InstantTransactionInput]
    func updateInput(for inputTxHash: Data, transactionInputs: [InstantTransactionInput]) throws
    func isTransactionInstant(txHash: Data) -> Bool
    func isTransactionExists(txHash: Data) -> Bool
    func makeInstant(txHash: Data)
}

// MARK: - IInstantTransactionDelegate

public protocol IInstantTransactionDelegate: AnyObject {
    func onUpdateInstant(transactionHash: Data)
}

// MARK: - IInstantTransactionState

protocol IInstantTransactionState {
    var instantTransactionHashes: [Data] { get set }
    func append(_ hash: Data)
}

// MARK: - IMasternodeParser

protocol IMasternodeParser {
    func parse(byteStream: ByteStream) -> Masternode
}

// MARK: - IQuorumParser

protocol IQuorumParser {
    func parse(byteStream: ByteStream) -> Quorum
}

// MARK: - ITransactionLockVoteHandler

protocol ITransactionLockVoteHandler {
    func handle(transaction: FullTransaction)
    func handle(lockVote: TransactionLockVoteMessage)
}

// MARK: - IInstantSendLockHandler

protocol IInstantSendLockHandler {
    func handle(transactionHash: Data)
    func handle(isLock: ISLockMessage)
}

// MARK: - ITransactionLockVoteValidator

protocol ITransactionLockVoteValidator {
    func validate(lockVote: TransactionLockVoteMessage) throws
}

// MARK: - ITransactionLockVoteManager

protocol ITransactionLockVoteManager {
    var relayedLockVotes: Set<TransactionLockVoteMessage> { get }
    var checkedLockVotes: Set<TransactionLockVoteMessage> { get }
    func processed(lvHash: Data) -> Bool
    func add(relayed: TransactionLockVoteMessage)
    func add(checked: TransactionLockVoteMessage)

    func takeRelayedLockVotes(for txHash: Data) -> [TransactionLockVoteMessage]

    func validate(lockVote: TransactionLockVoteMessage) throws
}

// MARK: - IInstantSendLockValidator

protocol IInstantSendLockValidator {
    func validate(isLock: ISLockMessage) throws
}

// MARK: - IInstantSendLockManager

protocol IInstantSendLockManager {
    var relayedLocks: [Data: ISLockMessage] { get }
    func add(relayed: ISLockMessage)

    func takeRelayedLock(for txHash: Data) -> ISLockMessage?

    func validate(isLock: ISLockMessage) throws
}
