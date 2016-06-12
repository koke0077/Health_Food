//
//  TrainerViewController.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 4. 29..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit
import HealthKit

class TrainerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var height: HKQuantitySample?
    var arr = NSMutableArray()
    var startDate = NSDate()
    let endDate = NSDate()
    let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
    let healthAuth = HealthAuth2()
    let cal_data = School_Data_Manager()
    
    var my_Calory:Double = 0.0
    var caloryByMile:Double = 0.0
    var my_basicCalory:Double = 0.0
    var my_distance:Double = 0.0
    var my_steps:Double = 0.0
    var my_wasteCalory:Double = 0
    var my_height_str = String()
    var my_weight_str = String()
    var height_int:Double = 0.0
    var weight_int:Double = 0.0
    var todayCalory:Double = 0.0
    var today = String()
    var is_ok = 0
    
    var reFresh = UIRefreshControl()
    
    @IBOutlet weak var trainerTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainerTableView.delegate = self
        trainerTableView.dataSource = self
        
        reFresh.addTarget(self, action:#selector(TrainerViewController.pull_refresh), forControlEvents: UIControlEvents.ValueChanged)
        
        self.trainerTableView.addSubview(reFresh)
    }
    
    func pull_refresh() {
        self.trainerTableView.reloadData()
        print("RELOADING")
        reFresh.endRefreshing()
        
    }
    
    func formatADate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let d = NSDate()
        let s = dateFormatter.stringFromDate(d)
        return s
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        today = self.formatADate()
        
        is_ok = Int(cal_data.exist_Day(today))
        
        if(is_ok == 1){
            let arr = cal_data.loadData()
            
            var str_1 = arr.last?.objectForKey("breakfast") as! String
            var str_2 = arr.last?.objectForKey("lunch") as! String
            var str_3 = arr.last?.objectForKey("dinner") as! String
            
            var num1:Double?
            var num2:Double?
            var num3:Double?
            
            str_1 = str_1.stringByReplacingOccurrencesOfString(" Kcal", withString: "")
            str_2 = str_2.stringByReplacingOccurrencesOfString(" Kcal", withString: "")
            str_3 = str_3.stringByReplacingOccurrencesOfString(" Kcal", withString: "")
            
            if(Double(str_1) == nil){
                num1 = 0.0
            }else{
                num1 = Double(str_1)
            }
            if(Double(str_2) == nil){
                num2 = 0.0
            }else{
                num2 = Double(str_2)
            }
            if(Double(str_3) == nil){
                num3 = 0.0
            }else{
                num3 = Double(str_3)
            }
            
//            todayCalory = Double(str_1)! + Double(str_2)! + Double(str_3)!
            todayCalory = num1! + num2! + num3!
            
            self.recentSteps2 { (cnt, error) in
                if(error != nil){
                    
                }else{
                    //                print(cnt)
                    self.my_distance = ((self.height_int - 100) * cnt)/100
                    
                    //                self.my_wasteCalory = self.my_distance * self.caloryByMile * 0.00006213
                    self.my_wasteCalory = cnt/30
                }
            }
            
            
            //        self.recentSteps3 { (distance, error) in
            //            if(error != nil){
            //
            //            }else{
            //                print(distance)
            //
            //            }
            //        }
            
            let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            if(delegate.height_str != ""){
                my_height_str = delegate.height_str
                my_height_str = my_height_str.stringByReplacingOccurrencesOfString("cm", withString: "")
                my_weight_str = delegate.weight_str
                my_weight_str = my_weight_str.stringByReplacingOccurrencesOfString("kg", withString: "")
                
                height_int = Double(my_height_str)!
                weight_int = Double(my_weight_str)!
                let age_point = Double(delegate.my_age) * 6.8
                // 기초대사량(BMR) = 66+(13.8*몸무게(kg))+(5*키(cm))-(6.8*나이)
                my_basicCalory = 66.0 + (weight_int * 13.8) + (5 * height_int) - age_point
                
                self.caloryByMile = 3.7103 + 0.2678*weight_int + (0.0359*weight_int*60*0.00006213)*2*weight_int
            }
            
            
            
            self.trainerTableView.reloadData()
        }
        
        
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if(section == 0 ){
//            return "운동처방전"
//        }else if(section == 1){
//            return "일일 운동 관리"
//        }else{
//            return "관리 통계"
//        }
//    }
   /*
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let lbl_A = UILabel() as UILabel
        lbl_A.frame = CGRectMake(30, -10, tableView.frame.size.width, 45.0)
        lbl_A.tag = section
        
        switch section {
        case 0:
            //            btnA.backgroundColor = UIColor.purpleColor()
            //            btnA.titleLabel?.text = "첫 번째 섹션"
            lbl_A.textColor = UIColor.darkGrayColor()
            lbl_A.font = UIFont.boldSystemFontOfSize(18)
            lbl_A.text = "운동 처방전"
            
        case 1:
            //            btnA.backgroundColor = UIColor.greenColor()
            //            btnA.titleLabel?.text = "두 번째 섹션"
            lbl_A.textColor = UIColor.darkGrayColor()
            lbl_A.font = UIFont.boldSystemFontOfSize(18)
            lbl_A.text = "일일 운동 관리"
        case 2:
            //            btnA.backgroundColor = UIColor.blueColor()
            //            btnA.titleLabel?.text = "세 번째 섹션"
            lbl_A.textColor = UIColor.darkGrayColor()
            lbl_A.font = UIFont.boldSystemFontOfSize(18)
            lbl_A.text = "관리 통계"
        default: break
        }
        
        return lbl_A

    }
       
 */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 6
        }else if(section == 1){
            return 4
        }else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = UITableViewCell()
        var lbl_1 = UILabel()
        var lbl_2 = UILabel()
        
        if(indexPath.section == 0){
             cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath)
            lbl_1 = cell.viewWithTag(10) as! UILabel
            lbl_2 = cell.viewWithTag(20) as! UILabel
            
            if(indexPath.row == 0){
                lbl_1.text = "🚶🏻 30분 걷기"
                lbl_2.text = "80Kcal"
                
            }else if(indexPath.row == 1){
                lbl_1.text = "🏃🏻 30분 달리기"
                lbl_2.text = "150Kcal"
                
            }else if(indexPath.row == 2){
                lbl_1.text = "🚴🏼 30분 자전거 타기"
                lbl_2.text = "170Kcal"
                
            }else if(indexPath.row == 3){
                lbl_1.text = "⛰ 30분 등산하기"
                lbl_2.text = "180Kcal"
                
            }else if(indexPath.row == 4){
                lbl_1.text = "🏊🏼 30분 수영하기"
                lbl_2.text = "200Kcal"
                
            }else if(indexPath.row == 5){
                lbl_1.text = "🕴 30분 줄넘기"
                lbl_2.text = "220Kcal"
                
            }
            
            
        }else if(indexPath.section == 1){
            cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath)
            lbl_1 = cell.viewWithTag(10) as! UILabel
            lbl_2 = cell.viewWithTag(20) as! UILabel
            
            if(indexPath.row == 0){
                lbl_1.text = "오늘 섭취한 열량"
                lbl_2.text = String(format: "%0.2f Kcal", todayCalory)
            }else if(indexPath.row == 1){
                lbl_1.text = "나의 기초대사량"
                lbl_2.text = String(format: "%0.2f Kcal", my_basicCalory)
            }else if(indexPath.row == 2){
                lbl_1.text = "오늘 걸은 거리"
                lbl_2.text = String(format:"%0.2f Km",my_distance/1000)
            }else if(indexPath.row == 3){
                lbl_1.text = "현재까지 소비한 칼로리"
                lbl_2.text = String(format:"%0.2f Kcal",my_wasteCalory+my_basicCalory)
            }
            
        }else if(indexPath.section == 2){
            cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath)
            lbl_1 = cell.viewWithTag(10) as! UILabel
            lbl_2 = cell.viewWithTag(20) as! UILabel
            lbl_1.text = "오늘 남은 칼로리"
            if(todayCalory - (my_wasteCalory+my_basicCalory) < 0){
                lbl_2.text = "0 Kcal"
            }else{
                lbl_2.text = String(format: "%0.2f Kcal", todayCalory - (my_wasteCalory+my_basicCalory))
            }
            
            
            
            
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    func setHeight() {
        // Create the HKSample for Height.
        let heightSample = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
        
        // Call HealthKitManager's getSample() method to get the user's height.
        self.getHeight(heightSample!, completion: { (userHeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            
            
            var heightString = ""
            
            self.height = userHeight as? HKQuantitySample
            
            // The height is formatted to the user's locale.
            if let meters = self.height?.quantity.doubleValueForUnit(HKUnit.meterUnit()) {
                let formatHeight = NSLengthFormatter()
                formatHeight.forPersonHeightUse = true
                heightString = formatHeight.stringFromMeters(meters)
            }
            
            // Set the label to reflect the user's height.
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //                self.heightLabel.text = heightString
                print(heightString)
                self.my_height_str = heightString
            })
        })
        
        
    }
    */

    /*
     func recentSteps()
     {
     
     
     let dataString = "4-1-2015" as String
     let dateFormatter = NSDateFormatter()
     dateFormatter.dateFormat = "MM-dd-yyyy"
     dateFormatter.timeZone = NSTimeZone.localTimeZone()
     
     // convert string into date
     let dateValue = dateFormatter.dateFromString(dataString) as NSDate!
     
     startDate = dateValue
     
     let calendar = NSCalendar.currentCalendar()
     
     let twoDaysAgo = calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])
     
     //        let components = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
     //        components.day = 1
     //        let firstOfMonth = calendar.dateFromComponents(components)
     
     let predicate = HKQuery.predicateForSamplesWithStartDate(twoDaysAgo, endDate: endDate, options: HKQueryOptions.StrictStartDate)
     
     let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true, selector: #selector(NSString.localizedCompare(_:)))
     
     let sampleQuery = HKSampleQuery.init(sampleType: sampleType!,
     predicate: predicate,
     limit: HKObjectQueryNoLimit,
     sortDescriptors: [sortDescriptor],
     resultsHandler: { query, results, error in
     
     if error != nil{
     print(error)
     }
     for result in results as! [HKQuantitySample]!{
     print(result)
     
     self.arr.addObject(result)
     
     }
     })
     
     
     healthAuth.healthStore.executeQuery(sampleQuery)
     
     
     
     }
     
     */
    
    
    func recentSteps2(completion: (Double, NSError?) -> () )
    {
        
        
        let type = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount) // The type of data we are requesting
        
        
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let newDate = cal.startOfDayForDate(date)
        let predicate = HKQuery.predicateForSamplesWithStartDate(newDate, endDate: NSDate(), options: .None) // Our search predicate which will fetch all steps taken today
        
        // The actual HealthKit Query which will fetch all of the steps and add them up for us.
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
            var steps: Double = 0
            
            if results?.count > 0
            {
                for result in results as! [HKQuantitySample]
                {
                    steps += result.quantity.doubleValueForUnit(HKUnit.countUnit())
                }
            }
            
            completion(steps, error)
        }
        
        healthAuth.healthStore.executeQuery(query)
    }
    
    
    func getHeight(sampleType: HKSampleType , completion: ((HKSample!, NSError!) -> Void)!) {
        
        // Predicate for the height query
        let distantPastHeight = NSDate.distantPast() as NSDate
        let currentDate = NSDate()
        let lastHeightPredicate = HKQuery.predicateForSamplesWithStartDate(distantPastHeight, endDate: currentDate, options: .None)
        
        // Get the single most recent height
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        // Query HealthKit for the last Height entry.
        let heightQuery = HKSampleQuery(sampleType: sampleType, predicate: lastHeightPredicate, limit: 1, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
            
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            
            // Set the first HKQuantitySample in results as the most recent height.
            let lastHeight = results!.first
            
            if completion != nil {
                completion(lastHeight, nil)
                
                 self.trainerTableView.reloadData()
            }
        }
        
        // Time to execute the query.
        healthAuth.healthStore.executeQuery(heightQuery)
    }
    
    
    /*
     __block double walkingAVG = 0.0f;
     
     HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
     
     // Create a predicate to set start/end date bounds of the query
     NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:[[NSDate date] dateByAddingTimeInterval:60*60*24*-2] endDate:[NSDate date] options:HKQueryOptionStrictStartDate];
     
     // Create a sort descriptor for sorting by start date
     NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
     
     
     HKSampleQuery * sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType
     predicate:predicate
     limit:HKObjectQueryNoLimit
     sortDescriptors:@[sortDescriptor]
     resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
     
     if(!error && results)
     {
     for(HKQuantitySample *samples in results)
     {
     walkingAVG += [[samples quantity] doubleValueForUnit:[HKUnit mileUnit]];
     }
     NSLog(@"Walking + Distance count::: %f km",walkingAVG);
     compblock(walkingAVG);
     
     }
     
     }];
     // Execute the query
     [self.healthStore executeQuery:sampleQuery];
     
     */
    
    func recentSteps3(completion: (Double, NSError?) -> () ){
        let type = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)
        
        let date = NSDate()
        
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let newDate = cal.startOfDayForDate(date)
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(newDate, endDate: NSDate(), options: HKQueryOptions.StrictStartDate)
        
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            
            var distance: Double = 0
            
            if results?.count > 0
            {
                for result in results as! [HKQuantitySample]
                {
                    distance += result.quantity.doubleValueForUnit(HKUnit.mileUnit())
                }
            }
            
            completion(distance, error)
            
             self.trainerTableView.reloadData()
        }
        
        healthAuth.healthStore.executeQuery(query)
    }
    
    /*
     func saveDistance(distanceRecorded: Double, date: NSDate ) {
     
     // Set the quantity type to the running/walking distance.
     let distanceType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)
     
     // Set the unit of measurement to miles.
     let distanceQuantity = HKQuantity(unit: HKUnit.mileUnit(), doubleValue: distanceRecorded)
     
     // Set the official Quantity Sample.
     let distance = HKQuantitySample(type: distanceType!, quantity: distanceQuantity, startDate: date, endDate: date)
     
     // Save the distance quantity sample to the HealthKit Store.
     healthKitStore.saveObject(distance, withCompletion: { (success, error) -> Void in
     if( error != nil ) {
     print(error)
     } else {
     print("The distance has been recorded! Better go check!")
     }
     })
     }
     */
    
    
    
    func dataTypesToWrite() -> NSSet {
        let runningType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)
        
        return NSSet(object: runningType!)
    }
    
    
    func distanceSampleWithDistance(distance: Double) -> HKQuantitySample {
        let quantityType: HKQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!
        let distanceUnit: HKUnit = HKUnit(fromLengthFormatterUnit: .Meter)
        let quantity: HKQuantity = HKQuantity(unit: distanceUnit, doubleValue: distance)
        return HKQuantitySample(type: quantityType, quantity: quantity, startDate: NSDate(), endDate: NSDate())
    }
    
    
    /*
     func saveDistanceValueToHealthKit(distance: Double, withCompletion completion: ((Bool, NSError!) -> Void)!) {
     let distanceSample = distanceSampleWithDistance(distance)
     
     healthStore.saveObject(distanceSample, withCompletion: { (success, error) -> Void in
     dispatch_async(dispatch_get_main_queue(), { () -> Void in
     if error == nil
     {
     // saved successfully
     completion(success, error)
     }
     else
     {
     println("Error occured while saving to Health Kit: \(error.localizedDescription)")
     completion(success, error)
     }
     })
     })
     }
     */
    
    
    func food() {
        guard let quantityType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else {
            fatalError("*** Unable to create a heart rate quantity type ***")
        }
        let calendar = NSCalendar.currentCalendar()
        let oneDaysAgo = calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])
        
        let bpm = HKUnit(fromString: "count/min")
        let quantity = HKQuantity(unit: bpm, doubleValue: 72.0)
        
        let quantitySample = HKQuantitySample(type: quantityType,
                                              quantity: quantity,
                                              startDate: oneDaysAgo!,
                                              endDate: endDate)
        
        print(quantitySample)
    }
    
    
    /* func getActiveCalories(startDate:NSDate, endDate:NSDate){
     let sampleType =      HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned)
     let hkUnit = HKUnit.kilocalorieUnit()
     
     getSumStatsFor(sampleType, hkUnit: hkUnit, startDate: startDate, endDate: endDate) { (hdObject, result) -> Void in
     hdObject.activeCalories = result
     }
     }
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
