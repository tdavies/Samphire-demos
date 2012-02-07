package com.tomseysdavies.ember.demos.platform.nodes
{

import com.tomseysdavies.ember.demos.platform.compoments.HeroComponent;
import com.tomseysdavies.ember.entitySystem.impl.Node;
import com.tomseysdavies.samphire.components.PhysicsComponent;

public class HeroNode extends Node
	{
		public var hero:HeroComponent;
        public var physics:PhysicsComponent;
	}
}