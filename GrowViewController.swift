//
//  GrowViewController.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 4. 29..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit


class GrowViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var txtV_breakfast: UITextView!
    @IBOutlet weak var txtV_lunch: UITextView!
    @IBOutlet weak var txtV_dinner: UITextView!
    @IBOutlet weak var breakfast_Kcal_lbl: UILabel!
    @IBOutlet weak var lunch_Kcal_lbl: UILabel!
    @IBOutlet weak var dinner_Kcal_lbl: UILabel!
    
    let food_data = School_Data_Manager()
    
    var foodArr1 = NSArray()
    var foodArr2 = NSArray()
    var foodArr3 = NSArray()
    var foodArr4 = NSArray()
    var calArr = NSMutableArray()
    var food_text = String()
    var now_time:Int = 0
    
    var today = String()
    
    var is_ok:Int = 0;
    
    var cal_arr = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodArr1 = ["쌀밥","보리밥","카레라이스","비빔밥","김치볶음밥","국수"]
        foodArr2 = ["아욱된장국","미역국","콩나물국","어묵국","육개장","갈비탕"]
        foodArr3 = ["콩나물무침","시금치무침","깍두기","배추김치","감자조림","연근조림","가지나물","오이생채","돼지갈비찜","달걀찜","감자전","완자전","생선까스","스파게티"]
        foodArr4 = ["귤","키위","바나나","바게뜨","송편","약밥"]
        

        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
        
        today = self.formatADate()
        
        self.date_lbl.text = today
        
        is_ok = Int(self.food_data.exist_Day(self.formatADate()))
        
        if(is_ok == 1){
            
            let arr = food_data.loadData()
            
            var str_1 = arr.last?.objectForKey("breakfast_food") as! String
            var str_2 = arr.last?.objectForKey("lunch_food") as! String
            var str_3 = arr.last?.objectForKey("dinner_food") as! String
            
            let str_11 = arr.last?.objectForKey("breakfast") as! String
            let str_21 = arr.last?.objectForKey("lunch") as! String
            let str_31 = arr.last?.objectForKey("dinner") as! String
            
            self.breakfast_Kcal_lbl.text = str_11
            self.lunch_Kcal_lbl.text = str_21
            self.dinner_Kcal_lbl.text = str_31
            
            if(str_1 == ""){
                str_1 = "식사 안함"
            }
            if(str_2 == ""){
                str_2 = "식사 안함"
            }
            if(str_3 == ""){
                str_3 = "식사 안함"
            }
            self.txtV_breakfast.text = str_1
            self.txtV_lunch.text = str_2
            self.txtV_dinner.text = str_3
            
        }else{
            
            let str_1 = "식사안함"
            let str_2 = "식사안함"
            let str_3 = "식사안함"
                
            self.txtV_breakfast.text = str_1
            self.txtV_lunch.text = str_2
            self.txtV_dinner.text = str_3

            
        }

    
    }
    
    func formatADate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let d = NSDate()
        let s = dateFormatter.stringFromDate(d)
        return s
    }
    
    
    @IBAction func reset_btn(sender: UIButton) {
        if(now_time == 0){
            breakfast_Kcal_lbl.text = ""
            txtV_breakfast.text = ""
        }else if(now_time == 1){
            lunch_Kcal_lbl.text = ""
            txtV_lunch.text = ""
            
        }else{
            dinner_Kcal_lbl.text = ""
            txtV_dinner.text = ""
        }
    }
    
    @IBAction func save_btn(sender: UIButton) {
        
        let is_ok = food_data.exist_Day(today)
        if(is_ok == 0){
            
            food_data.addDataWithday(today, breakfast: self.breakfast_Kcal_lbl.text, lunch: self.lunch_Kcal_lbl.text, dinner: self.dinner_Kcal_lbl.text, distance: "1000", breakfase_Food: self.txtV_breakfast.text, lunch_Food: self.txtV_lunch.text, dinner_Food: self.txtV_dinner.text)
        }else{
            food_data.upDateWithday(today, breakfast: self.breakfast_Kcal_lbl.text, lunch: self.lunch_Kcal_lbl.text, dinner: self.dinner_Kcal_lbl.text, distance: "1000", breakfase_Food: self.txtV_breakfast.text, lunch_Food: self.txtV_lunch.text, dinner_Food: self.txtV_dinner.text)
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return foodArr1.count
        }else if(section == 1){
            return foodArr2.count
        }else if(section == 2){
            return foodArr3.count
        }else{
            return foodArr4.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        let cell_img = cell.viewWithTag(20) as! UIImageView
        let cell_lbl = cell.viewWithTag(10) as! UILabel
        
        if(indexPath.section == 0){
            cell_img.image = UIImage(named: foodArr1.objectAtIndex(indexPath.row) as! String)
            cell_lbl.text = foodArr1.objectAtIndex(indexPath.row) as? String
        }else if(indexPath.section == 1){
            cell_img.image = UIImage(named: foodArr2.objectAtIndex(indexPath.row) as! String)
            cell_lbl.text = foodArr2.objectAtIndex(indexPath.row) as? String
            
        }else if(indexPath.section == 2){
            cell_img.image = UIImage(named: foodArr3.objectAtIndex(indexPath.row) as! String)
            cell_lbl.text = foodArr3.objectAtIndex(indexPath.row) as? String
            
        }else if(indexPath.section == 3){
            cell_img.image = UIImage(named: foodArr4.objectAtIndex(indexPath.row) as! String)
            cell_lbl.text = foodArr4.objectAtIndex(indexPath.row) as? String
            
        }
        
        return cell
    }
    
    @IBAction func seg_meal(sender: UISegmentedControl) {
        now_time = sender.selectedSegmentIndex
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(now_time == 0){
            
            if(indexPath.section == 0){
                let str = self.breakfast_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_breakfast.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr1.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_breakfast.text = food_text
                
                cal_sum = cal + cal_sum
                self.breakfast_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else if(indexPath.section == 1){
                let str = self.breakfast_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_breakfast.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr2.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_breakfast.text = food_text
                
                cal_sum = cal + cal_sum
                self.breakfast_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else if(indexPath.section == 2){
                let str = self.breakfast_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_breakfast.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr3.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_breakfast.text = food_text
                
                cal_sum = cal + cal_sum
                self.breakfast_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else{
                let str = self.breakfast_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_breakfast.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr4.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_breakfast.text = food_text
                
                cal_sum = cal + cal_sum
                self.breakfast_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }
            
        }else if(now_time == 1){
            
            if(indexPath.section == 0){
                let str = self.lunch_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_lunch.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr1.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_lunch.text = food_text
                
                cal_sum = cal + cal_sum
                self.lunch_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else if(indexPath.section == 1){
                let str = self.lunch_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_lunch.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr2.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_lunch.text = food_text
                
                cal_sum = cal + cal_sum
                self.lunch_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else if(indexPath.section == 2){
                let str = self.lunch_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_lunch.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr3.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_lunch.text = food_text
                
                cal_sum = cal + cal_sum
                self.lunch_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else{
                let str = self.lunch_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_lunch.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr4.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_lunch.text = food_text
                
                cal_sum = cal + cal_sum
                self.lunch_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }
            
        }else if(now_time == 2){
            
            if(indexPath.section == 0){
                let str = self.dinner_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_dinner.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr1.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_dinner.text = food_text
                
                cal_sum = cal + cal_sum
                self.dinner_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else if(indexPath.section == 1){
                let str = self.dinner_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_dinner.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr2.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_dinner.text = food_text
                
                cal_sum = cal + cal_sum
                self.dinner_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else if(indexPath.section == 2){
                let str = self.dinner_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_dinner.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr3.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_dinner.text = food_text
                
                cal_sum = cal + cal_sum
                self.dinner_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }else{
                let str = self.dinner_Kcal_lbl.text?.stringByReplacingOccurrencesOfString("Kcal", withString: "")
                var cal_sum = CFStringGetIntValue(str)
                let cal = self.fodd_cal(indexPath)
                
                food_text = self.txtV_dinner.text
                food_text.appendContentsOf("\n")
                food_text.appendContentsOf(foodArr4.objectAtIndex(indexPath.row) as! String)
                food_text.appendContentsOf(String(format: "%d Kcal", cal))
                self.txtV_dinner.text = food_text
                
                cal_sum = cal + cal_sum
                self.dinner_Kcal_lbl.text = String(format: "%d Kcal", cal_sum)
            }
            
        }
    }
    
    func fodd_cal(indexPath: NSIndexPath) -> Int {
        
        var return_num:Int = 0
        
        if(indexPath.section == 0){
            switch indexPath.row {
            case 0:
                return_num = 210
                break
            case 1:
                return_num = 210
                break
            case 2:
                return_num = 480
                break
            case 3:
                return_num = 420
                break
            case 4:
                return_num = 410
                break
            case 5:
                return_num = 290
                break
            default:
                break
            }
        }else if(indexPath.section == 2){
            switch indexPath.row {
            case 0:
                return_num = 35
                break
            case 1:
                return_num = 30
                break
            case 2:
                return_num = 15
                break
            case 3:
                return_num = 10
                break
            case 4:
                return_num = 80
                break
            case 5:
                return_num = 30
                break
            case 6:
                return_num = 20
                break
            case 7:
                return_num = 15
                break
            case 8:
                return_num = 250
                break
            case 9:
                return_num = 70
                break
            case 10:
                return_num = 90
                break
            case 11:
                return_num = 110
                break
            case 12:
                return_num = 130
                break
            case 13:
                return_num = 260
                break
            default:
                break
            }
        }else if(indexPath.section == 1){
            switch indexPath.row {
            case 0:
                return_num = 55
                break
            case 1:
                return_num = 65
                break
            case 2:
                return_num = 35
                break
            case 3:
                return_num = 80
                break
            case 4:
                return_num = 200
                break
            case 5:
                return_num = 300
                break
            default:
                break
            }
        }else if(indexPath.section == 3){
            switch indexPath.row {
            case 0:
                return_num = 80
                break
            case 1:
                return_num = 30
                break
            case 2:
                return_num = 100
                break
            case 3:
                return_num = 60
                break
            case 4:
                return_num = 100
                break
            case 5:
                return_num = 135
                break
            default:
                break
            }
        }
        
        return return_num
    }
    
    @IBAction func manage_btn(sender: UIButton) {
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
