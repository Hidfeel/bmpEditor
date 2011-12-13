package lorder
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;

	public class PicLoader extends EventDispatcher
	{
		public static const LORDER_COMPLETE:String="lorder complete";
		public static const LORDER_COM_ONCE:String="lorder once complete";
		public var bit:Bitmap = new Bitmap();
		private var bits:Vector.<Bitmap>=new Vector.<Bitmap>;
		public function PicLoader()
		{
			init();
		}
		public function get bmpVec():Vector.<Bitmap>
		{
			return bits.concat();
		}
		
		private function init():void{
//			this.rawChildren.addChild(bit);
			
			//读取本地图像文件
			var file:File = new File();
			var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			file.addEventListener(FileListEvent.SELECT_MULTIPLE, this.onSelect );
			file.browseForOpenMultiple( "Open", [ imageTypes ] );
			
		}
		private var files:Array
		private function onSelect(e:FileListEvent):void
		{
			//e.target.name 文件名称
			//e.target.nativePath 文件路径
			
			//获得读取图像文件的二进制数据
//			trace ( "Selected files from: " + file.url + "\n" );
			files = e.files;
//			for (var j:int = 0; j < files.length; j++) 
//			{
//				bits.push(null);
//			}
			loadQueue(files);
//			
			
		}
		private function loadQueue(files:Array):void
		{
//			addEventListener(PicLoader.LORDER_COM_ONCE,loaderCounter);
			//			for ( var i:int = 0; i < files.length; i++ ) {
			trace ( ( files[0] as File ).name + "\n" );
			var fileByte:ByteArray = new ByteArray();
			var fs:FileStream = new FileStream(); 
			fs.open(files.shift(),FileMode.READ); 
			var loader:Loader = new Loader();
			fs.readBytes(fileByte, 0, fs.bytesAvailable);
			fs.close(); 
			//使用Loader 对象将图像文件二进制数据加载进来（可加载SWF、GIF、JPEG 或 PNG 格式的文件）
			//使用Loader 是方便通过loader.contentLoaderInfo获得Bitmap对象
			loader.unload();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaded);
			loader.loadBytes(fileByte);
			//			}
			
			function loaded(event:Event):void{
				var _bmp:Bitmap=new Bitmap((event.currentTarget.content as Bitmap).bitmapData)
				//					bit.bitmapData = Bitmap(event.currentTarget.content).bitmapData;
				//					bits[i]=_bmp
				bits.push(_bmp);
//				dispatchEvent(new Event(PicLoader.LORDER_COM_ONCE));
				if(!files.length)
				{
					dispatchEvent(new Event(PicLoader.LORDER_COMPLETE));
				}
				else
				{
					loadQueue(files);
				}
			}
		}
		private 	var count:int=0;
		private function loaded2(event:Event):void{
			var _bmp:Bitmap=new Bitmap((event.currentTarget.content as Bitmap).bitmapData)
			//					bit.bitmapData = Bitmap(event.currentTarget.content).bitmapData;
			//					bits[i]=_bmp
			bits.push(_bmp);
			if(bits.length>=2)
			trace("PicLoader.loaded(event)",bits[bits.length-1]==bits[bits.length-2]);
			dispatchEvent(new Event(PicLoader.LORDER_COM_ONCE));
		}
		private function loaderCounter(e:Event):void
		{
			//				var t:int=int(e.type.charAt(e.type.length-1));
			count++;
			//				trace("PicLoader.loaderCounter(e)",t);
			
			if(count>=files.length)
			{
				trace("PicLoader.loaderCounter(e)",count);
				dispatchEvent(new Event(PicLoader.LORDER_COMPLETE));
			}
		}
		
		
//		private function image_completeHandler(event:Event):void{
//			bit.bitmapData = Bitmap(event.currentTarget.content).bitmapData;
//			bit.dispatchEvent(new Event(PicLoader.LORDER_COMPLETE));
//		}
	}
}