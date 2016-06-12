//
//  BecomeViewController.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 4. 29..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit
import HealthKit


class BecomeViewController: UIViewController,  UIScrollViewDelegate {

    let biosex = HKBiologicalSexObject().biologicalSex
    
    let healthKitStore = HealthAuth2()
    
    let img_view = UIImageView()
    let img_view_2 = UIImageView()
    let scroll_V = UIScrollView()
    let page = UIPageControl()
    
    var height, weight: HKQuantitySample?
    var page_num:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scroll_V.delegate = self
        
        scroll_V.frame = CGRectMake(0, 70, self.view.frame.size.width*2,
                                    self.view.frame.size.height - 100)
        scroll_V.contentSize = CGSize(width: self.view.frame.width*3,
                                      height: self.view.frame.size.height-100)
        scroll_V.backgroundColor = UIColor.whiteColor()
        scroll_V.pagingEnabled = true
        
        img_view.frame = CGRectMake(10, 0, scroll_V.frame.size.width/2-20,
                                    self.scroll_V.frame.size.height-20)
        img_view.image = UIImage(named: "앱지도.png")
        img_view.contentMode = UIViewContentMode.ScaleAspectFit
        scroll_V.addSubview(img_view)
        
        img_view_2.frame = CGRectMake(30+img_view.frame.size.width, 0,
                                      scroll_V.frame.size.width/2-20, self.scroll_V.frame.size.height-20)
        img_view_2.image = UIImage(named: "앱매뉴얼.png")
        img_view_2.contentMode = UIViewContentMode.ScaleAspectFit
        scroll_V.addSubview(img_view_2)
        
        self.view.addSubview(scroll_V)
        
//        print(scroll_V.frame.size.width, scroll_V.frame.size.height)

        page.frame = CGRectMake(self.view.frame.size.width/2-30, 115, 60, 37)
        page.pageIndicatorTintColor = UIColor.grayColor()
        page.currentPageIndicatorTintColor = UIColor.orangeColor()
        page.numberOfPages = 2
        page.currentPage = 0
        self.view.addSubview(page)
        
        switch biosex {
        case .NotSet:
            print("성별을 모릅니다.")
        case .Female:
            print("여성입니다.")
        case .Male:
            print("남성입니다.")
        default: break
            
        }
        
        self.setHeight()
        self.setWeight()
        self.readAge()
        
//        self.saveBMISample(39.1, date: NSDate())
        
        
    }
    
    func setHeight() {
        // Create the HKSample for Height.
        let heightSample = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
        
        // Call HealthKitManager's getSample() method to get the user's height.
        self.getDataFromHealthKit(heightSample!, completion: { (userHeight, error) -> Void in
            
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
                
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.height_str = heightString
                
            })
        })
        
        
    }
    
    func setWeight() {
        // Create the HKSample for Height.
        let weightSample = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        // Call HealthKitManager's getSample() method to get the user's height.
        self.getDataFromHealthKit(weightSample!, completion: { (userWeight, error) -> Void in
            
            if( error != nil ) {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            
            
            var weightString = ""
            
            self.weight = userWeight as? HKQuantitySample
            
            // The height is formatted to the user's locale.
            if let kilogram = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo)) {
                let formatWeight = NSMassFormatter()
                formatWeight.forPersonMassUse = true
                weightString = formatWeight.stringFromKilograms(kilogram)
            }
            
            // Set the label to reflect the user's height.
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //                self.heightLabel.text = heightString
                print(weightString)
                
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.weight_str = weightString
                
            })
        })
        
        
    }
    
    func saveBMISample(bmi:Double, date:NSDate ) {
        
        // 1. Create a BMI Sample
        let bmiType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)
        let bmiQuantity = HKQuantity(unit: HKUnit.countUnit(), doubleValue: bmi)
        let bmiSample = HKQuantitySample(type: bmiType!, quantity: bmiQuantity, startDate: date, endDate: date)
        
        // 2. Save the sample in the store
        healthKitStore.healthStore.saveObject(bmiSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print("Error saving BMI sample: \(error!.localizedDescription)")
            } else {
                print("BMI sample saved successfully!")
            }
        })
    }
    
    func getDataFromHealthKit(sampleType: HKSampleType , completion: ((HKSample!, NSError!) -> Void)!) {
        
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
            }
        }
        
        // Time to execute the query.
        healthKitStore.healthStore.executeQuery(heightQuery)
    }
    
    func readProfile() -> Void {
        
        var error:NSError?
        var age:Int = 0
        let birthday:NSDate?
        
        do{
            birthday = try healthKitStore.healthStore.dateOfBirth()
            let today = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let differenceComponents = NSCalendar.currentCalendar().components(.NSYearCalendarUnit, fromDate: birthday!, toDate: today, options: NSCalendarOptions(rawValue: 0))
            age = differenceComponents.year
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    func readAge() -> Void
    {
        var error:NSError?
        var age:Int = 0
        var birthDay:NSDate?
        
        do {
            try birthDay =  healthKitStore.healthStore.dateOfBirth()
            let today = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let differenceComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: birthDay!, toDate: today, options: NSCalendarOptions(rawValue: 0))
            age = differenceComponents.year
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.my_age =  age
    }
    
    /*
 do {
 try birthDay =  healthKitStore.healthStore.dateOfBirth()
 let today = NSDate()
 let calendar = NSCalendar.currentCalendar()
 let differenceComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: birthDay!, toDate: today, options: NSCalendarOptions(rawValue: 0))
 age = differenceComponents.year
 } catch let error as NSError {
 print(error.localizedDescription)
 }
 
 return (age)
 */
 
 
    /* getHeight와 같은 내용이기에 생략
    func getWeight(sampleType: HKSampleType , completion: ((HKSample!, NSError!) -> Void)!) {
        
        // Predicate for the height query
        let pastWeight = NSDate.distantPast() as NSDate
        let currentDate = NSDate()
        let lastWeightPredicate = HKQuery.predicateForSamplesWithStartDate(pastWeight, endDate: currentDate, options: .None)
        
        // Get the single most recent height
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        // Query HealthKit for the last Height entry.
        let weightQuery = HKSampleQuery(sampleType: sampleType, predicate: lastWeightPredicate, limit: 1, sortDescriptors: [sortDescriptor]) { (sampleQuery, result, error ) -> Void in
            
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            
            // Set the first HKQuantitySample in results as the most recent height.
            let lastWeight = result!.first
            
            if completion != nil {
                completion(lastWeight, nil)
            }
        }
        
        // Time to execute the query.
        healthKitStore.healthStore.executeQuery(weightQuery)
    }
*/
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       page_num = Int(round(scroll_V.contentOffset.x/scroll_V.frame.size.width))
        
        page.currentPage = page_num
//        print(page_num)
        
    }
 
    
    // ---- tableView를 사용하지 않기로 하여 주석처리함
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 360.0
        }else if(indexPath.section == 1){
            return 100.0
        }else{
            return 80.0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let img_V = cell.viewWithTag(10) as! UIImageView
        
        if(indexPath.section == 0){
//        let imgView = UIImageView()
            img_V.image = UIImage(named: "앱지도.png")
//            imgView.contentMode = UIViewContentMode.ScaleAspectFit
//            imgView.frame = CGRectMake(10, 0, cell.frame.size.width-30, cell.frame.size.height)
//            cell.addSubview(imgView)
            
            
        }else if(indexPath.section == 1){
            
        }else{
            
        }
        
        return cell
    }
    
 */
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
