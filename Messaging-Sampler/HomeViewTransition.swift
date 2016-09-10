//
//  HomeViewTransition.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

protocol HomeViewTransition {
    func toHomeViewTransition(on viewcontroller: UIViewController)
}

struct Transition: HomeViewTransition {
    func toHomeViewTransition(on viewcontroller: UIViewController) {
        let home = viewcontroller.storyboard?.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        viewcontroller.present(home, animated: false, completion: nil)
    }
}
