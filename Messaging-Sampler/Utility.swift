//
//  Utility.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    class func presentActionSheet(on viewcontroller: UIViewController, title: String, message: String, numberOfActions: Int, actionTitles: [String], actionStyles: [UIAlertActionStyle], actionHandlers: [((UIAlertAction)-> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for i in 0 ..< numberOfActions {
            let action = UIAlertAction(title: actionTitles[i], style: actionStyles[i], handler: actionHandlers[i])
            alert.addAction(action)
        }
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    class func presentAlert(on viewcontroller: UIViewController, title: String, message: String, numberOfActions: Int, actionTitles: [String], actionStyles: [UIAlertActionStyle], actionHandlers: [((UIAlertAction)-> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for i in 0 ..< numberOfActions {
            let action = UIAlertAction(title: actionTitles[i], style: actionStyles[i], handler: actionHandlers[i])
            alert.addAction(action)
        }
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    
    class func segueTransition(from viewcontrller: UIViewController, segue id: String, sender: AnyObject?) {
        viewcontrller.performSegue(withIdentifier: id, sender: nil)
    }
}
