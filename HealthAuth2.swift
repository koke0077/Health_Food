//
//  HealthAuth2.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 5. 6..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import Foundation
import HealthKitUI

class HealthAuth2: NSObject {
    
    let healthStore = HKHealthStore()
    
    func health_Authinit(){
        
        
        let shareObjectType = NSSet.init(objects:HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!, HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!, HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!, HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!)
        
        let readObjectType = NSSet.init(objects:
            HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!,HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex)!,HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!, HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierFitzpatrickSkinType)!, HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!,HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!)
        
        healthStore.requestAuthorizationToShareTypes(shareObjectType as? Set<HKSampleType>, readTypes: readObjectType as? Set<HKObjectType>, completion: { success, error in if success {
            print("SUCCESS")
        }else{
            
            }
            
        })
    }
}