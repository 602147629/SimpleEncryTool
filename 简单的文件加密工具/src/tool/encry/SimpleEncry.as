package tool.encry 
{
	import flash.utils.ByteArray;
	
	/**
	 * 普通的加密功能类, 用给定的数据流做异或处理
	 * @author Zhenyu Yao
	 */
	public class SimpleEncry implements IEncry 
	{
		
		public function SimpleEncry() 
		{
		}
		
		/**
		 * getter/setter 加密使用的 Key
		 */
		public function get encryKey() : String
		{
			return m_encryKey;
		}
		
		public function set encryKey(value : String) : void
		{
			m_encryKey = value;
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////
// interface - IEncry
////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function bytesFromBytes(bytes : ByteArray) : ByteArray 
		{
			trace(bytes.length);
			
			// 将加密键字符串以 UTF-8 编码格式转化为 ByteArray 对象
			var keyBytes : ByteArray = new ByteArray();
			keyBytes.writeMultiByte(m_encryKey, "UTF-8");
			
			// 待加密数据与加密键的每一个字节进行异或计算
			var newBytes : ByteArray = new ByteArray();
			for (var i : int = 0; i < bytes.length; i += keyBytes.length)
			{
				for (var j : int = 0; j < keyBytes.length && i + j < bytes.length; ++j)
				{
					newBytes.writeByte(bytes[i + j] ^ keyBytes[j]);
				}
			}
			
			newBytes.position = 0;
			return newBytes;
		}
	
////////////////////////////////////////////////////////////////////////////////////////////////////
// private
////////////////////////////////////////////////////////////////////////////////////////////////////

		private var m_encryKey : String = "";
		
	}

}