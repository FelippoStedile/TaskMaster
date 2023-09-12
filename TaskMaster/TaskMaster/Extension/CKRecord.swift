//
//  CKRecord.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit

extension CKRecord {
    func setValues(data: Recordable) {
        let mirror = Mirror(reflecting: data)
        
        for child in mirror.children {
            if let label = child.label {
                switch child.value.self {
                case is CKRecord:
                    continue
                case is Data:
                    if let imageData = child.value  as? Data {
                        guard let ckAsset: CKAsset = imageData.toCKAsset() else {
                            continue
                        }
                        self[label] = ckAsset
                    }
                    
                case is CKRecordValue:
                    guard let childValue = child.value as? CKRecordValue else {
                        continue
                    }
                    self[label] = childValue
                default:
                    print("InvalidValue type for  \(label) : value: \(child.value )")
                    continue
                }
            }
        }
    }
}
