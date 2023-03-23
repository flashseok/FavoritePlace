//
//  SelectedPlaceViewController.swift
//  FavoritePlace
//
//  Created by 김현석 on 2023/03/20.
//

import UIKit

class SelectedPlaceViewController: UIViewController {

    let selectedPlaceView = SelectedPlaceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = selectedPlaceView
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
