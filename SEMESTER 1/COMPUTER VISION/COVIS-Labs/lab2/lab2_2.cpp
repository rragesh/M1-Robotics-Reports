//dynamic tracking

#include "opencv2/opencv.hpp"
#include <stdio.h>
#include <iostream>
#include "opencv2/core.hpp"
#include "opencv2/features2d.hpp"
#include "opencv2/xfeatures2d.hpp"
#include "opencv2/highgui.hpp"


using namespace std;
using namespace cv;
using namespace cv::xfeatures2d;

using namespace cv;


int main(int, char**)
{
    VideoCapture cap("video2.mp4"); // open the video
    if(!cap.isOpened())  // check if we succeeded
    {std::cout<<"not opened";return -1;}

    Mat firstFrame;
    cap >> firstFrame;

    Ptr<SURF> detector = SURF::create( 400 );

    std::vector<KeyPoint> keypoints_1;
    // Computing the rectangle

    vector<Point2f> firstCorners;
    firstCorners.push_back(Point2f(24,44));
    firstCorners.push_back(Point2f(24,210));
    firstCorners.push_back(Point2f(196,210));
    firstCorners.push_back(Point2f(196,44));

    // Detecting keypoints
    detector->detect( firstFrame, keypoints_1 );

    for(;;)
    {
        // Defining circle parameters
        Point2f pc;
        pc = 0.25*(firstCorners[0] + firstCorners[1] + firstCorners[2] + firstCorners[3]);
        double R;
        R = 0.5 * norm(firstCorners[0] - firstCorners[1]);

        // Filtering
        std::vector<KeyPoint> keyFiltered_1;
        for(KeyPoint kp:keypoints_1)
            if(norm(kp.pt - pc) < R)
                keyFiltered_1.push_back(kp);

        // Computing firstframe
        Mat descriptors_1;
        detector->compute(firstFrame, keyFiltered_1, descriptors_1);

        Mat nextFrame;
        cap >> nextFrame;

        std::vector<KeyPoint> keypoints_2;
        Mat descriptors_2;

        detector->detectAndCompute(nextFrame, Mat(),keypoints_2, descriptors_2);

        // Matching using FLANN matcher
        FlannBasedMatcher matcher;
        std::vector< DMatch > matches;
        matcher.match( descriptors_1, descriptors_2, matches );


        //-- Draw only "good" matches (i.e. whose distance is less than 3*min_dist )
        std::vector< DMatch > good_matches;

        for( int i = 0; i < matches.size(); i++ )
        { if( matches[i].distance < 0.25 )
           { good_matches.push_back( matches[i]); }
        }

        Mat img_matches;
        drawMatches( firstFrame, keyFiltered_1, nextFrame, keypoints_2,
                     good_matches, img_matches, Scalar::all(-1), Scalar::all(-1),
                     vector<char>(), DrawMatchesFlags::NOT_DRAW_SINGLE_POINTS );

        //-- Localize the object
        std::vector<Point2f> first;
        std::vector<Point2f> next;


        for( int i = 0; i < good_matches.size(); i++ )
        {
          //-- Get the keypoints from the good matches
          first.push_back( keyFiltered_1[ good_matches[i].queryIdx ].pt );
          next.push_back( keypoints_2[ good_matches[i].trainIdx ].pt );
        }

        Mat H = findHomography( first, next, CV_RANSAC );

        // Defining corners of the next image
        std::vector<Point2f> nextCorners(4);

        perspectiveTransform( firstCorners, nextCorners, H);

        line( img_matches, nextCorners[0] + Point2f( firstFrame.cols, 0), nextCorners[1] + Point2f( firstFrame.cols, 0), Scalar(0, 255, 0), 2 );
        line( img_matches, nextCorners[1] + Point2f( firstFrame.cols, 0), nextCorners[2] + Point2f( firstFrame.cols, 0), Scalar( 0, 255, 0), 2 );
        line( img_matches, nextCorners[2] + Point2f( firstFrame.cols, 0), nextCorners[3] + Point2f( firstFrame.cols, 0), Scalar( 0, 255, 0), 2 );
        line( img_matches, nextCorners[3] + Point2f( firstFrame.cols, 0), nextCorners[0] + Point2f( firstFrame.cols, 0), Scalar( 0, 255, 0), 2 );


        imshow( "Good Matches", img_matches );

        waitKey(1);

        pc = 0.25*(nextCorners[0]+nextCorners[1]+nextCorners[2]+nextCorners[3]);
        Point2f dx,dy;
        dx = nextCorners[0] - pc;
        dy.x = dx.y;
        dy.y = -dx.x;
        nextCorners[2] = pc - dx;
        nextCorners[1] = pc - dy;
        nextCorners[3] = pc + dy;

        firstCorners = nextCorners;
        keypoints_1 = keypoints_2;

        firstFrame = nextFrame;
    }

    return 0;
}

