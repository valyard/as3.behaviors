/**
 * @author Bloodhound / http://blooddy.by
 */
package ru.valyard.behaviors.utils {

	import flash.utils.Dictionary;

	public final class WeakRef {
		
		public function WeakRef(obj:Object) {
			super();
			this._ref[ obj ] = true;
		}
		
		/**
		 * @private
		 */
		private const _ref:Dictionary = new Dictionary ( true );
		
		public function get():* {
			for ( var obj:* in this._ref ) {
				return obj;
			}
		}

		/**
		 * @private
		 */
		public function valueOf():* {
			return this.get();
		}

		/**
		 * @private
		 */
		public function toString():String {
			return String( this.get() ); // may be undefined
		}

	}

}