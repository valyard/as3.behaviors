////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Valentin Simonov
//
////////////////////////////////////////////////////////////////////////////////
package ru.valyard.behaviors.core {
	
	import flash.display.InteractiveObject;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import ru.valyard.behaviors.Behavior;
	
	/**
	 * Behavior which expects an InteractiveObject as target.
	 * Abstract class.
	 * @author	Valentin Simonov
	 */
	public class InteractiveBehavior extends Behavior {
		
		/**
		 * @param target	InteractiveObject to attach this behavior to.
		 * @param params	Optional parameters.
		 */
		public function InteractiveBehavior(target:InteractiveObject, ...params)
		{
			this._displayTarget = target;
			super( target, params );
			if ( (this as Object).constructor == InteractiveBehavior )
				throw new IllegalOperationError( "InteractiveBehavior is an abstract class!" );
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
		private var _displayTarget:InteractiveObject;
		
		/**
		 * InteractiveObject behavior target.
		 */
		public final function get displayTarget():InteractiveObject {
			return this._displayTarget;
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
		
		protected override function added(params:Array):void {
			super.added( params );
			
			this._displayTarget.addEventListener(Event.ADDED_TO_STAGE, this.handler_added);
			this._displayTarget.addEventListener(Event.REMOVED_FROM_STAGE, this.handler_removed);
			if ( this.displayTarget.stage ) {
				this.activate();
			}
		}
		
		protected override function removed():Boolean {
			this.deactivate();
			this._displayTarget.removeEventListener(Event.ADDED_TO_STAGE, this.handler_added);
			this._displayTarget.removeEventListener(Event.REMOVED_FROM_STAGE, this.handler_removed);
			this._displayTarget = null;
			
			return super.removed();
		}
		
		//--------------------------------------------------------------------------
		//
		// Private functions
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Fires when behavior activates, i.e. is added to target on stage or target is added to stage
		 */
		protected function activate():void {
			
		}
		
		/**
		 * Fires when behavior deactivates, i.e. is removed from target or target is removed from stage
		 */
		protected function deactivate():void {
			
		}
		
		/**
		 * @private
		 */
		private function addedToStage():void {
			this.activate();
		}
		
		/**
		 * @private
		 */
		private function removedFromStage():void {
			this.deactivate();
		}
		
		//--------------------------------------------------------------------------
		//
		// Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function handler_added(event:Event):void {
			if (!this._displayTarget) return;
			this.addedToStage();
		}
		
		/**
		 * @private
		 */
		private function handler_removed(event:Event):void {
			if (!this._displayTarget) return;
			this.removedFromStage();
		}
		
	}
}