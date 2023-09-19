//
//  ServiceProviders.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import Foundation

import CloudKit

protocol UserProviderProtocol {
    var currentUserID: String { get }
    var isSignedInToiCloud: Bool { get }
    func fetchCurrentUser<T: Recordable>(type: T.Type, userID: String ,completion: @escaping (Result<T, Error>) -> Void)
    func createUser<T: Recordable>(user: T) async throws
    func getUserRecordId() async throws -> String 
}


protocol DataFetcherProtocol {
    func fetchData<T: Recordable>(query: CKQuery, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    // Outros métodos de busca de dados podem ser adicionados aqui
}


protocol DataManipulatorProtocol {
    func delete(data: Recordable) async throws
    func update(data: Recordable) async throws
    func saveData<T: Recordable>(data: T) async throws -> CKRecord
}

typealias RemoteServiceProvider = UserProviderProtocol & DataFetcherProtocol & DataManipulatorProtocol


