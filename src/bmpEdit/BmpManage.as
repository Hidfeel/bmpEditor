package bmpEdit
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class BmpManage extends Sprite
	{
		private var bmpVec:Vector.<Bitmap>=new Vector.<Bitmap>;
		public function BmpManage()
		{
			super();
		}
		public function addVec(vec:Vector.<Bitmap>):void
		{
			if(vec&&vec.length)
			bmpVec=vec;
			trace("BmpManage.addVec(vec)",bmpVec.length);
			refresh();
			
		}
		public function add(bt:Bitmap):void
		{
			bmpVec.push(bt);
			this.addChild(bt);
			refresh();
		}
		public  function outPut():Bitmap
		{
			var bmpdata:BitmapData=getmaxbimpdata();
			return new Bitmap(bmpdata);
		}
		private function refresh():void
		{
			for (var i:int = 0; i < bmpVec.length; i++) 
			{
				var bmp:Bitmap=bmpVec[i];
				if(i>0)
				{
					trace("BmpManage.refresh()",bmpVec[i-1].x,bmpVec[i-1].width);
					
					bmp.x=bmpVec[i-1].x+bmpVec[i-1].width;
					bmp.y=0;
				}
				else
				{
					bmp.x=0;
					bmp.y=0;
				}
				if(!bmp.parent)
				{
					this.addChild(bmp);
				}
			}
		}
		private function getmaxbimpdata():BitmapData
		{
			var maxw:Number=0;
			var maxY:Number=0;
			var tempx:Number,tempY:Number;
			for each (var dsp:DisplayObject in bmpVec) 
			{
				with(dsp)
				{
					trace("BmpManage.getmaxbimpdata()",x,y);
					
					maxw=(x+width>maxw)?(x+width):maxw;
					maxY=(y+height>maxY)?(y+height):maxY;
				}
			}
			if(maxw>8000&&maxY>8000)
				throw new Error("图片太大了")
			var btmp:BitmapData=new BitmapData(maxw,maxY,true,0x00);
			for each (var bm:Bitmap in bmpVec) 
			{
				trace("BmpManage.getmaxbimpdata()",bm,bm.x,bm.y,bm.getRect(bm));
				btmp.copyPixels(bm.bitmapData,bm.getRect(bm),new Point(bm.x,bm.y),null,null,true)
			}
			return btmp;
		}
	}
}