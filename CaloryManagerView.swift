//
//  CaloryManagerView.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 5. 12..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit

class CaloryManagerView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var cal_data = School_Data_Manager()
    
    var cal_arr = NSArray()
    
    var is_ok:Int = 0
    
    var secton_num = 0;
    
//    var today = String()
    
    @IBOutlet weak var caloryTableVeiw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.caloryTableVeiw.delegate = self
        self.caloryTableVeiw.dataSource = self

        cal_arr = cal_data.loadData()
        
                
    }
    
    func formatADate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let d = NSDate()
        let s = dateFormatter.stringFromDate(d)
        return s
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cal_arr.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lbl_A = UILabel() as UILabel
        lbl_A.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height-20)
        
        _ = 0
        let j = cal_arr.count
        
        for i in 0...j{
            
            if(section == i){
                lbl_A.textColor = UIColor.darkGrayColor()
                lbl_A.font = UIFont.boldSystemFontOfSize(18)
                lbl_A.text = "   " + (cal_arr.objectAtIndex(i).objectForKey("day") as? String)! + " 섭취 칼로리"
                lbl_A.backgroundColor = UIColor.lightGrayColor()
            }
        }
        
        return lbl_A
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let lbl_1 = cell.viewWithTag(10) as! UILabel
        let lbl_2 = cell.viewWithTag(20) as! UILabel
        let lbl_3 = cell.viewWithTag(30) as! UILabel
        
        let now_arr = cal_arr.objectAtIndex(indexPath.section)
        
       let arr_num = cal_arr.count
        
        if(indexPath.section == self.secton_num){
            self.secton_num = self.secton_num + 1
            lbl_1.text = now_arr.objectForKey("breakfast") as? String
            lbl_2.text = now_arr.objectForKey("lunch") as? String
            lbl_3.text = now_arr.objectForKey("dinner") as? String
         
            if(indexPath.section+1 == arr_num){
                self.secton_num = 0
            }
            
            
        }
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
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
