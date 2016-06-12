//
//  School_Data_Manager.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "School_Data_Manager.h"
#import <sqlite3.h>
static sqlite3 *database = nil;

@implementation School_Data_Manager




-(void)initDB{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    //    NSLog(@"%@",dbPath);
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"food_data.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:nil];
        
        if (!success) NSLog(@"데이터베이스 파일 복사 실패.");
    }
}



- (NSString *)getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"food_data.sqlite"];
}

- (NSArray*)loadData{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"food_data.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    
    
    NSMutableArray * infoArray = [NSMutableArray array];

    char *strSQL = "SELECT * From myCalory ";

    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, strSQL , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {

            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)],@"day",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"breakfast",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"lunch",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"dinner",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"distance",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)],@"breakfast_food",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)],@"lunch_food",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)],@"dinner_food",
                                 nil];
            
            [infoArray addObject:dic];

            
            }
        
        }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return infoArray;
}


-(void)addDataWithday:(NSString *)day
            Breakfast:(NSString *)breakfast
                Lunch:(NSString *)lunch
               Dinner:(NSString *)dinner
             Distance:(NSString *)distance
       Breakfase_Food:(NSString *)breakfast_food
           Lunch_Food:(NSString *)lunch_food
          Dinner_Food:(NSString *)dinner_food{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"food_data.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = "INSERT INTO myCalory (day, breakfast, lunch, dinner, distance, breakfast_food, lunch_food, dinner_food) VALUES(?,?,?,?,?,?,?,?)";
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
//        sqlite3_bind_int(statement, 1, no);
        sqlite3_bind_text(statement, 1, [day UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [breakfast UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [lunch UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [dinner UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [distance UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [breakfast_food UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [lunch_food UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [dinner_food UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}


-(void)upDateWithday:(NSString *)day
           Breakfast:(NSString *)breakfast
               Lunch:(NSString *)lunch
              Dinner:(NSString *)dinner
            Distance:(NSString *)distance
      Breakfase_Food:(NSString *)breakfast_food
          Lunch_Food:(NSString *)lunch_food
         Dinner_Food:(NSString *)dinner_food{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"food_data.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = "update myCalory set day=?, breakfast =?, lunch=?, dinner=?, distance=?, breakfast_food=?, lunch_food=?, dinner_food=? where day=?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
//        sqlite3_bind_int(statement, 1, no);
        
        sqlite3_bind_text(statement, 1, [day UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [breakfast UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [lunch UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [dinner UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [distance UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [breakfast_food UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [lunch_food UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [dinner_food UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 9, [day UTF8String], -1, SQLITE_TRANSIENT);

        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"업데이트 저장에러");
        }
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}


-(int)exist_Day:(NSString *)day{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"food_data.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    sqlite3_stmt *statement;
    
    NSString *strSql = [NSString stringWithFormat:@"SELECT EXISTS(select day from myCalory where day='%@')",day];
    
    int exist_data;
    
    
    if (sqlite3_prepare_v2(database, [strSql UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            exist_data = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return exist_data;

}

-(int)exist_RegionName:(NSString *)region{
    
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data1.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    sqlite3_stmt *statement;
    
    NSString *strSql = [NSString stringWithFormat:@"SELECT EXISTS(select Region from schools where Region='%@')",region];
    
    int exist_data;
    
    if (sqlite3_prepare_v2(database, [strSql UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            exist_data = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return exist_data;

}

-(int)exist_School:(NSString *)name Region:(NSString *)region{
    
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data1.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    sqlite3_stmt *statement;
    
    NSString *strSql = [NSString stringWithFormat:@"SELECT EXISTS(select * from schools where Region='%@' AND Name='%@')",region,name];
    
    int exist_data=0;
    
    if (sqlite3_prepare_v2(database, [strSql UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            exist_data = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return exist_data;
    
}
//Select exists(select * from schools where Name='아라초등학교' And Region='함안');


- (NSArray*)loadAllDataWithSchool:(NSString *)schoolname{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data1.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT * From schools where Name = '%@'",schoolname];
    
    sqlite3_stmt *statement;
    
    //    NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"no",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"Region",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"Name",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"Web_Address",
                                 nil];
            
            [infoArray addObject:dic];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return infoArray;
    
}

- (NSArray*)loadDataWithSchool2:(NSString *)region{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data1.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    
    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT Name From schools where Region ='%@'",region];
    
    sqlite3_stmt *statement;
    NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return infoArray;
    
}

- (NSString*)loadDataWithSchool_Url:(NSString *)schoolname{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data1.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    //    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT Web_Address From schools where Name = '%@'",schoolname];
    
    sqlite3_stmt *statement;
    
    NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            
            
            name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return name;
}

-(int)getSchoolCount{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data1.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    NSString *strSQL = @"SELECT COUNT(no) FROM schools";
    
    sqlite3_stmt *statement;
    
    int cnt;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            cnt = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return cnt;
    
}

@end
