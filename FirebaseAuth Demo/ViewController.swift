//
//  ViewController.swift
//  FirebaseAuth Demo
//
//  Created by Pablo Pasqualino on 5/28/16.
//  Copyright © 2016 Cooliopas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class ViewController: UIViewController {

	let usuarioImagenPlaceholder: UIImage = UIImage(named: "usuarioPlaceholder")!
	let usuarioLogueadoView: SwiftyGradient = SwiftyGradient()
	let usuarioImagen: UIImageView = UIImageView()
	let usuarioNombreLabel: UILabel = UILabel()
	let bienvenidaLabel: UILabel = UILabel()
	let iniciarSesionButton: UIButton = UIButton()
	let cerrarSesionButton: UIButton = UIButton()

	var usuario: FIRUser?

	override func viewDidLoad() {
		super.viewDidLoad()

		prepararViews()

		FIRAuth.auth()?.addAuthStateDidChangeListener {

			(_, user) in

			if user != nil {

				self.usuario = user
				self.logueado()

			} else {

				self.deslogueado()

			}

		}

	}

	func prepararViews() {

		// preparo usuarioLogueadoView con SwiftyGradient

		usuarioLogueadoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
		usuarioLogueadoView.startColor = UIColor(red:25/255, green:142/255, blue:255/255, alpha:1)
		usuarioLogueadoView.endColor = UIColor(red:0/255, green:51/255, blue:208/255, alpha:1)
		usuarioLogueadoView.alpha = 0
		self.view.addSubview(usuarioLogueadoView)

		// preparo usuarioImagen

		usuarioImagen.frame = CGRect(x: ((self.view.frame.width - 120) / 2), y: 60, width: 120, height: 120)
		usuarioImagen.image = usuarioImagenPlaceholder
		usuarioImagen.layer.cornerRadius = 60
		usuarioLogueadoView.addSubview(usuarioImagen)

		// preparo usuarioNombreLabel

		usuarioNombreLabel.frame = CGRect(x: 0, y: 190, width: self.view.frame.width, height: 30)
		usuarioNombreLabel.textAlignment = NSTextAlignment.Center
		usuarioNombreLabel.textColor = UIColor.whiteColor()
		usuarioNombreLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
		usuarioLogueadoView.addSubview(usuarioNombreLabel)

		// preparo cerrarSesionButton

		cerrarSesionButton.setTitle("Cerrar Sesión", forState: UIControlState.Normal)
		cerrarSesionButton.addTarget(self, action: #selector(ViewController.cerrarSesion), forControlEvents: UIControlEvents.TouchUpInside)
		cerrarSesionButton.sizeToFit()
		cerrarSesionButton.frame.origin.x = self.view.frame.width - cerrarSesionButton.frame.size.width - 16
		cerrarSesionButton.frame.origin.y = 20
		usuarioLogueadoView.addSubview(cerrarSesionButton)

		// preparo bienvenidaLabel

		bienvenidaLabel.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 60)
		bienvenidaLabel.textAlignment = NSTextAlignment.Center
		bienvenidaLabel.textColor = UIColor.blackColor()
		bienvenidaLabel.font = UIFont.systemFontOfSize(25)
		bienvenidaLabel.numberOfLines = 2
		bienvenidaLabel.text = "Bienvenido a\nFirebaseAuth Demo"
		bienvenidaLabel.alpha = 0
		self.view.addSubview(bienvenidaLabel)

		// preparo iniciarSesionButton

		iniciarSesionButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
		iniciarSesionButton.setTitle("Iniciar Sesión", forState: UIControlState.Normal)
		iniciarSesionButton.addTarget(self, action: #selector(ViewController.iniciarSesion), forControlEvents: UIControlEvents.TouchUpInside)
		iniciarSesionButton.sizeToFit()
		iniciarSesionButton.frame.origin.x = (self.view.frame.width - iniciarSesionButton.frame.width) / 2
		iniciarSesionButton.frame.origin.y = 200
		iniciarSesionButton.alpha = 0
		self.view.addSubview(iniciarSesionButton)

	}

	func logueado() {

		usuarioLogueadoView.alpha = 1
		bienvenidaLabel.alpha = 0
		iniciarSesionButton.alpha = 0

		usuarioNombreLabel.text = usuario!.displayName

	}

	func deslogueado() {

		usuarioLogueadoView.alpha = 0
		bienvenidaLabel.alpha = 1
		iniciarSesionButton.alpha = 1

	}

	func iniciarSesion() {

		let authViewController = FIRAuthUI.authUI()!.authViewController()

		self.presentViewController(authViewController, animated: true, completion: nil)
		
	}

	func cerrarSesion() {

		try! FIRAuth.auth()!.signOut()

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}