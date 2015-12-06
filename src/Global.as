package
{
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.*;
	
	public class Global extends Object {
		public function Global() {
			super();			
		}
		
//		public static var connection : String = "rtmp://cloud.eswebcast.com:1935/android";
		public static var connection : String = "rtmp://192.168.1.110:1935/cocotving";
		public static var stream : String = "estv";
		
		[Bindable]
		public static var aryMic : ArrayCollection = new ArrayCollection();
		[Bindable]
		public static var MicIndex : int = 0;
		
		[Bindable]
		public static var aryWebCam : ArrayCollection = new ArrayCollection();
		[Bindable]
		public static var WebCamIndex : int = 0;
		
		public static const CameraWidth : Array = [320, 480, 640, 800];
		public static const CameraHeight : Array = [240, 360, 480, 640];
		[Bindable]
		public static var CameraQuality : int = 90;
		
		[Bindable]
		public static var CameraFPS : int = 6;		
		public static var langindex : int = 0;
		
		public static var MicEncodeQuality : int = 9;
		
		public static var nMicVolumn : int = 50;

		[Bindable]
		public static var bitRateIndex : int = 1;
		public static const aryBitRate : ArrayCollection = new ArrayCollection([
			"100kbps", "200kbps", "350kbps", "500kbps", "650kbps", 
			"800kbps", "950kbps", "1000kbps", "1200kbps", "1800kbps", 
			"2000kbps", "2500kbps"]);
		public static const aryBitRateNumber : ArrayCollection = new ArrayCollection([
			"12800", "25600", "44800", "64000", "83200", 
			"102400", "121600", "128000", "153600", "230400", 
			"256000", "320000"]);
		public static const aryChannel : ArrayCollection = new ArrayCollection([ "Stereo", "Mono"]);
		[Bindable]
		public static var audioSampleRateIndex : int = 1;
		public static const arySampleRate : ArrayCollection = new ArrayCollection([ "44100", "22050", "11025"]);
		public static const arySampleRateNumber : ArrayCollection = new ArrayCollection([ 44, 22, 11]);
		public static const aryFPS : ArrayCollection = new ArrayCollection([60, 59, 30, 29, 26, 25, 24, 20, 15, 14, 12, 10, 8, 6, 5, 4, 1]);
		public static const aryVideoFormat : ArrayCollection = new ArrayCollection(["H.264", "FLV"]);
		[Bindable]
		public static var videoFormatIndex : int = 0;
		public static const aryAudioFormat : ArrayCollection = new ArrayCollection(["Speex", "NellyMoser"]);
		[Bindable]
		public static var audioFormatIndex : int = 0;
		[Bindable]
		public static var resolutionIndex : uint = 0;
		[Bindable]
		public static var qualityIndex : uint = 0;		

		
	}

}