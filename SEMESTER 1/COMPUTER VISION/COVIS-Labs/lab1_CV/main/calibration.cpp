#include <visp/vpHomogeneousMatrix.h>

#include <visp/vpPoint.h>
#include <visp/vpSubColVector.h>
#include <visp/vpSubMatrix.h>
#include <visp/vpFeaturePoint.h>
#include <visp/vpFeatureBuilder.h>
#include <visp/vpExponentialMap.h>
#include <visp/vpAdaptiveGain.h>
#include <visp/vpIoTools.h>
#include <fstream>

#include <opencv2/calib3d/calib3d.hpp>

#include <vvs.h>
#include <grid_tracker.h>
#include <perspective_camera.h>
#include <distortion_camera.h>
#include <cb_tracker.h>

using std::cout;
using std::endl;
using std::string;
using std::vector;
using std::stringstream;
using cv::waitKey;
using namespace covis;

int main()
{
    // load calibration images from hard drive
    const string base = "../images/";
    const string prefix = "img";

    // init empty vector of detected patterns
    vector<Pattern> patterns;
    patterns.clear();
    patterns.reserve(36);


    //GridTracker tracker;      // this tracker detects a 6x6 grid of points
    CBTracker tracker(8,5);     // this one is to be given the chessboard dimension (8x6)

    // read images while the corresponding file exists
    // images are displayed to ensure the detection was performed
    while(true)
    {
        stringstream ss;
        ss << prefix << patterns.size() << ".jpg";
        std::ifstream testfile(base + ss.str());
        if(testfile.good())
        {
            testfile.close();
            Pattern pat;
            pat.im =  cv::imread(base + ss.str());
            tracker.detect(pat.im, pat.point);
            pat.window = ss.str();
            // draw extraction results
            //drawSeq(pat.window, pat.im, pat.point);
            patterns.push_back(pat);
            waitKey(0);
        }
        else
            break;
    }
    cout << "Found " << patterns.size() << " images" << endl;

    // create a camera model (Perspective or Distortion)
    // default parameters should be guessed from image dimensions//VVS vvs(cam, 0.03, 8, 5);

    const double pxy = 0.5*(patterns[0].im.rows + patterns[0].im.cols);
  //PerspectiveCamera cam (pxy, pxy, 0.5*patterns[0].im.cols, 0.5*patterns[0].im.rows);

    /*M_.resize ( n_im );
    // wild guess for initial pose , then will use the last found at initial value
    for ( unsigned int n=0; n < n_im ;++n )
    M_[n].buildFrom (0,0.,0.5,0,0 , atan2(_cog[n][5].y-_cog[n][0].y, _cog[n][5].x-_cog[n][0].x));*/
//VVS vvs(cam, 0.03, 8, 5);
    //PerspectiveCamera cam(1,1,1,1);   // not a very good guess

    // initiate virtual//VVS vvs(cam, 0.03, 8, 5); visual servoing with inter-point distance and pattern dimensions
   //VVS vvs(cam, 0.03, 8, 5);

    // calibrate from all images
  // vvs.calibrate(patterns);


    //After pose Computation execute this


    PerspectiveCamera cam(1819.8338115,1822.0726443, 477.7982043, 356.2976935);
    VVS vvs(cam, 0.03, 8, 5);


    vpHomogeneousMatrix M;
    vvs.computePose(patterns[0],M,true);

    //


    // print results
    cout << "Final calibration: " << cam.xi_.t() << endl;

    // this will wait for a key pressed to stop the program
    waitKey(0);
}
