

#include <iostream>
#include <math.h>
#include <robot.h>
#include <sensor.h>

using namespace arpro;
using namespace std;

Environment* Sensor::envir_ = NULL;

double absolute(double x)
{
    if(x<0)
        return x;
    else
        return x;
}
Robot::Robot(string _name, double _x, double _y, double _theta)
{
    pose_.x = _x;
    pose_.y = _y;
    pose_.theta = _theta;

    name_ = _name;

    // init position history
    x_history_.push_back(_x);
    y_history_.push_back(_y);

    // default sampling time: 1/100 s
    dt_ = .01;

}


void Robot::initWheels(double b, double r, double wmax)
{
    this->r = r;
    this->b = b;
    this->wmax = wmax;
}

void Robot::moveXYT(double _vx, double _vy, double _omega)
{

    pose_.x += _vx*dt_;
    pose_.y += _vy*dt_;
    pose_.theta += _omega*dt_;
    // store position history
    x_history_.push_back(pose_.x);
    y_history_.push_back(pose_.y);
}



void Robot::rotateWheels(double _left, double _right)
{
    double a,v,omega,vx,vy,W;
        bool wheel_init;
        if((r <= 0) && (b <= 0))
            wheel_init = false;
        else
            wheel_init = true;
        if(wheel_init)
        {
            if((absolute(_left) > absolute(wmax)) || (absolute(_right) > absolute(wmax)))//new addded
            a=max(absolute(_left)/wmax,absolute(_right)/wmax);
                if ( a < 1 )
                    a = 1;

                _left = _left/a;
                _right = _right/a;

                v = (_left + _right) * r/2;
                omega = (_left - _right) * r/ ( 2 * b );
                vx=v*cos(pose_.theta);
                vy=v*sin(pose_.theta);
                W=omega;
                moveXYT(vx,vy,W);

        }
}


// move robot with linear and angular velocities
void Robot::moveVW(double _v, double _omega)
{
    // to fill up

    double wl = (_v+b*_omega)/r;
    double wr = (_v-b*_omega)/r;
    rotateWheels(wl, wr);

}
// try to go to a given x-y position
void Robot::goTo(const Pose &_p)
{
    // error in robot frame
    Pose error = _p.transformInverse(pose_);
    // try to do a straight line with sensor constraints
    moveWithSensor(Twist(error.x, error.y, 0));
}
void Robot::moveWithSensor(Twist _twist)
{
    // to fill up, sensor measurement and twist checking


    // uses X-Y motion (perfect but impossible in practice)
    //moveXYT(_twist.vx, _twist.vy,_twist.w);

    // to fill up, use V-W motion when defined
    for(auto & sensor : sensors_)
    sensor->checkRobotTwist(_twist);

    double alpha = 20;
    double v = _twist.vx;
    double w = alpha * _twist.vy + _twist.w;
    for(auto & sensor : sensors_)
    sensor->updateFromRobotPose(pose_);
    moveVW(v, w);

}


void Robot::printPosition()
{
    cout << "Current position: " << pose_.x << ", " << pose_.y << endl;
}
