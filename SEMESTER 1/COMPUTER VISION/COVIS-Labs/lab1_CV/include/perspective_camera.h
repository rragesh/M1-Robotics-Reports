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
        double X = _P.get_X();
        double Y = _P.get_Y();
        double Z = _P.get_Z();

        double x = X/Z;
        double y = Y/Z;

        _u = xi_[0]*x + xi_[2];
        _v = xi_[1]*y + xi_[3];

    }


    // write the Jacobian corresponding to the intrinsic parameters
    // Jacobian should be 2x4
    // we assume the point is already projected in the camera frame
    void computeJacobianIntrinsic(const vpPoint &_P, vpMatrix &_J)
    {
        double X = _P.get_X();
        double Y = _P.get_Y();
        double Z = _P.get_Z();

        double x = X/Z;
        double y = Y/Z;

        _J[0][0] = x;
        _J[0][1] = 0;
        _J[0][2] = 1;
        _J[0][3] = 0;
        _J[1][0] = 0;
        _J[1][1] = y;
        _J[1][2] = 0;
        _J[1][3] = 1;

    }


    // write the Jacobian wrt extrinsic parameters
    // J should be 2x6
    // we assume the point is already projected in the camera frame
    void computeJacobianExtrinsic(const vpPoint &_P, vpMatrix &_J)
    {

        double X = _P.get_X();
        double Y = _P.get_Y();
        double Z = _P.get_Z();

        double x = X/Z;
        double y = Y/Z;

        _J[0][0] = -(xi_[0])/Z;
        _J[0][1] = 0;
        _J[0][2] = xi_[0]*x/Z;
        _J[0][3] = xi_[0]*x*y;
        _J[0][4] = -xi_[0]*(1+x*x);
        _J[0][5] = xi_[0]*y;

        _J[1][0] = 0;
        _J[1][1] = -xi_[1]/Z;
        _J[1][2] = xi_[1]*y/Z;
        _J[1][3] = xi_[1]*(1+y*y);
        _J[1][4] = -xi_[1]*x*y;
        _J[1][5] = -xi_[1]*x;


    }
};
}


#endif // PERSPECTIVE_CAMERA_H
