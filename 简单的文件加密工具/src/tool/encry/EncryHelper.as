package tool.encry 
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.utils.ByteArray;
	/**
	 * 加密文件的操作类
	 * @author Zhenyu Yao
	 */
	public final class EncryHelper 
	{
	
////////////////////////////////////////////////////////////////////////////////////////////////////
// public
////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/// 单例模式, 返回唯一的 EncryHelper 对象
		public static function sharedInstance() : EncryHelper
		{
			if (s_instance == null)
			{
				s_instance = new EncryHelper(new PrivateClass());
			}
			
			return s_instance;
		}

		public function EncryHelper(pc : PrivateClass)
		{
			if (pc == null || !(pc is PrivateClass))
			{
				throw Error("不能为实例化该对象");
			}
		}
		
		/**
		 * getter/setter 加密器
		 */
		public function get encry() : IEncry
		{
			return m_encry;
		}
		
		public function set encry(aEncry : IEncry) : void
		{
			m_encry = aEncry;
		}
		
		/**
		 * 将传入的 buffer 数据进行加密, 输出加密后的数据
		 * @param	buffer 待加密的数据
		 * @return 加密后的数据
		 */
		public function bufferFromBuffer(buffer : ByteArray) : ByteArray
		{
			checkEncry();
			return m_encry.bytesFromBytes(buffer);
		}
		
		/**
		 * 将 inPath 路径的文件加密, 输出加密后的文件数据
		 * @param	inPath 输入的文件路径
		 * @return 加密后的数据
		 */
		public function bufferFromFile(inPath : String) : ByteArray
		{
			checkEncry();
			
			var file : File = new File(inPath);
			if (!file.exists)
			{
				throw Error("待加密的文件不存在");
			}
			
			var fs : FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			
			// 读取文件内的数据
			var buffer : ByteArray = new ByteArray();
			fs.readBytes(buffer);
			fs.close();
			
			return bufferFromBuffer(buffer);
		}
		
		/**
		 * 将 buffer 进行加密后, 输出到 outPath 指定的文件
		 * @param	buffer 待加密的数据
		 * @param	outPath 保存文件的路径
		 * @return 成功返回 true, 否则返回 false
		 */
		public function bufferToFile(buffer : ByteArray, outPath : String) : Boolean
		{
			var newBuffer : ByteArray = bufferFromBuffer(buffer);
			
			var file : File = new File(outPath);
			var fs : FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(newBuffer);
			fs.close();
			
			return true;
		}
		
		/**
		 * 读取 inPath 文件内容, 进行加密后存储在 outPath 文件
		 * @param	inPath 读取文件的路径
		 * @param	outPath 存储文件的路径
		 * @return 返回 true, 否则返回 false
		 */
		public function fileToFile(inPath : String, outPath : String) : Boolean
		{
			var buffer : ByteArray = bufferFromFile(inPath);
			
			var file : File = new File(outPath);
			var fs : FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(buffer);
			fs.close();
			
			return true;
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////
// private
////////////////////////////////////////////////////////////////////////////////////////////////////
	
		/// 验证是否设置了加密器
		private function checkEncry() : void
		{
			if (m_encry == null)
			{
				throw Error("请设置加密器");
			}
		}

		private static var s_instance : EncryHelper = null;
		private var m_encry : IEncry = null;
	}
}

class PrivateClass
{
}





































////////////////////////////////////////////////////////////////////////////////////////////////////
// end file


