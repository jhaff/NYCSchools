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
    private func addSatScoreToHighSchool(_ satScoreObject: Any) {
        guard let highSchoolsWithSatScoreArr = satScoreObject as? [[String: Any]] else{
            return
        }
        
        for  highSchoolsWithSatScore in highSchoolsWithSatScoreArr{
            if let matchedDBN = highSchoolsWithSatScore["dbn"] as? String{
                //This will get the High School with the same DBN
                let matchedHighSchools = self.nycHSList?.first(where: { (nycHighSchool) -> Bool in
                    return nycHighSchool.id == matchedDBN
                })
                
                guard matchedHighSchools != nil else{
                    continue
                }
                
                if let satReadingScoreObject =  highSchoolsWithSatScore["sat_critical_reading_avg_score"] as? String{
                    matchedHighSchools!.satCriticalReadingAvgScore = satReadingScoreObject
                }
                
                if let satMathScoreObject = highSchoolsWithSatScore["sat_math_avg_score"] as? String{
                    matchedHighSchools!.satMathAvgScore = satMathScoreObject
                }
                
                if let satWritingScoreObject =  highSchoolsWithSatScore["sat_writing_avg_score"] as? String{
                    matchedHighSchools!.satWritinAvgScore = satWritingScoreObject
                }
                
            }
        }
    }
    
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        //TESTING
        doDopeThings()
        
    }
    
    
    //MARK: Testing API shit
    
    private func doDopeThings() {
        ServiceLayer.request(router: Router.getSchools) { (result: Result<[NYCHighSchool], Error>) in
            switch result {
            case .success(let schools):
                print(result)
                
                self.nycHSList = schools
                self.tableView.reloadData()
            case .failure:
                print(result)
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
        }
        
        cell.schoolNameLabel.text = school.name
                
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

// MARK: UITableViewDelegate Extension

extension NYCHSViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedHighSchool = nycHSList?[indexPath.row]
        self.performSegue(withIdentifier: Constants.HSDetailsSegue, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.00
    }
}
