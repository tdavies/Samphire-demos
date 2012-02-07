/**
 * Created by IntelliJ IDEA.
 * User: tom
 * Date: 04/02/12
 * Time: 14:52
 * To change this template use File | Settings | File Templates.
 */
package com.tomseysdavies.ember.demos.platform.systems {
import com.tomseysdavies.ember.demos.platform.nodes.HeroNode;
import com.tomseysdavies.samphire.events.EngineEvents;
import com.tomseysdavies.samphire.systems.System;

import flash.display.DisplayObjectContainer;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class HeroSystem extends System{

    [Inject]
    public var contextView:DisplayObjectContainer;

    [Inject]
    public var engineEvents:EngineEvents;

    [Inject]
    public var heroNodes:Vector.<HeroNode>;

    private var jumping:Boolean;
    private var left:Boolean;
    private var right:Boolean;

    override public function initialize():void {
        super.initialize();
        contextView.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        contextView.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        addListener(engineEvents.tick,tickHandler);
    }

    private function tickHandler(t:Number):void {
        for each(var node:HeroNode in heroNodes){
            if(left){
                node.physics.velocity.x = -node.hero.speed;
            } else if(right){
                node.physics.velocity.x = node.hero.speed;
            }else{
                node.physics.velocity.x = 0;
            }
            if(node.hero.onGround){
                if(jumping){
                    node.physics.velocity.y = -node.hero.jump;

                }
            }
            node.hero.onGround = false;
        }

    }

    private function keyDownHandler(event:KeyboardEvent):void {
        switch(event.keyCode){
            case Keyboard.UP:
            case Keyboard.W:
                jumping = true;
                break;
            case Keyboard.LEFT:
            case Keyboard.A:
                left = true;
                break;
            case Keyboard.RIGHT:
            case Keyboard.D:
                right = true;
                break;
        }
    }


    private function keyUpHandler(event:KeyboardEvent):void {
        switch(event.keyCode){
            case Keyboard.UP:
            case Keyboard.W:
                jumping = false;
                break;
            case Keyboard.LEFT:
            case Keyboard.A:
                left = false;
                break;
            case Keyboard.RIGHT:
            case Keyboard.D:
                right = false;
                break;
        }
    }
}
}
