package 
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import tool.encry.SimpleEncry;
	import tool.MainContainer;
	import tool.encry.EncryHelper;
	
	/**
	 * 简单的文件加密工具, 启动类.
	 * @author Zhenyu Yao
	 */
	public class Main extends Sprite 
	{
		public function Main() : void
		{
			EncryHelper.sharedInstance().encry = new SimpleEncry();
			var mc : MainContainer = new MainContainer();
			this.addChild(mc);
		}
	}
	
}







































////////////////////////////////////////////////////////////////////////////////////////////////////
// end file


