//
//  LodingViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//  It's just a start screen 

import UIKit

class StartViewController: UIViewController {
    
    let startScreen = StartView()
    override func loadView() {
        view = startScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
