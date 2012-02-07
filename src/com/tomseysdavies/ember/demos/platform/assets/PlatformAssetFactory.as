package com.tomseysdavies.ember.demos.platform.assets
{
import assets.demo.Earth;
import assets.demo.Hero;
import assets.demo.Stone;

import com.tomseysdavies.samphire.assets.IAssetFactory;
	
	import flash.display.MovieClip;
	
	public class PlatformAssetFactory implements IAssetFactory
	{
		
		public static const EARTH:String = "earth";
        public static const STONE:String = "stone";
        public static const HERO:String = "hero";
		
		private const _assets:Vector.<String> = new <String>[EARTH,STONE,HERO];
		
		
		public function PlatformAssetFactory()
		{
		}
		
		public function get assets():Vector.<String>
		{
			return _assets;
		}
		
		public function createAsset(name:String):MovieClip
		{
			switch(name){
				case EARTH:
					return new Earth();
					break;
                case STONE:
                    return new Stone();
                    break;
                case HERO:
                    return new Hero();
                    break;
				default:
					throw new Error("Missing asset '" + name + "'");
			}
		}
	}
}