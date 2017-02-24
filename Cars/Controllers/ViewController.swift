//
//  ViewController.swift
//  Cars
//
//  Created by Kamal Jaiswal on 09/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SDWebImage
import GoogleMaps
import MBProgressHUD



struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : SectionModelType {
    typealias Item = Car
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Car]) {
        self = original
        self.items = items
    }
}

class ViewController: UIViewController {

    var carViewmodel:CarViewModel = CarViewModel()
    @IBOutlet var tableView: UITableView!
    var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
     let disposeBag = DisposeBag()
    @IBOutlet var mapContainer:UIView!
    var mapService:MapService<GoogMaps>?
    //var mapService:MapService<AppMaps>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MBProgressHUD.showAdded(to: self.view, animated: true)
       setupMap()
        
        carViewmodel.load { (error) in
            print(self.carViewmodel.count())
            MBProgressHUD.hide(for: self.view, animated: true)
            self.setuplist()
            self.plotmarkers()
        }

    }
    
    
    func setuplist()  {
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>()
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        let sections = [
            MySection(header: CarList.mini, items: (self.carViewmodel.sectionsData?[CarList.mini])!),
            MySection(header: CarList.bmw, items: (self.carViewmodel.sectionsData?[CarList.bmw])!)
        ]
        
        Observable.just(sections)
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        self.dataSource = dataSource
        
        
        dataSource.configureCell = { ds ,tv, ip , item in
            let cell:CarListCell = tv.dequeueReusableCell(withIdentifier: "Cell", for: ip) as! CarListCell
            if let name = item.name {
                cell.titlelbl.text = name
            }
            cell.desc.text = item.licensePlate
            cell.img?.sd_setImage(with: URL(string: item.carImageUrl), placeholderImage: UIImage(named: "default"))
            return cell
            
        }
        
        
        tableView.rx.itemSelected.subscribe(onNext: { [tableView] index in
            tableView?.deselectRow(at: index, animated: false)
            
            if let cordinate = self.carViewmodel.cordinate(at: index) {
                print(cordinate)
                self.mapService?.zoom(to: cordinate)
            }
            
        }).addDisposableTo(disposeBag)
        
        
    }
    
    
    func setupMap()  {
        //mapService = MapService(container: mapContainer, mapType: AppMaps())
        mapService = MapService(container: mapContainer, mapType: GoogMaps())
        mapService?.setupMap()
    }
    
    func plotmarkers()  {
        mapService?.plotmarkers(locations: self.carViewmodel.makers())
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let _ = dataSource?[indexPath],
            let _ = dataSource?[indexPath.section]
            else {
                return 0.0
        }
        
        return CGFloat(80)
    }
}



