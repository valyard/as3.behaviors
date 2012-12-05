////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.behaviors {
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	/**
	 * Behavior manager.
	 * @author	Valentin Simonov
	 */
	public final class BehaviorManagerImpl {
		
		public function BehaviorManagerImpl() {}
		
		//--------------------------------------------------------------------------
		//
		// Private variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _HASH:Dictionary = new Dictionary(true);
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get numTargets():uint {
			var result:uint = 0;
			for (var o:Object in _HASH ) {
				var collection:BehaviorCollection = _HASH[o];
				if (collection.length) {
					result++;
				} else {
					delete _HASH[o];
				}
			}
			return result;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function getBehaviors(target:Object):BehaviorCollection {
			var collection:BehaviorCollection = _HASH[target];
			if (!collection) {
				collection = _HASH[target] = new BehaviorCollection(target);
			}
			return collection;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeBehaviors(target:Object, force:Boolean = false):Boolean {
			var collection:BehaviorCollection = _HASH[target];
			if (!collection) return false;
			if (collection.removeAll(force)) {
				delete _HASH[target];
				return true;
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAllBehaviors():void {
			for (var o:Object in _HASH) {
				this.removeBehaviors(o, true);
			}
		}
		
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
		 */
		internal function $add(target:Object, behavior:Behavior):void {
			this.getBehaviors(target).$add(behavior);
		}
		
		//--------------------------------------------------------------------------
		//
		// Event handlers
		//
		//--------------------------------------------------------------------------
		
	}
}