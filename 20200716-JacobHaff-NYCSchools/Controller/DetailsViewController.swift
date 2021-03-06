//
//  DetailsViewController.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    static var nycHighSchool = NYCHighSchool()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
}

extension DetailsViewController: UITableViewDataSource {
    // MARK: - Table view data source

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // this switch statement could be considered a bit wonky, and it is rather large. Given more time I might look to use an enum.
        switch indexPath.row {
        case 0: // name
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolNameCellIdentifier) as! HSNameTableViewCell

            cell.configure(with: DetailsViewController.nycHighSchool)

            return cell
        case 1: // scores
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithSATScoreCellIdentifier) as! HSSATScoresTableViewCell

            cell.configure(with: DetailsViewController.nycHighSchool)

            return cell
        case 2: // overview
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolOverviewCellIdentifier) as! HSOverviewTableViewCell

            cell.configure(with: DetailsViewController.nycHighSchool)

            return cell
        case 3: // contact
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolContactCellIdentifier) as! HSContactTableViewCell

            cell.configure(with: DetailsViewController.nycHighSchool)

            return cell
        case 4: // address
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithMapCellIdentifier) as! HSMapTableViewCell

            if let highSchoolCoordinate = Utils.getCoodinateForSelectedHighSchool(DetailsViewController.nycHighSchool.location) {
                cell.addHSAnnotaionWithCoordinates(highSchoolCoordinate)
            }

            return cell

        default:
            return UITableViewCell()
        }
    }
}

extension DetailsViewController: UITableViewDelegate {
    // MARK: - UITable View Delegate

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // this switch statement could be considered a bit wonky, and it is rather large. Given more time I might look to use an enum. I am also using "Magic numbers" for most of the row heights, except for the overview. For example I should be trying to use automaticDimension on the scores section as well.

        switch indexPath.row {
        case 0: // name
            return 40.00
        case 1: // scores
            return 160.00
        case 2: // overview
            return UITableView.automaticDimension
        case 3: // contact
            return 150.00
        case 4: // map
            return 200.00
        default:
            return 100.00
        }
    }
}
