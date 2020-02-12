//
//  CountryInfoViewController.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

class CountryInfoViewController: UIViewController {
    private var countryInfo: CountryInfo!
    private var viewModel: CountryInfoViewModel!

    //Creating tableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Height.infoTableCellEstimated
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()

        self.title = "Country info"
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel = CountryInfoViewModel(delegate: self)
        viewModel.fetchAPI()
    }
}

//MARK:-   UI Setup
extension CountryInfoViewController {
    func setupTableView() {
        tableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: "CountryInfoTableViewCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

//MARK:- Callbacks on getting response
extension CountryInfoViewController: ServiceCallbackDelegate {
    func onSucessResponse(with response: CountryInfo) {
        countryInfo = response
        //Printing Parsed Response Before loading to tableview
        print(countryInfo ?? "Failed")
    }
    func onFailureResponse(with responseMessage: String) {
        let failedAlert = UIAlertController(title: "", message: responseMessage, preferredStyle: .alert)
        failedAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(failedAlert, animated: true)
    }
}
