//
//  Quest+staticQuests.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/5/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

/// This extension contains `Quest`s that are compiled into the app.
extension Quest {
    
    static func makeAccessibleToiletsQuest() -> Quest {
        let identifier = "accessible_toilets"
        let question = "Are these toilets wheelchair accessible?"
        let query = "(type:node or type:way) and amenity=toilets and access !~ \"private|customers\" and wheelchair!=*"
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
    static func makeParkingFeeQuest() -> Quest {
        let identifier = "parking_fee"
        let question = "Does it cost a fee to park here? "
        let query = "(type:node or type:way) and amenity=parking and fee!=* and access~\"yes|customers|public\""
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
    static func makeBenchBackrestQuest() -> Quest {
        let identifier = "bench_backrest"
        let question = "Does this bench have a backrest?"
        let query = "(type:node) and amenity=bench and backrest!=*"
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
    static func makePlaygroundAccessQuest() -> Quest {
        let identifier = "playground_access"
        let question = "Is this playground generally accessible?"
        let query = "leisure=playground and (access!=* or access=unknown)"
        
        return Quest(identifier: identifier,
        question: question,
        overpassWizardQuery: query)
    }
    
    static func makeToiletQuest() -> Quest {
        let identifier = "toilet"
        let question = "Does this place have a toilet?"
        let query = "(type:node or type:way) and ( (shop ~= \"mall|department_store\" and name = *) or (highway~\"services|rest_area\") ) and toilets != *"
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
}
