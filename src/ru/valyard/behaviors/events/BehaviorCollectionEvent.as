////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.behaviors.events {
	
	import flash.events.Event;
	
	import ru.valyard.behaviors.Behavior;
	
	/**
	 * @author	Valentin Simonov
	 */
	public class BehaviorCollectionEvent extends Event {
		
		/**
		 * Behavior added.
		 */
		public static const BEHAVIOR_ADDED:String						= "behaviorAdded";
		
		/**
		 * Behavior removed.
		 */
		public static const BEHAVIOR_REMOVED:String						= "behaviorRemoved";
		
		/**
		 * Behavior which initiated this event.
		 */
		public var behavior:Behavior;
		
		public function BehaviorCollectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, behavior:Behavior = null) {
			super(type, bubbles, cancelable);
			this.behavior = behavior;
		}
		
	}
}