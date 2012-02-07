/**
 * Created by IntelliJ IDEA.
 * User: tom
 * Date: 04/02/12
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package com.tomseysdavies.ember.demos.platform.compoments {

public class HeroComponent {

    public var jump:Number = 0;
    public var speed:Number = 0;
    [Ember(skip="true")]
    public var onGround:Boolean = true;

    public function HeroComponent() {
    }
}
}
