//
//  String.swift
//  Online Shop App
//
//  Created by Awady on 12/10/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation

extension String {
    var isValideEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: self)
    }
    
    var isValideDate: Bool {
        let dateFormatSet = DateFormatter()
        dateFormatSet.dateFormat = "YYYY-MM--DD"
        let someDate = "string date"
        
//        let birthdatePredicate = NSPredicate(format: "string date", dateFormatSet)
//
//        return birthdatePredicate.evaluate(with: self)
        return dateFormatSet.date(from: someDate) != nil
    }
}
