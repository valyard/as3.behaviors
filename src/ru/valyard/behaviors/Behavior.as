////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.behaviors {
	
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * Abstract behavior class which must be extended by all other behaviors.
	 * @author	Valentin Simonov
	 */
	public class Behavior extends EventDispatcher {
		
		/**
		 * @param target	Target object.
	 	 * @param params	Optional parameters.
		 */
		public function Behavior(target:Object, ...params) {
			super();
			if ((this as Object).constructor == Behavior)
				throw new IllegalOperationError("Behavior is an abstract class!");
			
			BehaviorManager.$add(target, this);
			_target = target;
			added(params);
		}
		
		//--------------------------------------------------------------------------
		//
		// Private variables
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _target:Object;
		
		/**
		 * Behavior's target
		 */
		public function get target():Object {
			return _target;
		}

		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Overriden methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Private functions
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * BehaviorsCollection asks if this behavior can be removed.
		 */
		internal final function $detach():Boolean {
			return removed();
		}
		
		/**
		 * @private
		 * BehaviorsCollection forces to remove this behavior.
		 */
		internal final function $remove():void {
			_target = null;
		}
		
		/**
		 * This method is called after Behavior is successfully initialized and added to target.
		 */
		protected function added(params:Array):void {
			
		}
		
		/**
		 * This method is called before the Behavior is about to be removed.
		 * @return	true to remove itself or false to keep itself attached to target
		 */
		protected function removed():Boolean {
			return true;
		}
		
		//--------------------------------------------------------------------------
		//
		// Event handlers
		//
		//--------------------------------------------------------------------------
		
	}
}