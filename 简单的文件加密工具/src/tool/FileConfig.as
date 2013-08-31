package tool 
{

	/**
	 * 加密文件的全局配置类
	 * @author Zhenyu Yao
	 */
	public final class FileConfig 
	{
		/// 单例模式, 返回唯一的 FileConfig 对象
		public static function sharedInstance() : FileConfig
		{
			if (s_instance == null)
			{
				s_instance = new FileConfig(new PrivateClass());
			}
			
			return s_instance;
		}
		
		public function FileConfig(pc : PrivateClass) 
		{
			if (pc == null || !(pc is PrivateClass))
			{
				throw Error("不能为实例化该对象");
			}
		}
		
		/**
		 * getter/setter 加密的异或字符串
		 */
		public function get encryKey() : String
		{
			return m_encryKey;
		}
		
		public function set encryKey(value : String) : void
		{
			m_encryKey = value;
		}
		
		/**
		 * getter/setter 加密后文件的后缀
		 */
		public function get encryFileExt() : String 
		{
			return m_encryFileExt;
		}
		
		public function set encryFileExt(value : String) : void
		{
			m_encryFileExt = value;
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////
// private
////////////////////////////////////////////////////////////////////////////////////////////////////
	
		private static var s_instance : FileConfig = null;
		private var m_encryKey : String = "Rule the world";
		private var m_encryFileExt : String = "encry";
	}

}

/// 为的是辅助生成单例模式
class PrivateClass
{
}


