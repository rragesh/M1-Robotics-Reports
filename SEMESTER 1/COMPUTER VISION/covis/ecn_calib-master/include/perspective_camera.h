#ifndef PERSPECTIVE_CAMERA_H
#define PERSPECTIVE_CAMERA_H

#include <generic_camera.h>

/*
 * This class inherits from GenericCamera and implements the classical perspective camera model
 * Methods to be filled up are:
 * - project
 * - computeJacobianIntrinsic
 * - computeJacobianExtrinsic
 */


namespace covis
{


// xi = (px, py, u0, v0)
class PerspectiveCamera : public GenericCamera
{


public:

    PerspectiveCamera(const double &_px, const double &_py, const double &_u0, const double &_v0, const bool &_calibrated=false)
    {
        xi_.resize(4);
        xi_[0] = _px;
        xi_[1] = _py;
        xi_[2] = _u0;
        xi_[3] = _v0;
    }


    // check that the parameters stay meaningfull in case of wrong update
    void updateIntrinsic(const vpColVector &_dxi)
    {
        // update
        xi_ += _dxi;
        // all parameters should be positive
        for(unsigned int i=0;i<4;++i)
            if(xi_[i] < 0)
                xi_[i] = 0;

    }


    // compute pixel coordinates of a 3D point
    // we assume the point is already projected in the camera frame
    void project(const vpPoint &_P, double &_u, double &_v)
    {
        _u=xi_[0]*(_P.get_x())+xi_[2];
        _v=xi_[1]*(_P.get_y())+xi_[3];


    }


    // write the Jacobian corresponding to the intrinsic parameters
    // Jacobian should be 2x4
    // we assume the point is already projected in the camera frame
    void computeJacobianIntrinsic(const vpPoint &_P, vpMatrix &_J)
    {


         _J[0][0]=_P.get_x();
         _J[0][1]=0;
         _J[0][2]=1;
         _J[0][3]=0;
         _J[1][0]=0;
         _J[1][1]=_P.get_y();
         _J[1][2]=0;
         _J[1][3]=1;

    }


    // write the Jacobian wrt extrinsic parameters
    // J should be 2x6
    // we assume the point is already projected in the camera frame
    void computeJacobianExtrinsic(const vpPoint &_P, vpMatrix &_J)
    {
        double px = xi_[0];
        double py = xi_[1];
        double u0 = xi_[2];
        double v0 = xi_[3];

        double x=_P.get_x();
        double y=_P.get_y();
        double Z=_P.get_Z();

        _J[0][0]=-px/Z;
        _J[0][1]=0;
        _J[0][2]=px*(x/Z);
        _J[0][3]=px*py;
        _J[0][4]=-px*(1+x*x);
        _J[0][5]=px*y;
        _J[1][0]=0;
         _J[1][1]=-py/Z;
         _J[1][2]=py*(y/Z);
         _J[1][3]=py*(1+y*y);
         _J[1][4]=-py*x*y;
         _J[1][5]= -py*x;

    }
};
}


#endif // PERSPECTIVE_CAMERA_H
