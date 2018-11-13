#ifndef SENSOR_BEARING_H
#define SENSOR_BEARING_H
#include<sensor.h>
#include<robot.h>

class SensorBearing : public Sensor
{
    public :
        RangeSensor ( Robot & _robot , double _x , double _y , double _theta ) :
        Sensor ( _robot , _x , _y , _theta ) // call the Sensor constructor

        { // the RangeSensor constructor does nothing more }


        }

        void update(const Pose &p)
        {
            // look for first other robot
            for ( auto other : envir_-> robots_ )
            if ( other != robot_ )
            {
            // compute angle between sensor and detected robot
            break ;
            }
            // set angle back to [ - pi , pi ]
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

#endif // SENSOR_BEARING_H

