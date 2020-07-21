//
//  NYCHSViewController.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class NYCHSViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "SchoolCell", bundle: nil), forCellReuseIdentifier: "SchoolCell")
        
        DispatchQueue.global(qos: .userInitiated).async {
//            self.doDopeThings()
        }
        
    }
    
    //MARK: - Variables
    
    var nycHSList: [NYCHighSchool]?
    
    func updateSchools(schools: [NYCHighSchool]) {
        nycHSList = schools
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
    /**
     This function is used to add the sat score to the high school
     
     - Parameter satScoreObject: Data of Array composed with Dictionary
     */

    
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        //TESTING
        fetchHighSchoolList(completion: {
            self.fetchHighSchoolSATSore(completion: {
                self.tableView.reloadData()
            })
        })
                
    }
    
    
    //MARK: Testing API shit
    
    private func fetchHighSchoolList(completion: @escaping () -> Void) {
        ServiceLayer.request(router: Router.getSchools) { (result: Result<[NYCHighSchool], Error>) in
            switch result {
            case .success(let schools):
                print(Date(), "HS")
                
                self.nycHSList = schools
                completion()
            case .failure:
                print(result)
            }
            
    
        }
    }
    
    // This function is will call the API to get all of the High School with SAT Score, and add to the exist model array according to the common parameter DBN.
    private func fetchHighSchoolSATSore(completion: @escaping () -> Void) {
        ServiceLayer.request(router: Router.getDetails) { (result: Result<[NYCHighSchool], Error>) in
        switch result {
        case .success(let satScoreObject):
            print(Date(), "Score")
            
            self.addSatScoreToHighSchools(satScoreObject)
            
            completion()
        case .failure:
            print(result)
        }
    }
    }
    
    /// This function is used to add the sat score to the high school
    ///
    /// - Parameter satScoreObject: Data of Array composed with Dictionary
    func addSatScoreToHighSchools(_ satScoreObject: [NYCHighSchool]) {
//        guard var highSchoolsWithSatScoreArr = satScoreObject as? [[String: Any]] else {
//            return
//        }
        
        for thing in satScoreObject {
            if let matchedDBN = thing.dbn {
                //This will get the High School with the Common DBN
                let matchedHighSchool = self.nycHSList?.first(where: { (nycHighSchool) -> Bool in
                    return nycHighSchool.dbn == matchedDBN
                })
                
                 guard matchedHighSchool != nil else{
                    continue
                }
                
                matchedHighSchool?.satCriticalReadingAvgScore = thing.satCriticalReadingAvgScore
                
                matchedHighSchool?.satMathAvgScore = thing.satMathAvgScore

                matchedHighSchool?.satWritingAvgScore = thing.satWritingAvgScore

        }
    }
}
}

// MARK: UITableViewDataSource Extension
extension NYCHSViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.nycHSList?.count ?? 0
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SchoolCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.hsCellIdentifier, for: indexPath) as! SchoolCell
                
//        cell.school = nycHSList?[indexPath.row] as! NYCHighSchool
        
        var school = NYCHighSchool()
        
        if nycHSList?[indexPath.row] != nil {
            school = nycHSList![indexPath.row]
        } else {
            fatalError()
        }
        
        cell.schoolNameLabel.text = school.schoolName
        
        if (school.neighborhood != nil && school.borough != nil) {
            cell.schoolCityLabel.text = school.neighborhood! + ", " + school.borough!.capitalized
        }
        
        cell.schoolCombinedSATLabel.text = school.getCombinedSATScoreString()
                
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

// MARK: UITableViewDelegate Extension

extension NYCHSViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedHighSchool = nycHSList?[indexPath.row] {
            DetailsViewController.nycHighSchool = selectedHighSchool
        }
        
        
//        navigationController.title = DetailsViewController.nycHighSchool.schoolName
        
        self.performSegue(withIdentifier: Constants.HSDetailsSegue, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.00
    }
}

