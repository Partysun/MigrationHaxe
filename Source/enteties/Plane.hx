package enteties;

import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.dynamics.controllers.B2ConstantForceController;
import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;

import org.flixel.FlxSprite;
import org.flixel.FlxPoint;
import org.flixel.FlxG;
import org.flixel.FlxU;

import enteties.physic.B2FlxSprite;

import utils.BasicUtils;
/**
 * Класс самолетика игрока. Главный дейсвующий объект игры.
 * @author Partysun - yura.zatsepin@gmail.com
 */
class Plane extends B2FlxSprite
{
    private var vectorfirst:FlxPoint = new FlxPoint();
    private var vectorsecond:FlxPoint = new FlxPoint();
    private var vectorfirstang:FlxPoint = new FlxPoint();
    private var vectorsecondang:FlxPoint = new FlxPoint();
    private var vectorcheck:Int;
    private var launchStart:Bool = false;
    private var trigerLaunch:Bool = true;
    
    // Ограничения при броске
    private var adjust:FlxPoint = new FlxPoint(20, 480 - 450);
    // Сила крыльев
    private var wingPower:B2ConstantForceController;
    
    private var WING_DRAG_H:Float = 0.08;         // horizontal component of wing's drag
    private var WING_DRAG_V:Float = 5;            // vertical component of wing's drag

    
    // объект для ведения камеры за объектом
    private var dummy:FlxSprite = new FlxSprite();
    private var isDummyLock:Bool = true;
    private var isDummyFollow:Bool = false;		
    
    public function new(world:B2World, ?x:Int = 0, ?y:Int = 0 )
    {
        super(x, y, 18, 18, world);
        
        _body.setLinearVelocity(new B2Vec2(0, 0));
        loadGraphic("assets/png/cat.png");
        
        vectorcheck = 0;
        var mass:B2MassData = new B2MassData();
        mass.mass = 1;
        mass.center.setZero();
        mass.I =  2; // 2* mass        
        this._body.setMassData(mass);
    
        this.antialiasing = true;
        wingPower = new B2ConstantForceController();	
        wingPower.addBody(this._body);
        world.addController(wingPower);
        FlxG.state.add(dummy);
        dummy.x = 300;
        dummy.y = 480 - 250;		
        dummy.visible = false;
        FlxG.camera.follow(dummy);					
    }
    
    public function rotate(aimAngle:Float):Void
    {
        if (this._body.getAngle() >= 2*Math.PI)
            this._body.setAngle(this._body.getAngle() - 2*Math.PI);
        if (this._body.getAngle() < 0)
            this._body.setAngle(this._body.getAngle() + 2*Math.PI);
        var aimAng:Float = aimAngle + 180;
        var thisAng:Float = this._body.getAngle()*180/Math.PI + 180;
        if (aimAng > 360)
            aimAng -= 360;
        if (aimAng < 0)
            aimAng += 360;
        if (thisAng > 360)
            thisAng -= 360;
        if (thisAng < 0)
            thisAng += 360;
        if (Math.abs(aimAng - thisAng) > 180)
            {
                if (Math.round(aimAng) > Math.round(thisAng))
                    this._body.setAngle(this._body.getAngle() - Math.PI / 180);
                if (Math.round(aimAng) < Math.round(thisAng))
                    this._body.setAngle(this._body.getAngle() + Math.PI / 180);
            }
        if (Math.abs(aimAng - thisAng) < 180)
            {
                if (Math.round(aimAng) > Math.round(thisAng))
                    this._body.setAngle(this._body.getAngle() + Math.PI / 180);
                if (Math.round(aimAng) < Math.round(thisAng))
                    this._body.setAngle(this._body.getAngle() - Math.PI / 180);
            }
    }
    
    override public function update():Void 
    {
        super.update();			
        
        // Один раз запускаем самолетик в его жизни.
        if (trigerLaunch)
        {
            // Если мышка зажата и самолетик под ней то запускаем в полет
            //TODO: вернуть управление
            //if ( FlxG.mouse.justPressed() && FlxU.inSprite(this))
            //{					
                //launchStart = true;					
            //}
            
            // Удерживаем  физический объект в поле экрана с небольшими отступами
            // на время запуска
            if (launchStart)
            {
                this._body.setPosition(getFixedMousePos());					
            }
            
            // Каждые 100 мс запоминаем позиции мышки (для генерации вектора броска)
            if (launchStart && getTimer() > vectorcheck + 50)
            {
                vectorcheck = getTimer();
                vectorsecond = vectorfirst;		
                vectorfirst = new FlxPoint(FlxG.mouse.screenX, FlxG.mouse.screenY);
            }
            
            // Если мышка отжата и мы запускали объект , то запускаем.
            if (FlxG.mouse.justReleased() && launchStart)
            {
                launchStart = false;				
                trigerLaunch = false;			
                GameManager.gameCondition = GameManager.RUNNING;
                //TODO: сделать плавное движение камеры за объектом					
                isDummyLock = false;
                //FlxG.camera.follow(this);
                // Добавляем физ.объекту силу ветра
                //this._body.ApplyForce(new b2Vec2( -250, 0), this._body.GetWorldCenter());
                // Придаем импульс броска
                this._body.ApplyImpulse(new B2Vec2((vectorfirst.x - vectorsecond.x) / 10, (vectorfirst.y - vectorsecond.y) / 10), this._body.getWorldCenter());	
                var dx:Float = vectorfirst.x - vectorsecond.x;
                var dy:Float = vectorfirst.y - vectorsecond.y;
                this._body.SetAngle(Math.atan2(dy,dx));
                //((FlxU.getAngle(vectorsecond, vectorfirst)) - 90) / 180 * Math.PI);						
            }
            vectorfirstang = new FlxPoint(this.x, this.y);
        }		
        
        // Если думми не догнал еще самолетик
        if (!isDummyLock)
        {
            BasicUtils.moveTowardsPoint(dummy, new FlxPoint(this.getMidpoint().x +200, this.getMidpoint().y), this._body.getLinearVelocity().x * 30 + 500);
            if (this.y < 500)
            {
                
            }
            if (dummy.x > this.x + 200)
            {
                isDummyLock = true;
                dummy.y = this.y;
                dummy.x = this.x + 200;
                isDummyFollow = true;
            }				
        }
        
        // Если думми догнал то следуем за обектом
        if (isDummyFollow)
        {
            dummy.y = this.y;
            dummy.x = this.x + 200;
        }
    
        // Контролируем полет объекта над землей
        if (GameManager.gameCondition == GameManager.RUNNING && this.y < GameManager.level.boundsMaxY - 80)
        {				
            if (getTimer() > vectorcheck + 100)
            {						
                vectorcheck = getTimer();
                vectorsecondang = vectorfirstang;		
                vectorfirstang = new FlxPoint(this.x, this.y);
                var dx:Float = vectorfirstang.x - vectorsecondang.x;
                var dy:Float = vectorfirstang.y - vectorsecondang.y;				
                rotate(Math.atan2(dy,dx) / Math.PI * 180);
                //trace(this.angle + "  " + wingPower.F.x + "  "+ wingPower.F.y);
            }
        }
        
        //TODO заменить на коллайд физ объекта с физ землей
        if (this.isB2AngleSynchronized && this.y > GameManager.levelHeight - 80 && GameManager.gameCondition == GameManager.RUNNING)
        {
            this.isB2AngleSynchronized = false;
            this.angle = 0;
            wingPower.removeBody(this._body);
            //if (this._obj.GetLinearVelocity().x < 0.2)
                //this._obj.SetLinearVelocity(new b2Vec2(0,_obj.GetLinearVelocity().y));
        }	
        
        // Контролируем подъемную силу крыльев во время полета
        if (GameManager.gameCondition == GameManager.RUNNING)
        {
            var wings:B2Vec2   = wingsForce();
            wingPower.F = new B2Vec2(wings.x * 0.01, wings.y * 0.01);// newtons per kg				
        }
    }
    
    /**
     * Проверка нахождения мышки в экране для без багованого полета
     */
    private function getFixedMousePos():B2Vec2
    {
        var objPos:B2Vec2 ;
        
        objPos = new B2Vec2(FlxG.mouse.x / GameManager.RATIO, FlxG.mouse.y / GameManager.RATIO);
        
        if (FlxG.mouse.x < adjust.x)
            objPos.x = adjust.x/GameManager.RATIO;
        
        if (FlxG.mouse.x > Migration.ScreenWidth - adjust.x)
            objPos.x = (Migration.ScreenWidth-adjust.x) / GameManager.RATIO;				
        
        if (FlxG.mouse.y < adjust.y)
            objPos.y = adjust.y/GameManager.RATIO;
        
        if (FlxG.mouse.y > Migration.ScreenHeight + adjust.y - 100)
            objPos.y = (Migration.ScreenHeight + adjust.y - 100)/ GameManager.RATIO;
        
        return objPos;
    }	
    
    // Aerodynamic force
    private function wingsForce():B2Vec2
    {
        var angle:Float = this._body.getAngle(); // hull angle
        //			
        var velocity:B2Vec2 = this._body.getLinearVelocity();
        var v:Float = Math.sqrt( velocity.x*velocity.x + velocity.y*velocity.y );
        var velAngle:Float = Math.atan2( velocity.y, velocity.x );
        //
        //static const double WING_INCLINATION = 0.04;    // hull-wings angle
        //
        //var attack:Float = angle + (WING_INCLINATION*_orientation) - velAngle; // angle of attack
        var attack:Float = angle -  velAngle; // angle of attack

        var sina:Float = Math.sin(attack);
        // lift
        //double lift = v*v * ( WING_LIFT + FLAPS_EXTRA_LIFT*_flaps ) * sina;
        var lift:Float = v * v * sina;		
        // 			
        //drag
        //double dragH = WING_DRAG_H + FLAPS_EXTRA_DRAG*_flaps;
        var dragH:Float = WING_DRAG_H;
        var drag:Float = v*v*(dragH +(WING_DRAG_V-dragH) * sina*sina ) * 0.1;
        //
        return new B2Vec2( -drag*Math.cos(angle)  - lift*Math.sin(angle)
                ,   -drag*Math.sin(angle) + lift*Math.cos(angle));
    }
}
