package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Explosion extends MovieClip {

		public function Explosion() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, frame);
		}
		
		public function frame(e:Event=null) {
			if (this.currentFrame==this.totalFrames) {
				this.stop(); this.visible=false;
				removeEventListener(Event.ENTER_FRAME, frame);
				if (this.parent!=null)
					this.parent.removeChild(this);
			}
		}

	}
	
}
