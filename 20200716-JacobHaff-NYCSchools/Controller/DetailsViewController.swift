//
//  DetailsViewController.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var nycHighSchool = NYCHighSchool()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

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

extension DetailsViewController: UITableViewDataSource {
    // MARK: - Table view data source
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        CellAnimator.animate(cell, withDuration: 0.6, animation: CellAnimator.AnimationType(rawValue: 5)!)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return DetailCellsHelper.tableViewCellWithSATScore(self.tableView, hsWithSatScore: DetailsViewController.nycHighSchool)
        case 1:
            return DetailCellsHelper.tableViewCellWithOverView(self.tableView, hsWithSatScore: DetailsViewController.nycHighSchool)
        case 2:
            return DetailCellsHelper.tableViewCellWithContactInfo(self.tableView, hsWithSatScore: DetailsViewController.nycHighSchool)
        default:
            return DetailCellsHelper.tableViewCellWithAddress(self.tableView, hsWithSatScore: DetailsViewController.nycHighSchool)
        }
    }
}
extension DetailsViewController: UITableViewDelegate {
    
    //MARK: - UITable View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2:
            return UITableView.automaticDimension
        default:
            return UIScreen.main.bounds.width * 0.7
        }
    }
}
