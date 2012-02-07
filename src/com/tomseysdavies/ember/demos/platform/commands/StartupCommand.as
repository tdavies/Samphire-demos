package com.tomseysdavies.ember.demos.platform.commands
{
import com.tomseysdavies.ember.demos.platform.assets.PlatformAssetFactory;
import com.tomseysdavies.ember.demos.platform.collisions.CollisionGroups;
import com.tomseysdavies.ember.demos.platform.collisions.PlayerGroundCollision;
import com.tomseysdavies.ember.demos.platform.compoments.HeroComponent;
import com.tomseysdavies.ember.demos.platform.nodes.HeroNode;
import com.tomseysdavies.ember.demos.platform.systems.HeroSystem;
import com.tomseysdavies.ember.entitySystem.api.IEntityManager;
import com.tomseysdavies.ember.entitySystem.api.ISystemManager;
import com.tomseysdavies.ember.io.serialise.ISerialiser;
import com.tomseysdavies.ember.io.serialise.json.JsonSerialiser;
import com.tomseysdavies.samphire.assets.IAssetFactory;
import com.tomseysdavies.samphire.components.CollisionComponent;
import com.tomseysdavies.samphire.components.ComponentFactory;
import com.tomseysdavies.samphire.components.PhysicsComponent;
import com.tomseysdavies.samphire.events.EngineEvents;
import com.tomseysdavies.samphire.nodes.CollisionNode;
import com.tomseysdavies.samphire.nodes.PhysicsNode;
import com.tomseysdavies.samphire.nodes.RenderabelNode;
import com.tomseysdavies.samphire.systems.PhysicsSystem;
import com.tomseysdavies.samphire.systems.ProcessManager;
import com.tomseysdavies.samphire.systems.RenderSystem;
import com.tomseysdavies.samphire.systems.collison.CollisionSystem;
import com.tomseysdavies.samphire.systems.editor.EditorSystem;

import flash.utils.ByteArray;

import org.swiftsuspenders.Injector;

public class StartupCommand
	{
		
		[Inject]
		public var entities:IEntityManager;
		
		[Inject]
		public var system:ISystemManager;
		
		[Inject]
		public var injector:Injector;

        [Embed(source="/com/tomseysdavies/ember/demos/platform/data/demo.json",mimeType="application/octet-stream")]
        public const DemoData:Class;
		
		public function execute():void{
            //create an assets factory(could be more automated?)
            var platformAssetFactory:PlatformAssetFactory = new PlatformAssetFactory();
            injector.map(IAssetFactory).toValue(platformAssetFactory);
            // create the component factory (used by editor)
			var componentFactory:ComponentFactory = new ComponentFactory();
            componentFactory.addComponent("Collision",CollisionComponent);
            componentFactory.addComponent("Physics",PhysicsComponent);
            componentFactory.addComponent("Hero",HeroComponent);
			injector.map(ComponentFactory).toValue(componentFactory);

            // create the serialiser
            var serialiser:JsonSerialiser = new JsonSerialiser();
            injector.map(ISerialiser).toValue(serialiser);

            // add engine events
            injector.map(EngineEvents).asSingleton();

            // create all the families for injection
			entities.requestFamily(RenderabelNode);
            entities.requestFamily(PhysicsNode);
            entities.requestFamily(CollisionNode);
            entities.requestFamily(HeroNode);

            // create all the systems
			system.add(ProcessManager);
            var collisions:CollisionSystem = system.add(CollisionSystem) as CollisionSystem;
            collisions.add(CollisionGroups.PLAYER,CollisionGroups.GROUND,PlayerGroundCollision);
            system.add(PhysicsSystem);
            system.add(HeroSystem);
            var editor:EditorSystem = system.add(EditorSystem) as EditorSystem;
            editor.addDataArray("assets",platformAssetFactory.assets);
            editor.addDataArray("collision",CollisionGroups.GROUP_LIST);
            system.add(RenderSystem);


            // load the default level data
            var bytes:ByteArray = new DemoData();
            var json:String = bytes.readUTFBytes(bytes.length);
            serialiser.deserialise(json,entities);
        }

	}
}