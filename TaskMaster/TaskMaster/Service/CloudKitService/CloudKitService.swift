//
//  CloudKitService.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit
import SwiftUI

final class CloudKitService: RemoteServiceProvider {

    static let shared: CloudKitService = CloudKitService()
    private let container = CKContainer.default()
    let semaphore = DispatchSemaphore(value: 0)
    @AppStorage("currentUserID") var currentUserID: String = ""
    var isSignedInToiCloud: Bool = false
    
    private init(){
        getiCloudStatus()
        getUserRecordId()
    }
}

extension CloudKitService {
    
    func getUserRecordId() async throws -> String  {
        try await withCheckedThrowingContinuation { continuation in
            self.container.fetchUserRecordID(completionHandler: { (recordId, error) in
                if let name = recordId?.recordName {
                    self.currentUserID = name
                    continuation.resume(returning: name)
                }
                else if let error = error {
                    continuation.resume(throwing: error)
                }
            })
       }
    }
    
    private func getUserRecordId() {
        

        
        DispatchQueue.main.async  {
            self.container.fetchUserRecordID(completionHandler: { (recordId, error) in
                if let name = recordId?.recordName {
                    self.currentUserID = name
                }
                else if let error = error {
                    self.currentUserID = "-1"
                    print(error.localizedDescription)
                }
                self.semaphore.signal()
            })
        }
    }
    
    func getUserRecordId(completion: @escaping ((Result<String, Error>) -> Void)) {
        self.container.fetchUserRecordID(completionHandler: { (recordId, error) in
            if let name = recordId?.recordName {
                self.currentUserID = name
                completion(.success(name))
            }
            else if let error = error {
                completion(.failure(error))
            }
        })
    }
}

extension CloudKitService {
    
    // Busca dado passando a CKQuery e o tipo do record
    func fetchData<T: Recordable>(query: CKQuery, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        container.publicCloudDatabase.fetch(withQuery: query) { result in
            switch result {
                
            case .success((let matchResults, _)):
                do {
                    if let record = try matchResults.first?.1.get() { //matchFirst é nil
                        if let data = T(record: record) {
                            completion(.success(data))
                        }
                    } else {
                        print("ta dando ruim aqui ")
                        completion(.failure(NSError(domain: "Não encotrou usuário", code: 0)))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Busca dado passando o NSPredicate e o tipo do record
    func fetchData<T: Recordable>(predicate: NSPredicate, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let query: CKQuery = CKQuery(recordType: String(describing: T.self), predicate: predicate)
        self.fetchData(query: query, type: T.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Busca dado passando a query e os campos que se deseja buscar
    func fetchManyData<T: Recordable>(query: CKQuery, desiredKeys: [CKRecord.FieldKey]? = nil, type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        var dataResult: [T] = []
        
        container.publicCloudDatabase.fetch(withQuery: query, desiredKeys: desiredKeys) { result in
            switch result {
            case .success((let matchResults, _)):
                for matchResultsRecord in matchResults {
                    do {
                        let record = try matchResultsRecord.1.get()
                        if let data = T(record: record) {
                            dataResult.append(data)
                        } else {
                            continue
                        }
                    } catch {
                        print("Error on get matchResultsRecord: \(error.localizedDescription)")
                        continue
                    }
                }
                completion(.success(dataResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Busca todos os dados que tem o tipo de record passado como parametro
    func fetchAllData<T: Recordable>(type: T.Type, desiredKeys: [String]? = nil, completion: @escaping (Result<[T], Error>)-> Void) {
        
        let query =  NSPredicate(value: true)
        
        self.fetchFilteredData(predicate: query, desiredKeys: desiredKeys, type: T.self) { result in
            switch result {
            case .success(let allData):
                completion(.success(allData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Busca os dados passando um filtro
    func fetchFilteredData<T: Recordable>(predicate: NSPredicate,desiredKeys: [String]? = nil, type: T.Type ,completion: @escaping (Result<[T], Error>) -> Void) {
        let query = CKQuery(recordType: String(describing: T.self), predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.desiredKeys = desiredKeys
        let desiredKeys = queryOperation.desiredKeys
        
        self.fetchManyData(query: query, desiredKeys: desiredKeys, type: T.self) { result in
            switch result {
            case .success(let filteredData):
                completion(.success(filteredData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Busca dado passando o id e o tipo do record
    func fetchData<T: Recordable>(id: String,type: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        let query: CKQuery = CKQuery(recordType: String(describing: T.self), predicate: predicate)
        
        self.fetchData(query: query, type: T.self) { result in
            switch result  {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchData<T: Recordable>(recordID: CKRecord.ID,type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        container.publicCloudDatabase.fetch(withRecordID: recordID) { recordResult, error  in
            if let error = error {
                completion(.failure(error))
            }
            if let record = recordResult, let data = T(record: record) {
                completion(.success(data))
            }
        }
    }
    
    func fetchData<T: Recordable>(recordName: String,type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let recordID: CKRecord.ID = CKRecord.ID(recordName: recordName)
        
        self.fetchData(recordID: recordID, type: T.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension CloudKitService {
    
    /// Used for validating the users iCloudStatus. It automaticcaly updates the value of "connectedToiCloud".
    private func getiCloudStatus()  {
        Task(priority: .high) {
            do {
                let cloudKitAccountStatus = try await  container.accountStatus()
                
                switch cloudKitAccountStatus {
                case .couldNotDetermine:
                    print("CloudKit Log: \(#function): \(CloudKitError.NotDeterminedAccount)")
                    throw CloudKitError.NotDeterminedAccount
                case .available:
                    print("CloudKit Log: \(#function): User is Loggin")
                    isSignedInToiCloud = true
                case .restricted:
                    print("CloudKit Log: \(#function): \(CloudKitError.RestrictedAccount)")
                    throw CloudKitError.RestrictedAccount
                case .noAccount:
                    print("CloudKit Log: \(#function): \(CloudKitError.NotFoundAccount)")
                    throw CloudKitError.NotFoundAccount
                case .temporarilyUnavailable:
                    print("CloudKit Log: \(#function): \(CloudKitError.TemporarilyUnavailableAccount)")
                    throw CloudKitError.TemporarilyUnavailableAccount
                @unknown default:
                    print("CloudKit Log: \(#function): \(CloudKitError.UnknownAccount)")
                    throw CloudKitError.UnknownAccount
                }
            } catch {
                isSignedInToiCloud = false
            }
        }
    }
}

extension CloudKitService {
    // Busca os dados do usuário corrente
    func fetchCurrentUser<T: Recordable>(type: T.Type, userID: String ,completion: @escaping (Result<T, Error>) -> Void) {
        
        let predicate = NSPredicate(format: "id == %@", userID)
        print("CurrentUserID")
        
        fetchData(predicate: predicate, type: T.self) { result in
            switch result {
            case .success(let userData):
                completion(.success(userData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createUser<T>(user: T) async throws where T : Recordable {
        try await saveData(data: user)
    }
}

extension CloudKitService {
    private func delete(data: CKRecord) async throws {
         let recordID = data.recordID
         try await container.publicCloudDatabase.deleteRecord(withID: recordID)
     }
    
    private func saveData<T: CKRecord>(data: T)  async throws {
        try await container.publicCloudDatabase.save(data)
    }
    
    func saveData<T: Recordable>(data: T) async throws -> CKRecord {
        let record = data.toRecord()
        do {
            let a = try await container.publicCloudDatabase.save(record)
            return a
        } catch {
            print("JORGE ", error.localizedDescription)
            throw error
        }
    }
    
    func saveData<T: Recordable>(data: T, completionHandler: @escaping ((Result<CKRecord, Error>) -> ())) {
        
        let record = data.toRecord()
        
        container.publicCloudDatabase.save(record) { record, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let record = record else {
                let error = NSError(domain: "error on get record", code: 0)
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(record))
        }
    }
    
    
    func update(data: Recordable) async throws {
            guard let record = data.record else {
               let error = NSError(domain: "record não encotrado", code: 0)
                throw error
            }
            
            record.setValues(data: data)
            try await saveData(data: record)
    }
    
    func delete(data: Recordable) async throws {
        guard let record = data.record else {
            print("Error on delete data, invalid Record")
            return
        }
        
        try await delete(data: record)
    }
}

