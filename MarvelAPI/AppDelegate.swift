//
//  AppDelegate.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let apiClient = MarvelAPIClient(publicKey: "650e801e1408159969078d2a1361c71c", privateKey: "20112b45612fd05f0d21d80d70bc8c971695c7f1")
        apiClient.request(CharactersAPIRequest(name: "Avengers")) { result in
            print("\nGetCharacters finished:")
            
            switch result {
            case .success(let dataContainer):
                for character in dataContainer.results {
                    print("  Character: \(character.name ?? "Unnamed character")")
                    print("  Thumbnail: \(character.thumbnail?.url.absoluteString ?? "None")")
                    guard
                        let urlString = character.thumbnail?.url.absoluteString,
                        let url = URL(string: urlString)
                        else { return }
                    
                    do {
                        let image = try UIImage(data: Data(contentsOf: url))
                        print("\(String(describing: image))")
                    } catch {
                        print(error)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
        apiClient.request(ComicsAPIRequest(titleStartsWith: "Uncanny")) { result in
            print("\nGetComics finished:")
            
            switch result {
            case .success(let dataContainer):
                for comic in dataContainer.results {
                    print("  Title: \(comic.title ?? "Unnamed comic")")
                    print("  Thumbnail: \(comic.thumbnail?.url.absoluteString ?? "None")")
                }
            case .failure(let error):
                print(error)
            }
        }
        
        apiClient.request(ComicAPIRequest(comicId: 61537)) { result in
            print("\nGetComic finished:")
            
            switch result {
            case .success(let dataContainer):
                let comic = dataContainer.results.first
                
                print("  Title: \(comic?.title ?? "Unnamed comic")")
                print("  Thumbnail: \(comic?.thumbnail?.url.absoluteString ?? "None")")
            case .failure(let error):
                print(error)
            }
        }
        
        apiClient.request(ComicAPIRequest(comicId: 61537)).observe(on: UIScheduler()).on(event: { event in
            print("Event: \(event)")
        }, failed: { error in
            print("Error: \(error)")
        }, completed: {
            print("Completed")
        }).start()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

