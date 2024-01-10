//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by Mac on 05/01/24.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    
    var gmsCameraPosition : GMSCameraPosition?
    var delhiPosition : CLLocationCoordinate2D?
    var bitcodeMarker : GMSMarker?
    var delhiMarker : GMSMarker?
    var gmsCircle : GMSCircle?
    var radiusOfCircle : CLLocationDistance?
    var gmspolygon : GMSPolygon?
    var gmspolyline : GMSPolyline?
    var gmsMutablePathForPologon : GMSMutablePath?
    var gmsMutablePathForPolyline : GMSMutablePath?
    
//       var bitcodeMarker : GMSMarker? = GMSMarker(
//            position: CLLocationCoordinate2D(latitude: 18.5091, longitude: 73.8326))
    override func viewDidLoad() {
        super.viewDidLoad()
       bitcodeMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 18.5091, longitude: 73.8326))
        delhiPosition = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
        delhiMarker = GMSMarker(position: delhiPosition!)
        initializeSettingsForGoogleMaps()
        initializeMarker(marker: delhiMarker!)
        initializeMarker(marker: bitcodeMarker!)
        settingCameraPostion(position: bitcodeMarker!.position)
        drawCircleOnMap(position: bitcodeMarker!.position, radius: 20.0)
        drawPolygonOnMap()
        drawPolylineOnMap()
    }
    
    func initializeMarker(marker : GMSMarker)
    {
        marker.snippet = "Bitcode Tech"
        marker.rotation = 360.0
        marker.opacity = 1
        marker.isDraggable = true
        marker.title = "Bitcode"
        marker.zIndex = 5
        marker.map = googleMapView
    }
    func settingCameraPostion(position : CLLocationCoordinate2D)
    {
        gmsCameraPosition = GMSCameraPosition(target: position, zoom: 5.0)
        googleMapView.camera = gmsCameraPosition!
    }
    func initializeSettingsForGoogleMaps(){
        googleMapView.settings.myLocationButton = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = true
        googleMapView.settings.rotateGestures = true
        googleMapView.settings.scrollGestures = true
        googleMapView.settings.tiltGestures = true
        googleMapView.settings.rotateGestures = true
        googleMapView.isBuildingsEnabled = true
        googleMapView.isTrafficEnabled = true
        googleMapView.isMyLocationEnabled = true
        googleMapView.mapType = .normal
    }


    func drawCircleOnMap(position :  CLLocationCoordinate2D, radius : CLLocationDistance)
    {
        gmsCircle = GMSCircle(position: position  , radius: radius)
        gmsCircle?.zIndex = 5
        gmsCircle?.title = "Bitcode Tech"
        gmsCircle?.fillColor = .lightGray
        gmsCircle?.strokeColor = .blue
        gmsCircle?.strokeWidth = 5.0
        gmsCircle?.map = googleMapView
        
        
    }
    func drawPolygonOnMap()
    {
        gmsMutablePathForPologon = GMSMutablePath()
        gmsMutablePathForPologon?.add(CLLocationCoordinate2D(latitude: 19.9975, longitude: 73.7898))
        gmsMutablePathForPologon?.add(CLLocationCoordinate2D(latitude: 19.8762, longitude: 75.3433))
        gmsMutablePathForPologon?.add(CLLocationCoordinate2D(latitude: 17.6599, longitude: 75.9064))
        gmsMutablePathForPologon?.add(CLLocationCoordinate2D(latitude: 18.5202, longitude: 73.8567))
        
        gmspolygon = GMSPolygon(path: gmsMutablePathForPologon)
        gmspolygon?.strokeWidth = 10.0
        gmspolygon?.strokeColor = .blue
        gmspolygon?.fillColor = .brown
        gmspolygon?.title = "Maharashtra Cities"
        gmspolygon?.zIndex = 5
        gmspolygon?.map = googleMapView
    }
    func drawPolylineOnMap()
    {
        gmsMutablePathForPolyline = GMSMutablePath()
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 21.1458, longitude: 79.0882))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 19.9615, longitude: 79.2961))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 19.6766, longitude: 78.5321))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307))
        
        gmspolyline = GMSPolyline(path: gmsMutablePathForPolyline)
        gmspolyline?.strokeColor = .blue
        gmspolyline?.strokeWidth = 20.0
        gmspolyline?.title = "Cities"
        gmspolyline?.zIndex = 10
        gmspolyline?.map = googleMapView
        
    }
     

}
extension ViewController : GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindowRect = CGRect(x: 0, y: 0, width: 400, height: 200)
        var infoWindowView = UIView(frame: infoWindowRect)
        infoWindowView.backgroundColor = .cyan
        
        let labelOneRect = CGRect(x: 40, y: 40, width: infoWindowView.frame.width - 60, height: 40)
        
        var labelOne = UILabel(frame: labelOneRect)
        labelOne.text = "Welcome"
        labelOne.backgroundColor = .blue
        labelOne.textColor = .black
        
        let labelTwoRect = CGRect(x: 40, y: 120, width: labelOneRect.width, height: 40)
        var labelTwo = UILabel(frame: labelTwoRect)
        labelTwo.text = "Bitcode"
        labelTwo.backgroundColor = .cyan
        labelTwo.textColor = .black
        infoWindowView.addSubview(labelOne)
        infoWindowView.addSubview(labelTwo)
        
        return infoWindowView
        
    }
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print(marker.position)
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print(marker.position)
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print(marker.position)
    }
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print("long Press \(coordinate.latitude) -- \(coordinate.longitude)")
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("did Tap At \(coordinate.latitude) -- \(coordinate.longitude)")
    }
    
    
}

