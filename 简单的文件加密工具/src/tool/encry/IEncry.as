package tool.encry 
{
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	/**
	 * 字节流加密的操作接口
	 * @author Zhenyu Yao
	 */
	public interface IEncry 
	{
		
		/**
		 * 给定的数据流经过加密算法得到加密后的数据流
		 * @param	bytes 原数据流
		 * @return 加密后的数据流
		 */
		function bytesFromBytes(bytes : ByteArray) : ByteArray;
		
	}

}