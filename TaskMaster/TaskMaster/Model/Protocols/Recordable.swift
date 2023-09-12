//
//  Recordable.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit

protocol Recordable {
    init?(record: CKRecord)
    var id: String { get set }
    var record: CKRecord? {get set}
}

extension Recordable {
    func toRecord() -> CKRecord {
        let mirror = Mirror(reflecting: self)
        let record = CKRecord(recordType: String(describing: Self.self))
        
        for child in mirror.children {
            if let label = child.label {
                if ((child.value as? CKRecord?) != nil) {
                    continue
                }
                //Converte a imagem para o tipo CKAsset
                if let imageData = child.value as? Data {
                    guard let ckAsset = imageData.toCKAsset() else {
                        continue
                    }
                    
                    record[label] = ckAsset
                    
                } else {
                    guard let childValue = child.value as? CKRecordValue else {
                        continue
                    }
                    record[label] = childValue
                }
            }
        }
        return record
    }
    
    var description: String {
        let mirror = Mirror(reflecting: self)
        var string: [String] = ["\(String(describing: Self.self))->"]
        
        for child in mirror.children {
            if let label = child.label {
                if let value = child.value as? CKRecord {
                    string.append("\(label): \(value.recordID.recordName)")
                }
                if let imageData = child.value as? Data {
                    string.append("\(label): \(imageData.count/(1024*1024))MB")

                } else {
                    guard let childValue = child.value as? CKRecordValue else {
                        continue
                    }
                    string.append("\(label): \(childValue)")
                }
            }
        }
        
        return string.joined(separator: "|")
    }
    
}
