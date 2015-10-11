//
//  ViewController.swift
//  FastFashion
//
//  Created by Nicholas Cai on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet weak var cameraView: UIView!

    let picker = UIImagePickerController()
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        var img:UIImage? = imageView.image
        
        var imgStore = ImageStore()
        
        
        imgStore?.uploadImage(img!)
        
        //myImageUploadRequest();
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .ScaleAspectFit //3
        imageView.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
            completion: nil)
    }
    
    @IBAction func chooseImage(sender: UIBarButtonItem) {
    
            picker.allowsEditing = false
            picker.sourceType = .PhotoLibrary
            picker.modalPresentationStyle = .Popover
            presentViewController(picker,
                animated: true,
                completion: nil)
            picker.popoverPresentationController?.barButtonItem = sender
            }

    
    @IBAction func takePicture() {
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            let alert = UIAlertController(title: "Error", message: "Camera is not available on this device", preferredStyle: UIAlertControllerStyle.Alert)

            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            

            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
            
        }
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
//        imageView?.frame = imageView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
//        var input = 1
        do {
            var input = try AVCaptureDeviceInput(device: backCamera)
            if (error == nil && captureSession?.canAddInput(input) != nil) {
                captureSession?.addInput(input)
                stillImageOutput = AVCaptureStillImageOutput()
                stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                if (captureSession?.canAddOutput(stillImageOutput) != nil){
                    captureSession?.addOutput(stillImageOutput)
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                    cameraView.layer.addSublayer(previewLayer!)
                    captureSession?.startRunning()
                }
            }

        } catch {
            
        }
        
    }
    
    func didPressTakePhoto() {
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                    (sampleBuffer, error) in
                
                    if sampleBuffer != nil {
                        var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                        var dataProvider = CGDataProviderCreateWithCFData(imageData)
                        var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, .RenderingIntentDefault)
                        
                        var image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                        
                        self.imageView.image = image
                        self.imageView.hidden = false
//                        self.cameraView.hidden = true
        
                    }
                })
            
        }
        
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother() {
        if didTakePhoto == true {
//            self.cameraView.hidden = false
            imageView.hidden = true
            didTakePhoto = false
        } else {
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
            
        }
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        didPressTakeAnother()
    }
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

