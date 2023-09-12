//
//  CloudKitError.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import Foundation

enum CloudKitError: LocalizedError {
    case NotFoundAccount
    case NotDeterminedAccount
    case RestrictedAccount
    case UnknownAccount
    case TemporarilyUnavailableAccount
}
