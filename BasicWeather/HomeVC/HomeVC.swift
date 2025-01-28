//
//  ViewController.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-22.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        Api.shared.fetchCurrentWeather { weather in
            guard let weather else {return}
            print("Recived Data")
            //update tableview now
        }

    }
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
    }


}
extension HomeVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTopRow.id, for: indexPath) as! HomeTopRow
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCarouselRow.id, for: indexPath) as! HomeCarouselRow
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWeeklyForecastRow.id, for: indexPath) as! HomeWeeklyForecastRow
            return cell
        default:
            return UITableViewCell()
        }

       
    }
    
    
}
extension HomeVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     switch indexPath.row{
        case 0:
            return 175
        case 1:
            return 160
        case 2:
            return 350
        default:
         return 0
        }
    }
    
}


