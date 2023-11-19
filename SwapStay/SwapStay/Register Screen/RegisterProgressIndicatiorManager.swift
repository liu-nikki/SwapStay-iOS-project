//
//  RegisterProgressIndicatiorManager.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import Foundation

extension RegisterViewController: ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
