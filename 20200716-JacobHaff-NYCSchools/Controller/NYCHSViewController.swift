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
        
        tableView.register(UINib(nibName: "NYCHSCell", bundle: nil), forCellReuseIdentifier: "NYCHSCell")
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchNYCHighSchoolInformation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
    //MARK: - Variables
    
    var nycHSList: [NYCHighSchool]?
    
    //MARK: - API Calls and JSON parsing
    
    //TODO: Extract these methods to an API class wirth static methods. Maybe another file for JSON parsing.
    
    func fetchNYCHighSchoolInformation() {
        guard let highSchoolsURL = URL(string: K.highSchoolsURL) else {
            return
        }
        
        let request = URLRequest(url:highSchoolsURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] (highSchoolsData, response, error)  in
            if highSchoolsData != nil{
                do{
                    let highSchoolsObject = try JSONSerialization.jsonObject(with: highSchoolsData!, options: [])
                    self?.nycHSList = Utils.highSchoolsJSONDataToModelArray(highSchoolsObject)
                    self?.fetchHighSchoolDetails()
                }catch{
                    print("NYC HS JSON error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
        print(nycHSList)
    }
    
    private func fetchHighSchoolDetails() {
        guard let highSchoolDetailsURL = URL(string: K.schoolDetailsUrl) else {
            return
        }
        let request = URLRequest(url:highSchoolDetailsURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {[weak self] (schoolDetailsData, response, error) in
            if schoolDetailsData != nil{
                do{
                    let detailsObject = try JSONSerialization.jsonObject(with: schoolDetailsData!, options: [])
                    self?.addSatScoreToHighSchool(detailsObject)
                    DispatchQueue.main.async {[weak self] in
                        self?.tableView.reloadData()
                    }
                }catch{
                    debugPrint("high school with sat score json error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
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
        print(nycHSList)
        
    }
    
    
}

// MARK: UITableViewDataSource Extension
extension NYCHSViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.nycHSList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NYCHSSchoolCell = self.tableView.dequeueReusableCell(withIdentifier: K.hsCellIdentifier, for: indexPath) as! NYCHSSchoolCell
        
        cell.schoolNameLabel.text = nycHSList?[indexPath.row].name
        
        return cell
    }
}
