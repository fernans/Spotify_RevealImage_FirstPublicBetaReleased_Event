package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.display.StageAlign;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.LoaderInfo;
	import com.greensock.TweenNano;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	
	
	public class Fondos extends MovieClip {
		
		public var config:URLLoader;
		public var fondoUrl:String=null;
		public var numElementos:Number=0;
		public var elementosUrl:Array=new Array();
		public var elementoScale:Number=100;
		
		public var fondo:MovieClip;
		public var fondoVideo:Video;
		public var fondoVideoUrl:String=null;
		public var fondoVideoNS:NetStream=null;
		public var elementos:Array;
		
		public function Fondos() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, preinit);
		}
		
		public function preinit(e:Event=null) {
			// fullscreen
			//stage.scaleMode=StageScaleMode.EXACT_FIT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.align=StageAlign.TOP_LEFT;
			Mouse.hide();
			
			// cargar configuracion
			config=new URLLoader();
			config.addEventListener(Event.COMPLETE, parseConfig);
			config.load(new URLRequest("config.xml"));
		}
	
		public function parseConfig(e:Event=null) {
			var doc:XMLDocument=new XMLDocument(config.data);
			if (doc!=null) {
				var node:XMLNode=doc.firstChild;
				while (node!=null) {
					if (node.localName!=null) {
						trace(node.localName);
						if (node.localName.toLocaleLowerCase()=="fondo") {
							if (node.attributes.url!=null) fondoUrl=node.attributes.url;
							if (node.attributes.video!=null) fondoVideoUrl=node.attributes.video;
						}
						if (node.localName.toLocaleLowerCase()=="elementos") {
							if (!isNaN(Number(node.attributes.num))) numElementos=Number(node.attributes.num);
							if (!isNaN(Number(node.attributes.s))) elementoScale=Number(node.attributes.s);
							var elem:XMLNode=node.firstChild;
							while (elem!=null) {
								if (elem.localName!=null && elem.localName.toLocaleLowerCase()=="elemento") {
									if (elem.attributes.url!=null) elementosUrl.push(elem.attributes.url);
								}
								elem=elem.nextSibling;
							}
						}
					}
					node=node.nextSibling;
				}
			}
			init();
		}
		
		public function init(e:Event=null) {
			
			trace("Stage: "+stage.fullScreenWidth+"x"+stage.fullScreenHeight);
			// fondo
			fondo=new MovieClip();
			this.addChild(fondo);
			// cargar fondo
			if (fondoUrl!=null) {
				var loader:Loader=new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fondoCargado);
				loader.load(new URLRequest(fondoUrl));
			}
			// fondo-video
			if (fondoVideoUrl!=null) {
				fondoVideo=new Video(stage.fullScreenWidth, stage.fullScreenHeight);
				this.addChild(fondoVideo);
				var nc:NetConnection=new NetConnection();
				nc.connect(null); // local-connection
				fondoVideoNS=new NetStream(nc);
				fondoVideoNS.client=this;
				fondoVideo.attachNetStream(fondoVideoNS);
				fondoVideoNS.pause();
				fondoVideoNS.seek(0);
				fondoVideo.visible=false;
				//fondoVideoNS.play(fondoVideoUrl);
			}
			
			// elementos
			elementos=new Array();
			
			// crear elementos
			crearElementos();
			
			// interactividad
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key);
		}
		
		
		// fondo cargado
		public function fondoCargado(e:Event=null) {
			var l:LoaderInfo=(e.target) as LoaderInfo;
			if (l!=null) {
				var c:DisplayObject=(l.content);
				fondo.addChild(c);
				c.width=stage.fullScreenWidth;
				c.height=stage.fullScreenHeight;
				var b:Bitmap=(c as Bitmap);
				if (b!=null) b.smoothing=true;
			}
		}
		
		
		// crear Elementos
		public function crearElementos() {
			// recrear todos (eliminando antiguos)
			while(elementos.length>0) {this.removeChild(elementos.pop());}
			for (var i:int=0;i<numElementos;i++) {
				crearUnElemento();
			}
			fondoVideo.visible=false;
			fondoVideoNS.pause();
			fondoVideoNS.seek(0);
			/*
			// solo los faltantes
			var actuales:Number=elementos.length;
			for (var i:int=actuales;i<numElementos;i++) {
				crearUnElemento();
			}
			//*/
		}
		
		public function crearUnElemento() {
			var url:String=elementosUrl[Math.floor(elementosUrl.length*Math.random())];
			trace("creando 1 elemento: "+url);
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, centrar);
			loader.x=Math.random()*stage.fullScreenWidth;
			loader.y=Math.random()*stage.fullScreenHeight;
			this.addChild(loader);
			elementos.push(loader);
			loader.load(new URLRequest(url));
		}
		
		public function centrar(e:Event=null) {
			var li:LoaderInfo=(e.target as LoaderInfo);
			if (li!=null) {
				var l:Loader=li.loader;
				if (l!=null) {
					var c:DisplayObject=l.content;
					l.scaleX=l.scaleY=(0.8+(Math.random()*0.4))*(elementoScale/100);
					l.rotation=-30+(Math.random()*60);
					c.x=-c.width*0.5;
					c.y=-c.height*0.5;
					var b:Bitmap=(c as Bitmap);
					if (b!=null) b.smoothing=true;
					//b.cacheAsBitmap=true;
					l.cacheAsBitmap=true;
				}
			}
		}
		
		// desvanecer
		public function desvanecerTodos() {
			while (elementos.length>0) {
				desvanecerUltimo(false);
			}
		}
		
		public function desvanecerUltimo(explotar:Boolean=false) {
			var l:Loader=(elementos.pop() as Loader); // sacar al ultimo
			if (l!=null) { // si quedan
				if (explotar) {
					trace("explotar");
					var e:MovieClip;
					switch (Math.floor(Math.random()*3)) {
						// elegir explosion (0-2)
						default:
						case 0:
							e=new Explosion0();
						break;
						case 1:
							e=new Explosion0();
						break;
						case 2:
							e=new Explosion0();
						break;
					}
					this.addChild(e);
					this.setChildIndex(e,this.getChildIndex(l)+1); // poner explosion sobre el que se elimina
					e.x=l.x; e.y=l.y; e.scaleX=l.scaleX; e.scaleY=l.scaleY; e.rotation=l.rotation;
					//e.width=(l.width*elementoScale/100); e.height=(l.height*elementoScale/100);
				}
				trace("desvanecer: "+l);
				TweenNano.to(l,0.5,{alpha:0, onComplete:eliminar, onCompleteParams:[l]});
				// lanzar video
				if (elementos.length==0) {
					fondoVideo.visible=true;
					fondoVideoNS.play(fondoVideoUrl);
				}
			}
		}
		
		public function eliminar(e:DisplayObject) {
			this.removeChild(e);
			trace("eliminado: "+e);
		}
		
		
		// interactividad
		public function key(e:KeyboardEvent=null) {
			if (e.keyCode==Keyboard.SPACE) {
				if (e.ctrlKey)
					crearElementos();
				else crearUnElemento();
			}
			if (e.keyCode==Keyboard.BACKSPACE) {
				if (e.ctrlKey)
					desvanecerTodos();
				else desvanecerUltimo(true);
			}
			if (e.keyCode==Keyboard.ESCAPE) {
				stage.nativeWindow.close();
			}
		}
		
		
		// Video events
		public function asyncErrorHandler(Event:AsyncErrorEvent):void {}  
		public function onMetaData(newMeta:Object):void {} 
		public function onPlayStatus(status:Object):void {}
		public function netStatus(event:NetStatusEvent):void  {}
		
		
		
	} // class
}
