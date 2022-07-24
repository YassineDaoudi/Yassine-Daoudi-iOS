//
//  ViewController.swift
//  Guidomia
//
//  Created by Yassine DAOUDI on 22/7/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Properties
    var sections: [CarSection] = []
    
    //MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()

        if let carsArray = parse(readLocalFile() ?? Data()) {
            carsArray.forEach {
                let section = CarSection(isExpanded: false, cars: [$0])
                sections.append(section)
            }
            sections[0].isExpanded = true
        }
    }
    
    //MARK: - Configure UI
    func configureNavigationController() {
        title = "GUIDOMIA"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addRightBarButton()
        
        //MARK: Configure Appearance
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hex: 0xFC6016)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addRightBarButton() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                         style: .done,
                                         target: self,
                                         action: nil)
        menuButton.tintColor = .white
        navigationItem.rightBarButtonItem = menuButton
    }
    
    func configureTableView() {
        tableView.separatorColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.register(CarCell.self, forCellReuseIdentifier: CarCell.reuseID)
        tableView.register(CarHeader.self, forCellReuseIdentifier: CarHeader.reuseID)
    }

    //MARK: - Reading and Parsing Data
    func readLocalFile() -> Data? {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: "car_list",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func parse(_ jsonData: Data) -> [Car]? {
        do {
            let cars = try JSONDecoder().decode([Car].self, from: jsonData)
            return cars
        } catch {
            print(error)
        }
        return nil
    }
}

//MARK: - UITableViewController dataSource methods
extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].isExpanded { return 0 }
        return sections[section].cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.reuseID, for: indexPath) as! CarCell
        let car = sections[indexPath.section].cars[indexPath.row]
        cell.setPros(with: car.prosList)
        cell.setCons(with: car.consList)
        return cell
    }
}

//MARK: - UITableViewController delegate methods
extension ViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: CarHeader.reuseID) as! CarHeader
        let car = sections[section].cars[0]
        cell.set(with: car)
        containerView.addSubview(cell)
        cell.pinToEdges(to: containerView)
        containerView.tag = section
        let headerGesture = UITapGestureRecognizer()
        headerGesture.addTarget(self, action: #selector(handleExpandClose))
        containerView.addGestureRecognizer(headerGesture)
        return containerView
    }
    
    @objc func handleExpandClose(sender: UITapGestureRecognizer) {
        let headerView = sender.view!
        let section = headerView.tag
        var indexPaths = [IndexPath]()
        
        for row in sections[section].cars.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        sections[section].isExpanded = !sections[section].isExpanded
        
        if sections[section].isExpanded {
            tableView.insertRows(at: indexPaths, with: .left)
        } else {
            tableView.deleteRows(at: indexPaths, with: .right)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xFC6016)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == sections.endIndex - 1 { return 0 }
        return 4
    }
}
