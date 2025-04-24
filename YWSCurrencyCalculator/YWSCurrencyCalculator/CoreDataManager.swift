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
        if let rate = getCachedRateObject(for: code) {
            rate.isFavorite = true
        } else {
            let new = CachedRate(context: context)
            new.code = code
            new.isFavorite = true
        }
        try? context.save()
    }

    func removeFavorite(code: String) {
        if let rate = getCachedRateObject(for: code) {
            rate.isFavorite = false
            try? context.save()
        }
    }

    func isFavorite(code: String) -> Bool {
        return getCachedRateObject(for: code)?.isFavorite ?? false
    }

    func getAllFavorites() -> [String] {
        let request = CachedRate.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        let result = try? context.fetch(request)
        return result?.compactMap { $0.code } ?? []
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
    
    // 저장
    func saveAppState(screen: String, code: String?) {
        // 항상 하나만 유지되도록 삭제 후 삽입 방식
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppState")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        _ = try? context.execute(deleteRequest)

        let state = AppState(context: context)
        state.lastScreen = screen
        state.lastCurrencyCode = code
        try? context.save()
    }

    // 조회
    func getAppState() -> (screen: String, code: String?)? {
        let request: NSFetchRequest<AppState> = AppState.fetchRequest()
        guard let result = try? context.fetch(request),
              let state = result.first,
              let screen = state.lastScreen else {
            return nil
        }
        return (screen: screen, code: state.lastCurrencyCode)
    }


}
