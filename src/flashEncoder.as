
import flash.display.*;
import flash.events.*;
import flash.filesystem.*;
import flash.media.*;
import flash.media.H264Level;
import flash.media.H264Profile;
import flash.media.H264VideoStreamSettings;
import flash.media.VideoCodec;
import flash.media.VideoStreamSettings;
import flash.net.*;
import flash.system.Security;
import flash.system.SecurityPanel;
import flash.system.System;
import flash.text.engine.FontWeight;
import flash.ui.*;
import flash.utils.ByteArray;
import flash.utils.Timer;

import flashx.textLayout.container.ContainerController;
import flashx.textLayout.conversion.*;
import flashx.textLayout.edit.EditManager;
import flashx.textLayout.elements.*;
import flashx.textLayout.events.FlowElementMouseEvent;
import flashx.textLayout.events.StatusChangeEvent;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.listClasses.ListItemRenderer;
import mx.core.FlexGlobals;
import mx.core.INavigatorContent;
import mx.events.*;
import mx.formatters.DateFormatter;
import mx.graphics.codec.JPEGEncoder;
import mx.managers.PopUpManager;
import mx.rpc.events.*;
import mx.rpc.http.HTTPService;
import mx.utils.Base64Encoder;
import flash.media.CameraUI;


private var sStatus : String = "";
private var mTimer : Timer = null;

private function InitSetting() : void {
	
}

public function printLog(msg: String) : void {
	idTextLog.text += msg;
	idTextLog.text += "\n";
}

public function fileSelected(event:Event):void 
{
	var url : String = event.target.url;
	idUrl.text = url;
	playVideo();
}

private function fileOpen() : void {
	var fileToOpen:File = new File();
	var txtFilter:FileFilter = new FileFilter("Movie", "*.mp4");
	try 
	{
		fileToOpen.browseForOpen("Open", [txtFilter]);
		fileToOpen.addEventListener(Event.SELECT, fileSelected);
	}
	catch (error:Error)
	{
		trace("Failed:", error.message);
	}
}


private function getJPEG(bmd:BitmapData):ByteArray {
	var jpg:JPEGEncoder = new JPEGEncoder();
	return jpg.encode(bmd);
}

public function saveCameraImage() : void {
	//create a BitmapData variable called picture that has theCam's size
	var picture:BitmapData = new BitmapData(vidPreview.width, vidPreview.height);
	
	//the BitmapData draws our theCam
	picture.draw(vidPreview);
	
	var file : File = File.documentsDirectory;
	file = file.resolvePath("ScreenShot/Record_" + new Date().time.toString() + ".jpg");
	
	var stream : FileStream = new FileStream;
	stream.open(file, FileMode.WRITE);
	
	var data:ByteArray = getJPEG(picture);
	
	stream.writeBytes(data, 0, data.length);
	
	stream.close();
	printLog("saved to " + file.nativePath);
}

public function modifyStatus(e:TimerEvent) : void {	
	saveCameraImage();
}

public function onStartCapture() : void {
	
	var strSendText : String = "";
	if(sStatus != "online") {
		mTimer= new Timer(10000);	// everytime 10s, change the status (online, offline)
		mTimer.addEventListener(TimerEvent.TIMER, modifyStatus);
		mTimer.start();
		
		BtnRecord.label = "Stop Capture";
		sStatus = "online";
		printLog("Start Capture is started.");
	}
	else
	{
		mTimer.stop();
		mTimer = null;
		
		BtnRecord.label = "Start Capture";
		sStatus = "";
		printLog("Start Capture is stopped.");
	}
}

var nc:NetConnection = null;
var ns:NetStream = null;

public function playVideo() : void {

	nc = new NetConnection(); 
	nc.connect(null); 
	
	ns = new NetStream(nc); 
	ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler); 
	ns.play(idUrl.text); 
	
	var vid:Video = new Video(); 
	vid.attachNetStream(ns); 
	vidPreview.addChild(vid); 
	
//	pauseBtn.addEventListener(MouseEvent.CLICK, pauseHandler); 
//	playBtn.addEventListener(MouseEvent.CLICK, playHandler); 
//	stopBtn.addEventListener(MouseEvent.CLICK, stopHandler); 
//	togglePauseBtn.addEventListener(MouseEvent.CLICK, togglePauseHandler); 
}

function asyncErrorHandler(event:AsyncErrorEvent):void 
{ 
	// ignore error 
} 

function pauseHandler(event:MouseEvent):void 
{ 
	ns.pause(); 
} 

function playHandler(event:MouseEvent):void 
{ 
	ns.resume(); 
} 

function stopHandler(event:MouseEvent):void 
{ 
	// Pause the stream and move the playhead back to 
	// the beginning of the stream. 
	ns.pause(); 
	ns.seek(0); 
}

function togglePauseHandler(event:MouseEvent):void 
{ 
	ns.togglePause(); 
}
