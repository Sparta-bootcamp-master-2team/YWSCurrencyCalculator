//
//  FavoriteCurrency.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/22/25.
//

import Foundation
import CoreData

@objc(FavoriteCurrency)
public class FavoriteCurrency: NSManagedObject {
    @NSManaged public var code: String
}

extension FavoriteCurrency {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCurrency> {
        return NSFetchRequest<FavoriteCurrency>(entityName: "FavoriteCurrency")
    }
}
