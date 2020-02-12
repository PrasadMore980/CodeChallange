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
    private var refreshControl: UIRefreshControl!

    //Creating tableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Height.infoTableCellEstimated
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRrefreshControls()
        setupTableView()

    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel = CountryInfoViewModel(delegate: self)
        viewModel.fetchAPI()
        
        //Title Update from received response
        viewModel.updateTitle = { [weak self] () in
            guard let self = self else { return }
            self.title = self.viewModel.countryInfoTitle
        }
        
        // refreshControl endRefreshing
        viewModel.refreshData = { [weak self] () in
            guard let self = self, let refreshControl = self.refreshControl else { return }
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
            }
        }

    }
}

//MARK:-  UI Setup
extension CountryInfoViewController {
    func setupTableView() {
        tableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: CountryInfoTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.refreshControl = refreshControl

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    private func setupRrefreshControls() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.backgroundColor = UIColor.lightGray
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Data Please Wait!!")
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        viewModel.fetchAPI()
    }
}

//MARK:- Callbacks on getting response
extension CountryInfoViewController: ServiceCallbackDelegate {
    func onSucessResponse(with response: CountryInfo) {
        countryInfo = response
        // Reloading to tableview
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func onFailureResponse(with responseMessage: String) {
        let failedAlert = UIAlertController(title: "", message: responseMessage, preferredStyle: .alert)
        failedAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(failedAlert, animated: true)
    }
}

extension CountryInfoViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryInfo?.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryInfoTableViewCell.identifier) as? CountryInfoTableViewCell else{
            fatalError("")
        }
        let currentItem = countryInfo.rows![indexPath.row]
        cell.rowElement = currentItem
        cell.selectionStyle = .none
        return cell
    }
    
    
}
