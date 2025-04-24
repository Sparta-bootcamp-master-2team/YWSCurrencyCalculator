//
//  FavoriteCurrency.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/22/25.
//

import Foundation
import CoreData

@objc(CachedRate)
public class CachedRate: NSManagedObject {
    @NSManaged public var code: String
    @NSManaged public var rate: Double
    @NSManaged public var previousRate: NSNumber?
    @NSManaged public var isFavorite: Bool
}

extension CachedRate {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedRate> {
        return NSFetchRequest<CachedRate>(entityName: "CachedRate")
    }
}
