//
//  SceneDelegate.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/15/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        // 항상 root는 리스트
        let rootVC = ExchangeRateViewController()
        let navController = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()

        // 복원된 상태에 따라 Calculator를 push
        DispatchQueue.main.async {
            if let state = CoreDataManager.shared.getAppState(),
               state.screen == "calculator",
               let code = state.code,
               let rate = CoreDataManager.shared.getCachedRate(for: code) {
                let calculatorVC = CalculatorViewController(currencyCode: code, rate: rate)
                navController.pushViewController(calculatorVC, animated: false)
            }
        }
    }




    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 현재 화면이 CalculatorViewController라면 상태 저장
        if let nav = window?.rootViewController as? UINavigationController,
           let calculator = nav.topViewController as? CalculatorViewController {
            CoreDataManager.shared.saveAppState(screen: "calculator", code: calculator.currencyCode)
            print("[DEBUG] background 저장 - calculator")
        } else {
            CoreDataManager.shared.saveAppState(screen: "list", code: nil)
            print("[DEBUG] background 저장 - list")
        }
    }


}

