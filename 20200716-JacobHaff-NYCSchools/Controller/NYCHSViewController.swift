//
//  NYCHSViewController.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class NYCHSViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = self

        tableView.delegate = self

        tableView.register(UINib(nibName: "SchoolCell", bundle: nil), forCellReuseIdentifier: "SchoolCell")

        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchHighSchoolList(completion: {
                self.fetchHighSchoolSATSore(completion: {
                    self.tableView.reloadData()
                })
            })
        }
    }

    // MARK: - Variables

    var nycHSList: [NYCHighSchool]?

    func updateSchools(schools: [NYCHighSchool]) {
        nycHSList = schools
    }

    override func viewWillAppear(_: Bool) {
        //        self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    /**
     This function is used to add the sat score to the high school

     - Parameter satScoreObject: Data of Array composed with Dictionary
     */

    @IBAction func sortButtonPressed(_: UIBarButtonItem) {
        // TESTING
        fetchHighSchoolList(completion: {
            self.fetchHighSchoolSATSore(completion: {
                self.tableView.reloadData()
            })
        })
    }

    // MARK: API layer calls

    private func fetchHighSchoolList(completion: @escaping () -> Void) {
        ServiceLayer.request(router: Router.getSchools) { (result: Result<[NYCHighSchool], Error>) in
            switch result {
            case let .success(schools):
                self.nycHSList = schools
                completion()
            case .failure:
                print(result)
            }
        }
    }

    /**
      This function is will call the API to get all of the High School with SAT Score, and add to the exist model array according to the common parameter DBN.

     - Parameter completion: closure to be executed after a successful API call
       */
    private func fetchHighSchoolSATSore(completion: @escaping () -> Void) {
        ServiceLayer.request(router: Router.getDetails) { (result: Result<[NYCHighSchool], Error>) in
            switch result {
            case let .success(satScoreObject):
                self.addSatScoreToHighSchools(satScoreObject)

                completion()
            case .failure:
                print(result)
            }
        }
    }

    /**
     This function is used to add ALL the sat scores to ALL rhw  high schools

     - Parameter satScoreObjects: Array of NYCHighSchool objects with SAT data only
       */
    func addSatScoreToHighSchools(_ satScoreObject: [NYCHighSchool]) {
        for satScoreObject in satScoreObject {
            if let matchedDBN = satScoreObject.dbn {
                // This will get the High School with the Common DBN
                let matchedHighSchool = nycHSList?.first(where: { (nycHighSchool) -> Bool in
                    nycHighSchool.dbn == matchedDBN
                })

                guard matchedHighSchool != nil else {
                    continue
                }

                matchedHighSchool?.satCriticalReadingAvgScore = satScoreObject.satCriticalReadingAvgScore

                matchedHighSchool?.satMathAvgScore = satScoreObject.satMathAvgScore

                matchedHighSchool?.satWritingAvgScore = satScoreObject.satWritingAvgScore
            }
        }
    }
}

// MARK: UITableViewDataSource Extension

extension NYCHSViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return nycHSList?.count ?? 0
    }

    // Make the background color show through
    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SchoolCell = tableView.dequeueReusableCell(withIdentifier: Constants.hsCellIdentifier, for: indexPath) as! SchoolCell

        var school = NYCHighSchool()

        if nycHSList?[indexPath.row] != nil {
            school = nycHSList![indexPath.row]
        } else {
            fatalError()
        }

        cell.schoolNameLabel.text = school.schoolName

        if school.neighborhood != nil, school.borough != nil {
            cell.schoolCityLabel.text = school.neighborhood! + ", " + school.borough!.capitalized
        }

        cell.schoolCombinedSATLabel.text = school.getCombinedSATScoreString()

        return cell
    }

    override func prepare(for _: UIStoryboardSegue, sender _: Any?) {}
}

// MARK: UITableViewDelegate Extension

extension NYCHSViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedHighSchool = nycHSList?[indexPath.row] {
            DetailsViewController.nycHighSchool = selectedHighSchool
        }

        performSegue(withIdentifier: Constants.HSDetailsSegue, sender: self)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 180.00
    }
}
