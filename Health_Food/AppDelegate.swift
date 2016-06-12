//
//  AppDelegate.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 4. 29..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//


/*
 
 
 
 -(void)initDB{
 NSFileManager *fileManager = [NSFileManager defaultManager];
 NSString *dbPath = [self getDBPath];
 BOOL success = [fileManager fileExistsAtPath:dbPath];
 
 if(!success) {
 
 NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"school_data1.sqlite"];
 success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:nil];
 
 if (!success) NSLog(@"데이터베이스 파일 복사 실패.");
 }
 }
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var row_num: Int = 0
    
    var height_str: String = "0"
    var weight_str: String = "0"
    var my_age:Int = 0


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let db_class : School_Data_Manager = School_Data_Manager()
        
        db_class.initDB()
        
        let today = self.formatADate()
        
        let is_ok = Int(db_class.exist_Day(today))
        
        if(is_ok == 0){
            
            db_class.addDataWithday(today, breakfast: "0Kcal", lunch: "0Kcal", dinner: "0Kcal", distance: "1000", breakfase_Food: "", lunch_Food: "", dinner_Food: "")
        }
        

        return true
    }
    
    func formatADate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let d = NSDate()
        let s = dateFormatter.stringFromDate(d)
        return s
    }
    
    /*
     - (NSString *)getDBPath {
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
     NSString *documentsDir = [paths objectAtIndex:0];
     return [documentsDir stringByAppendingPathComponent:@"school_data1.sqlite"]; 
       
     
                 
     
     
     }
 */
    /*
     let filemanager = NSFileManager.defaultManager()
     
     let documentsPath : AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
     let destinationPath:NSString = documentsPath.stringByAppendingString("/items.db")
     
     if(!filemanager.fileExistsAtPath(destinationPath) ){
     
     let fileForCopy = NSBundle.mainBundle().pathForResource("items",ofType:"db")
     filemanager.copyItemAtPath(fileForCopy,toPath:destinationPath, error: nil)
     
     return destinationPath
     }
     else{
     return destinationPath
     }}
 */
    
    func getDBPath() -> String {
        let paths : AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        return paths as! String
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

