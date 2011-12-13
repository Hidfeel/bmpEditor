package
{
	import bmpEdit.BmpManage;
	
	import com.bit101.components.PushButton;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import lorder.PicLoader;
	import lorder.pngOutput;
	
	public class bmpEditor extends Sprite
	{
		private var loder:PicLoader;
		private var output:pngOutput=new pngOutput();;
		
		private var readBtn:PushButton;
		private var writeBtn:PushButton;
		
		private var targetBmp:BmpManage=new BmpManage();
		public function bmpEditor()
		{
			stage.scaleMode=StageScaleMode.EXACT_FIT;
			initui();
//			write(create());
			
		}
		private function initui():void
		{
			this.addChild(targetBmp);
			targetBmp.y+=10
			readBtn=new PushButton(this,0,0,"打开",
				function f(e:Event):void{
					loder=new PicLoader();
					loder.addEventListener(PicLoader.LORDER_COMPLETE,function (e:Event):void{
//						targetBmp.add(loder.bit);
						targetBmp.addVec(loder.bmpVec);
						
					});
				}); 
			var text:TextField=new TextField();
			text.text="打开";
			readBtn.addChild(text);
			//			loder=new PicLoader();
			writeBtn=new PushButton(this,300,0,"保存到",function (e:Event):void{
				output.init(targetBmp.outPut());
				
			})	
			var text2:TextField=new TextField();
			text2.text="保存到";
			writeBtn.addChild(text2);
		}
//		private function create():SWF
//		{
//			var swf:SWF = new SWF(
//				new SWFHeader(SWFHeader.UNCOMPRESSED_SIGNATURE, 8, 0, new RectangleRecord(16, 0, 8000, 0/*, 8000*/), 24, 1),
//				Vector.<SWFTag>([
//					new FileAttributesTag(),
//					new SetBackgroundColorTag(new RGBRecord(255, 0, 0)),
//					new DefineShape4Tag(
//						1,new RectangleRecord( 431, 3410, 370, 2430),
//						new RectangleRecord(441, 3400, 380, 2420) /*new RectangleRecord(13, 431, 3410, 370, 2430),
//						new RectangleRecord(13, 441, 3400, 380, 2420)*/, 0,
//						false, false, false,
//						new ShapeWithStyleRecord(
//						/*	new FillStyleArrayRecord3(
//								3, 0,
//								Vector.<FillStyleRecord2>([
//									new FillStyleRecord2(0, new RGBARecord(255, 255, 255, 255)),
//									new FillStyleRecord2(0, new RGBARecord(255, 0, 0, 255)),
//									new FillStyleRecord2(0, new RGBARecord(0, 153, 51, 255))
//								])
//							),
//							new LineStyle2ArrayRecord(
//								1, 0,
//								Vector.<LineStyle2Record>([
//									new LineStyle2Record(20, 0, 0, false, false, false, false, 0, false, 0, NaN, new RGBARecord())
//								])
//							),
//							2, 1,
//							Vector.<IShapeRecord>([
//								new StyleChangeRecord4(false, true, true, false, true, 13, 3400, 2420, 0, 3, 1),
////								new StraightEdgeRecord(11, false, false, 5233, 0),
////								new StraightEdgeRecord(10, false, true, 0, 2056),
////								new StraightEdgeRecord(11, false, false, 2959, 0),
////								new StraightEdgeRecord(10, false, true, 0, 2040),
//								new StraightEdgeRecord( false, false, 5233, 0),
//								new StraightEdgeRecord( false, true, 0, 2056),
//								new StraightEdgeRecord( false, false, 2959, 0),
//								new StraightEdgeRecord( false, true, 0, 2040),
//								new EndShapeRecord()
//							])*/
//						)
//					),
//					new PlaceObject2Tag(
//						false, 1, 1, new MatrixRecord(null, null, new MatrixTranslateStructure())
//					),
//					new ShowFrameTag(),
//					new EndTag()
//				])
//			);
//			return swf;
//		}
//		public function write(swf:SWF):void
//		{
//			var swfWriter:SWF10Writer = new SWF10Writer();
//			var result:SWFWriteResult = swfWriter.write(swf);
//			writeBytes('output.swf', result.bytes);
//		}
		
		private function writeBytes(filename:String, bytes:ByteArray):void
		{
			var file:File = File.applicationStorageDirectory.resolvePath('output.swf');
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(bytes);
			fs.close();
		}
		
	}
}