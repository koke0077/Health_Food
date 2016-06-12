//
//  School_Data_Manager.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School_Data_Manager : NSObject

-(void)initDB;

- (NSArray*)loadData;

- (NSArray*)loadDataWithSchool2:(NSString *)region;

- (NSString*)loadDataWithSchool_Url:(NSString *)schoolname;

- (NSArray*)loadAllDataWithSchool:(NSString *)schoolname;

-(int)getSchoolCount;

-(void)addDataWithday:(NSString *)day
            Breakfast:(NSString *)breakfast
                Lunch:(NSString *)lunch
               Dinner:(NSString *)dinner
             Distance:(NSString *)distance
       Breakfase_Food:(NSString *)breakfast_food
           Lunch_Food:(NSString *)lunch_food
          Dinner_Food:(NSString *)dinner_food;


-(void)upDateWithday:(NSString *)day
           Breakfast:(NSString *)breakfast
               Lunch:(NSString *)lunch
              Dinner:(NSString *)dinner
            Distance:(NSString *)distance
      Breakfase_Food:(NSString *)breakfast_food
          Lunch_Food:(NSString *)lunch_food
         Dinner_Food:(NSString *)dinner_food;


-(int)exist_Day:(NSString *)day;

-(int)exist_RegionName:(NSString *)region;

-(int)exist_School:(NSString *)name Region:(NSString *)region;

@end
