//
//  ArKitViewController.swift
//  orderFood
//
//  Created by Anil Kumar on 28/08/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit
import ARKit


class ArKitViewController: UIViewController {

  
  let kStartingPosition = SCNVector3(0, 0, -0.6)
  let kAnimationDurationMoving: TimeInterval = 0.2
  let kMovingLengthPerLoop: CGFloat = 0.05
  let kRotationRadianPerLoop: CGFloat = 0.2
  
  var sceneView = ARSCNView(frame: UIScreen.main.bounds)
  var drone = Drone()
  
  let backButton = UIButtonFactory(title: "")
    .setBackgroundImage(image: "BackBtn")
    .addTarget(self, action: #selector(backCliked), for: .touchUpInside)
    .setTintColor(color: UIColor.white)
    .build()
  
  let leftView = UIViewFactory()
  .build()
  
  let rightView = UIViewFactory()
    .build()
  
  let image1 = UIImageFactory()
    .setImage(imageString: "arrow_down")
  .build()
  
  let image2 = UIImageFactory()
    .setImage(imageString: "arrow_left")
    .build()
  
  let image3 = UIImageFactory()
    .setImage(imageString: "arrow_right")
    .build()
  
  let image4 = UIImageFactory()
    .setImage(imageString: "arrow_up")
    .build()
  
  
  let image11 = UIImageFactory()
    .setImage(imageString: "arrow_down")
    .build()
  
  let image21 = UIImageFactory()
    .setImage(imageString: "arrow_left")
    .build()
  
  let image31 = UIImageFactory()
    .setImage(imageString: "arrow_right")
    .build()
  
  let image41 = UIImageFactory()
    .setImage(imageString: "arrow_up")
    .build()
  
  
  var stackview = UIStackView()
  var stackview1 = UIStackView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.navigationBar.isHidden = true
      //add it to parents subview
  
      leftView.translatesAutoresizingMaskIntoConstraints = false
      sceneView.addSubview(leftView)
      
      rightView.translatesAutoresizingMaskIntoConstraints = false
      sceneView.addSubview(rightView)
      
      let arry = [image1,image2, image3 ,image4]
      stackview = UIStackViewFactory(buttons: arry)
      .build()
      
      let arry1 = [image41, image31, image21, image11 ]
      stackview1 = UIStackViewFactory(buttons: arry1)
        .build()
      stackview1.translatesAutoresizingMaskIntoConstraints = false
      stackview.translatesAutoresizingMaskIntoConstraints = false
      sceneView.translatesAutoresizingMaskIntoConstraints = false//
      view.addSubview(sceneView)
      
      leftView.addSubview(stackview)
      sceneView.bringSubviewToFront(leftView)
      
      rightView.addSubview(stackview1)
      sceneView.bringSubviewToFront(rightView)
      
      backButton.translatesAutoresizingMaskIntoConstraints = false
      sceneView.addSubview(backButton)
      sceneView.bringSubviewToFront(backButton)
      self.view.addSubview(sceneView)
      
      backButton.layoutAnchor(top: sceneView.topAnchor, left: sceneView.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 60, paddingLeft: 10, paddingBottom: 0.0, paddingRight: 0.0, width: 60, height: 60, enableInsets: true)
      
      stackview1.layoutAnchor(top: rightView.topAnchor, left: rightView.leftAnchor, bottom: rightView.bottomAnchor, right: rightView.rightAnchor, centerX: rightView.centerXAnchor, centerY: leftView.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
      
      rightView.layoutAnchor(top: nil, left: nil, bottom: sceneView.bottomAnchor, right: sceneView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 50, width: sceneView.frame.width/2-100, height: sceneView.frame.height/3-50, enableInsets: true)
      
      stackview.layoutAnchor(top: leftView.topAnchor, left: leftView.leftAnchor, bottom: leftView.bottomAnchor, right: leftView.rightAnchor, centerX: leftView.centerXAnchor, centerY: leftView.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
      
      leftView.layoutAnchor(top: nil, left: sceneView.leftAnchor, bottom: sceneView.bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 50, paddingBottom: 10, paddingRight: 0, width: sceneView.frame.width/2-100, height: sceneView.frame.height/3-50, enableInsets: true)
      
      sceneView.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
      
      setupScene()
      tapGuest()
    }
  
  @objc func backCliked(){
    self.navigationController?.popViewController(animated: true)
  }
  func tapGuest(){
    let t1 = UILongPressGestureRecognizer(target: self, action: #selector(upLongPressed))
    image1.addGestureRecognizer(t1)
    
    let t2 = UILongPressGestureRecognizer(target: self, action: #selector(downLongPressed))
    image2.addGestureRecognizer(t2)
    
    let t3 = UILongPressGestureRecognizer(target: self, action: #selector(downLongPressed))
    image3.addGestureRecognizer(t3)
    
    let t4 = UILongPressGestureRecognizer(target: self, action: #selector(moveLeftLongPressed))
    image4.addGestureRecognizer(t4)
    
    
    let t5 = UILongPressGestureRecognizer(target: self, action: #selector(moveRightLongPressed))
    image11.addGestureRecognizer(t5)
    
    let t6 = UILongPressGestureRecognizer(target: self, action: #selector(moveForwardLongPressed))
    image21.addGestureRecognizer(t6)
    
    let t7 = UILongPressGestureRecognizer(target: self, action: #selector(rotateLeftLongPressed))
    image31.addGestureRecognizer(t7)
    
    let t8 = UILongPressGestureRecognizer(target: self, action: #selector(rotateRightLongPressed))
    image41.addGestureRecognizer(t8)
    
    
  }
  
  @objc func upLongPressed(_ sender: UILongPressGestureRecognizer) {
    let action = SCNAction.moveBy(x: 0, y: kMovingLengthPerLoop, z: 0, duration: kAnimationDurationMoving)
    execute(action: action, sender: sender)
  }
  
  @objc func downLongPressed(_ sender: UILongPressGestureRecognizer) {
    let action = SCNAction.moveBy(x: 0, y: -kMovingLengthPerLoop, z: 0, duration: kAnimationDurationMoving)
    execute(action: action, sender: sender)
  }
    
  @objc func moveLeftLongPressed(_ sender: UILongPressGestureRecognizer) {
    let x = -deltas().cos
    let z = deltas().sin
    moveDrone(x: x, z: z, sender: sender)
  }

  @objc func moveRightLongPressed(_ sender: UILongPressGestureRecognizer) {
    let x = deltas().cos
    let z = -deltas().sin
    moveDrone(x: x, z: z, sender: sender)
  }
  
  
  @objc func moveForwardLongPressed(_ sender: UILongPressGestureRecognizer) {
    let x = -deltas().sin
    let z = -deltas().cos
    moveDrone(x: x, z: z, sender: sender)
  }
  
  @objc func moveBackLongPressed(_ sender: UILongPressGestureRecognizer) {
    let x = deltas().sin
    let z = deltas().cos
    moveDrone(x: x, z: z, sender: sender)
  }
  
  @objc func rotateLeftLongPressed(_ sender: UILongPressGestureRecognizer) {
    rotateDrone(yRadian: kRotationRadianPerLoop, sender: sender)
  }
  
  @objc func rotateRightLongPressed(_ sender: UILongPressGestureRecognizer) {
    rotateDrone(yRadian: -kRotationRadianPerLoop, sender: sender)
  }

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupConfiguration()
    addDrone()
  }
  
  
    
  func setupScene() {
    let scene = SCNScene()
    sceneView.scene = scene
  }
  func addDrone() {
    drone.loadModel()
    drone.position = kStartingPosition
    drone.rotation = SCNVector4Zero
    sceneView.scene.rootNode.addChildNode(drone)
  }
  
  func setupConfiguration() {
    let configuration = ARWorldTrackingConfiguration()
    sceneView.session.run(configuration)
  }

  // MARK: - private
  private func rotateDrone(yRadian: CGFloat, sender: UILongPressGestureRecognizer) {
    let action = SCNAction.rotateBy(x: 0, y: yRadian, z: 0, duration: kAnimationDurationMoving)
    execute(action: action, sender: sender)
  }
  
  private func moveDrone(x: CGFloat, z: CGFloat, sender: UILongPressGestureRecognizer) {
    let action = SCNAction.moveBy(x: x, y: 0, z: z, duration: kAnimationDurationMoving)
    execute(action: action, sender: sender)
  }
  
  private func execute(action: SCNAction, sender: UILongPressGestureRecognizer) {
    let loopAction = SCNAction.repeatForever(action)
    if sender.state == .began {
      drone.runAction(loopAction)
    } else if sender.state == .ended {
      drone.removeAllActions()
    }
  }
  
  private func deltas() -> (sin: CGFloat, cos: CGFloat) {
    return (sin: kMovingLengthPerLoop * CGFloat(sin(drone.eulerAngles.y)), cos: kMovingLengthPerLoop * CGFloat(cos(drone.eulerAngles.y)))
  }

}


class Drone: SCNNode {
  func loadModel() {
    guard let virtualObjectScene = SCNScene(named: "ChocolateCake.scn") else { return }
    let wrapperNode = SCNNode()
    for child in virtualObjectScene.rootNode.childNodes {
      wrapperNode.addChildNode(child)
    }
    addChildNode(wrapperNode)
  }
}
