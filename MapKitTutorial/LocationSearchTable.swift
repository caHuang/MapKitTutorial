//
//  LocationSearchTable.swift
//  MapKitTutorial
//
//  Created by Andy Huang on 12/07/2017.
//  Copyright © 2017 Andy Huang. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
  
  var matchingItems: [MKMapItem] = []
  var mapView: MKMapView? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
 
}

extension LocationSearchTable {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return matchingItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let selectedItem = matchingItems[indexPath.row].placemark
    
    cell.textLabel?.text = selectedItem.name
    cell.detailTextLabel?.text = ""
    
    return cell
  }
  
}

extension LocationSearchTable: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let mapView = mapView else { return }
    guard let searchBarText = searchController.searchBar.text else { return }
    
    let request = MKLocalSearchRequest()
    request.naturalLanguageQuery = searchBarText
    request.region = mapView.region
    
    let search = MKLocalSearch(request: request)
    search.start { response, _ in
      guard let response = response else { return }
      self.matchingItems = response.mapItems
      self.tableView.reloadData()
    }
  }

}
