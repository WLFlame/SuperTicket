//
//  ChoseLocationViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/16.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ChoseLocationViewController: UIViewController {
    
    var locationManager: CLLocationManager = CLLocationManager()
    lazy var geoCoder: CLGeocoder = CLGeocoder()
    var activity: Activity!
    var mapView: MKMapView!
    var didChangeLocation: ((locationname: String) -> Void)!
    
    var userLocation: CLLocation? {
        didSet{
            geoCoder.reverseGeocodeLocation(userLocation!) {[weak self] (placeMarks, error) in
                guard let placeMark = placeMarks?.first else { return }
                if self == nil {
                    return
                }
                WLAlert.confirmOrCancel(title: "提示", message: "是否使用\(placeMark.name!)作为签到地点", confirmTitle: "确定", cancelTitle: "取消", inViewController: self!, withConfirmAction: {
                    let signInLoc = SignInLocation()
                    signInLoc.latitude = placeMark.location!.coordinate.latitude
                    signInLoc.longtitude = placeMark.location!.coordinate.longitude
                    signInLoc.name = placeMark.name
                    signInLoc.activityId = self?.activity.activityId
                    self?.showHud()
                    signInLoc.saveInBackgroundWithBlock({ (succeed, error) in
                        self?.hideHud()
                        if succeed {
                            self?.activity.signInLocation = signInLoc
                        }
                    })
                    
                    if self?.didChangeLocation != nil {
                        self?.didChangeLocation(locationname: placeMark.name!)
                    }
                    self?.navigationController?.popViewControllerAnimated(true)
                    }, cancelAction: { 
                        WLAlert.textInput(title: "提示", message: "手动输入签到地点", placeholder: "活动地点", oldText: "", confirmTitle: "确定", cancelTitle: "取消", inViewController: self!, withConfirmAction: { (text) in
                                self?.geoCoder.geocodeAddressString(text, completionHandler: { (placeMark, error) in
                                    guard let placeMark = placeMarks?.first else { return }
                                    let signInLoc = SignInLocation()
                                    signInLoc.latitude = placeMark.location!.coordinate.latitude
                                    signInLoc.longtitude = placeMark.location!.coordinate.longitude
                                    signInLoc.name = placeMark.name
                                    signInLoc.activityId = self?.activity.activityId
                                    self?.showHud()
                                    signInLoc.saveInBackgroundWithBlock({ (succeed, error) in
                                        self?.hideHud()
                                        if succeed {
                                            self?.activity.signInLocation = signInLoc
                                        }
                                    })

                                    self?.activity.gpsEnable = true
                                    if self?.didChangeLocation != nil {
                                        self?.didChangeLocation(locationname: placeMark.name!)
                                    }
                                    self?.navigationController?.popViewControllerAnimated(true)
                                })
                            }, cancelAction: { 
                                self!.navigationController?.popViewControllerAnimated(true)
                        })
                })
               
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestLocation()
    }
    
    private func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            print(CLLocationManager.authorizationStatus().rawValue)
            if CLLocationManager.authorizationStatus() != .AuthorizedAlways || CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
                locationManager.requestWhenInUseAuthorization()
                locationManager.delegate = self
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    private func configureUI() {
        title = "确定签到区域"
        mapView = MKMapView()
        mapView.frame = view.bounds
        mapView.showsUserLocation = true
        if #available(iOS 9.0, *) {
            mapView.showsScale = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
        } else {
            // Fallback on earlier versions
        }
        mapView.showsBuildings = true
        if #available(iOS 9.0, *) {
            mapView.showsTraffic = true
        } else {
            // Fallback on earlier versions
        }
        mapView.showsPointsOfInterest = true
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
}

extension ChoseLocationViewController :CLLocationManagerDelegate
{
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}

extension ChoseLocationViewController : MKMapViewDelegate
{
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        debugPrint(userLocation)
        if let coordinate = userLocation.location?.coordinate {
             mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: false)
            self.userLocation = userLocation.location!
            locationManager.stopUpdatingLocation()
        }
       
    }
    
//    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: false)
//    }
}



