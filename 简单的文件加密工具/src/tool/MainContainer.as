package tool 
{
	import flash.display.Sprite;
	import fl.controls.Label;
	import fl.controls.TextInput;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.desktop.NativeDragManager;
	import flash.desktop.ClipboardFormats;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	
	import tool.encry.EncryHelper;
	import tool.encry.SimpleEncry;
	
	/**
	 * 工具的主容器, UI 放在此容器中
	 * @author Zhenyu Yao
	 */
	public class MainContainer extends Sprite 
	{
		
////////////////////////////////////////////////////////////////////////////////////////////////////
// public
////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function MainContainer() 
		{
			super();
			
			var x : Number = 6.18;
			
			// 输入加密使用的字符串
			var lblKey : Label = new Label();
			lblKey.text = "Key: ";
			lblKey.x = x;
			lblKey.y = 6.18;
			this.addChild(lblKey);
			
			var txtKey : TextInput = new TextInput();
			txtKey.text = FileConfig.sharedInstance().encryKey;
			txtKey.x = x + 30;
			txtKey.y = lblKey.y;
			this.addChild(txtKey);
			txtKey.addEventListener(Event.CHANGE, onTextKeyChangeHandler);
			
			// 输入加密后的文件后缀名
			var lblExt : Label = new Label();
			lblExt.x = x;
			lblExt.y = 31;
			lblExt.text = "Ext: ";
			this.addChild(lblExt);
			
			var txtExt : TextInput = new TextInput();
			txtExt.maxChars = 10;
			txtExt.restrict = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZCVBNM";
			txtExt.text = FileConfig.sharedInstance().encryFileExt;
			txtExt.x = x + 30;
			txtExt.y = lblExt.y;
			this.addChild(txtExt);
			txtExt.addEventListener(Event.CHANGE, onTextExtChangeHandler);
			
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnterHandler);
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, onDragExitHandler);
			this.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onDragDropHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////
// private
////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/// 侦听改变加密 Key 的事件
		private function onTextKeyChangeHandler(evt : Event) : void
		{
			var txtKey : TextInput = evt.target as TextInput;
			FileConfig.sharedInstance().encryKey = txtKey.text;
			trace(FileConfig.sharedInstance().encryKey);
		}
		
		/// 侦听改变后缀名的事件
		private function onTextExtChangeHandler(evt : Event) : void
		{
			var txtExt : TextInput = evt.target as TextInput;
			FileConfig.sharedInstance().encryFileExt = txtExt.text;
			trace(FileConfig.sharedInstance().encryFileExt);
		}

		/// 拖动操作进入窗口操作
		private function onDragEnterHandler(evt : NativeDragEvent) : void
		{
			NativeDragManager.acceptDragDrop(this);
		}
		
		/// 拖动操作退出窗口操作
		private function onDragExitHandler(evt : NativeDragEvent) : void
		{
			trace("离开窗口");
		}
		
		/// 拖动操作在窗口内释放拖动文件
		private function onDragDropHandler(evt : NativeDragEvent) : void
		{
			// 决定使用的密钥
			if (EncryHelper.sharedInstance().encry is SimpleEncry)
			{
				var encry : SimpleEncry = EncryHelper.sharedInstance().encry as SimpleEncry;
				encry.encryKey = FileConfig.sharedInstance().encryKey;
			}
			
			var ext : String = FileConfig.sharedInstance().encryFileExt;
			
			// 对每个文件进行加密, 加密后的文件输出到相同路径
			var files : Array = evt.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each (var file : File in files)
			{
				var nativePath : String = file.nativePath;
				var encryPath : String = nativePath.substring(0, nativePath.lastIndexOf(".")) + "." + ext;
				EncryHelper.sharedInstance().fileToFile(nativePath, encryPath);
			}
		}
		
		/// 进入场景事件
		private function onAddedToStageHandler(evt : Event) : void
		{
			this.graphics.beginFill(0, 0);
			this.graphics.drawRect(0, 0, this.stage.nativeWindow.width, this.stage.nativeWindow.height);
			this.graphics.endFill();
		}
		
	}

}










































////////////////////////////////////////////////////////////////////////////////////////////////////
// end file


