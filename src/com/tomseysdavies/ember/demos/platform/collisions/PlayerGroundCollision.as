/**
 * Created by IntelliJ IDEA.
 * User: tom
 * Date: 04/02/12
 * Time: 13:40
 * To change this template use File | Settings | File Templates.
 */
package com.tomseysdavies.ember.demos.platform.collisions {
import com.tomseysdavies.ember.demos.platform.compoments.HeroComponent;
import com.tomseysdavies.samphire.components.PhysicsComponent;
import com.tomseysdavies.samphire.nodes.CollisionNode;
import com.tomseysdavies.samphire.systems.collison.ICollision;

import flash.geom.Rectangle;

import spark.primitives.Rect;

public class PlayerGroundCollision implements ICollision {

    public function collide(entity:CollisionNode, hit:CollisionNode):void {
        if(entity.entity.has(PhysicsComponent)){
            var physicsComponent:PhysicsComponent =  entity.entity.get(PhysicsComponent) as PhysicsComponent;
            const boundsA:Rectangle  = entity.spatial.getBoundingBox();
            const boundsB:Rectangle  = hit.spatial.getBoundingBox();
            var intersection:Rectangle = boundsA.intersection(boundsB);


            const halfWidth:Number =  entity.spatial.width/2;

            const bottomBounds:Rectangle = new Rectangle(entity.spatial.x + 5,entity.spatial.y +entity.spatial.height - 10,entity.spatial.width - 10 ,10);
            const topBounds:Rectangle = new Rectangle(entity.spatial.x + 5,entity.spatial.y,entity.spatial.width - 10 ,10);



            if(bottomBounds.intersects(boundsB)) {
                entity.spatial.y =  hit.spatial.y - entity.spatial.height;
                physicsComponent.velY = 0;
                if(entity.entity.has(HeroComponent)){
                    var heroComponent:HeroComponent =  entity.entity.get(HeroComponent) as HeroComponent;
                    heroComponent.onGround = true;
                }
            }else if(topBounds.intersects(boundsB)){
                entity.spatial.y =  hit.spatial.y + hit.spatial.height;
                physicsComponent.velY = 0;
            }

            const leftBounds:Rectangle = new Rectangle(entity.spatial.x,entity.spatial.y + 10,halfWidth,entity.spatial.height-20);
            const rightBounds:Rectangle = new Rectangle(entity.spatial.x + halfWidth,entity.spatial.y + 10,halfWidth ,entity.spatial.height-20);

            if(leftBounds.intersects(boundsB)) {
                entity.spatial.x =  hit.spatial.x + hit.spatial.width;
            }else if(rightBounds.intersects(boundsB)){
                entity.spatial.x =  hit.spatial.x - entity.spatial.width;
            }

        }
    }


}
}
