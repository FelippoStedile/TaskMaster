//
//  Data+Extension.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit

extension Data {
    func toCKAsset() -> CKAsset? {
        
        guard let url = saveImageToTemporaryFile() else {
            print("Error on \(#function)")
            return nil
        }
        
        return CKAsset(fileURL: url)
    }
    
    func saveImageToTemporaryFile() -> URL? {
        let temporaryDirectory = NSTemporaryDirectory()
        let fileName = ProcessInfo.processInfo.globallyUniqueString + ".jpg"
        let fileURL = URL(fileURLWithPath: temporaryDirectory).appendingPathComponent(fileName)
        
        do {
            try self.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image to temporary file: \(error)")
            return nil
        }
    }
}

