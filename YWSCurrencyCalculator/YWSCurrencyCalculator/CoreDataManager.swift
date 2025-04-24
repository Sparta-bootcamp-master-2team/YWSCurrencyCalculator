//
//  CoreDataManager.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/22/25.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "CachedRateModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data 로딩 실패: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext { container.viewContext }
    
    func saveFavorite(code: String) {
        let favorite = CachedRate(context: context)
        favorite.code = code
        try? context.save()
    }
    
    func removeFavorite(code: String) {
        let request = CachedRate.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)
        if let result = try? context.fetch(request), let first = result.first {
            context.delete(first)
            try? context.save()
        }
    }
    
    func getAllFavorites() -> [String] {
        let request = CachedRate.fetchRequest()
        let result = try? context.fetch(request)
        return result?.compactMap { $0.code } ?? []
    }
    
    func isFavorite(code: String) -> Bool {
        let request = CachedRate.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)
        return (try? context.count(for: request)) ?? 0 > 0
    }
    
    func getCachedRate(for code: String) -> Double? {
        let request = CachedRate.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)
        return (try? context.fetch(request))?.first?.rate
    }

    func updateOrInsertRate(code: String, newRate: Double) {
        let request = CachedRate.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)

        if let result = try? context.fetch(request), let existing = result.first {
            existing.previousRate = NSNumber(value: existing.rate)
            existing.rate = newRate
        } else {
            print("[NO CHANGE] \(code): rate unchanged")
            let new = CachedRate(context: context)
            new.code = code
            new.rate = newRate
            new.previousRate = nil
        }

        try? context.save()
    }
    
    func getCachedRateObject(for code: String) -> CachedRate? {
        let request = CachedRate.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)
        return (try? context.fetch(request))?.first
    }
}
