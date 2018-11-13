#ifndef SENSOR_RANGE_H
#define SENSOR_RANGE_H

#include <sensor.h>

namespace arpro
{

class RangeSensor : public Sensor
{
    public :
        RangeSensor ( Robot & _robot , double _x , double _y , double _theta ) :
        Sensor ( _robot , _x , _y , _theta ) // call the Sensor constructor

        { // the RangeSensor constructor does nothing more }


        }

        void update(const Pose &p)
        {
            Pose p1 , p2 ;
            for ( int i =0; i < envir_-> walls . size ();++ i )
            {
            p1 = envir_ -> walls [ i ];
            p2 = envir_ -> walls [( i +1)% envir_ -> walls . size ()];
            // do whatever you want to do with points p1 and p2

            s_ = (p1.x*p2.y - p1.x*p.y - p2.x*p1.y + p2.x*p.y + p.x*p1.y - p.x*p2.y) / (p1.x*sin(p.theta) - p2.x*sin(p.theta) - p1.y*cos(p.theta) + p2.y*cos(p.theta));
            s_history_[i]= s_;

            cout<<"Distance    "<<s_<<endl;

            }
        }

        void checkTwist(Twist & _t)
        {
            double g = 0.1, sm = 0.1;
            int i;
            for(i = 0; i < 4; i++)
                if((s_history_[i] > 0) && (s_history_[i] < 0.1))
                    if(_t.vx > (g * (s_history_[i] - sm)))
                        _t.vx = (g * (s_history_[i] - sm));

        }


};
}
#endif // SENSOR_RANGE_H

