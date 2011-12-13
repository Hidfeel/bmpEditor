package lorder
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.utils.*;
	

	public class pngOutput
	{
		private var targetDirc:File;
		public function pngOutput()
		{
		}
		
			
		public function init(bt:DisplayObject):void
		{
			try
			{
				var file:File = new File();
				file.addEventListener(Event.SELECT, function (e:Event):void{
					targetDirc=e.currentTarget as File;
					trace("pngOutput.enclosing_method(e) is dic",targetDirc,targetDirc.isDirectory);
					if(targetDirc.isDirectory)
					{
						outPut(bt);
					}
				});
				file.browseForDirectory("Save");
			} 
			catch(error:Error) 
			{
				trace("pngOutput.init(bt)",error);
				
			}
		
		}
		private  function outPut(bt:DisplayObject):void{
			var bmpd:BitmapData = new BitmapData(bt.width,bt.height,true,0x00);
			bmpd.draw(bt)
			//编码为JPEG格式：
//			var jpgenc:JPGEncoder = new JPGEncoder(80);
//			var imgByteArray:ByteArray = jpgenc.encode(bmpd);
			//编码为PNG格式：
			var pngenc:PNGEncoder = new PNGEncoder();
			var pngimgByteArray:ByteArray = PNGEncoder.encode(bmpd);
//			var fl:File = File.desktopDirectory.resolvePath("a.jpg");
			var pngfl:File = targetDirc.resolvePath("a.png");
			var fs:FileStream = new FileStream();
			try{
//				fs.open(fl,FileMode.WRITE);
//				fs.writeBytes(imgByteArray);
				fs.open(pngfl,FileMode.WRITE);
				fs.writeBytes(pngimgByteArray);
				fs.close();
			}catch(e:Error){
				trace(e.message);
			}
		}
	}
}