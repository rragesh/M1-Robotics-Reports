
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <vector>
using namespace cv;
using std::vector;
const double GRAD_THRESH = 0.05;

int main( )
{
    //reading gray scaled image
    Mat_<uchar> img = imread("img.jpg",0);
    imshow("image", img);
    //waitKey();
    const int N_PHI = 200;
    const int N_RHO = 500;
    const double RHO_MAX = sqrt( img.rows * img.rows + img.cols * img.cols );


    const int V_acc = 200;
    bool is_max;
    vector <int> i_phi_vec;
    vector <int> i_rho_vec;



    //detect brightness transitions
    Mat_<float>gx,gy,gabs2;
    double K = 1.0/8/256;
    Sobel(img, gx, CV_32F, 1, 0, 3, K);
    Sobel(img, gy, CV_32F, 0, 1, 3, K);
    gabs2 = gx.mul(gx) + gy.mul(gy);

    imshow("image gradient", gabs2);
    waitKey();

    Mat_<uint16_t> acc(N_RHO, N_PHI);
    acc.setTo(0);
    for( int y=0; y<img.rows; y++ )
    {
        for(int x=0; x<img.cols; x++)
        {
            if(gabs2(y,x) < GRAD_THRESH)
                continue;
            for(int i_phi=0; i_phi < N_PHI; i_phi++)
            {
                double phi = (i_phi*M_PI)/N_PHI;
                double rho = x*cos(phi)+y*sin(phi);
                int i_rho = ((rho + RHO_MAX)*( N_RHO / ( 2 * RHO_MAX )));
                if( i_rho<0 or i_rho>=N_RHO)
                    continue;
                acc(i_rho,i_phi)++;
            }
        }
    }


    for( int i_rho = 0; i_rho < N_RHO; i_rho++ )
    {
        for ( int i_phi = 0;i_phi < N_PHI; i_phi++)
        {
            if(acc(i_rho, i_phi)< V_acc)
                continue;
            is_max = true;

            for(int del_iphi = 0; del_iphi < N_PHI; del_iphi++)
            {
                for(int del_irho = 0; del_irho < N_RHO; del_irho++)
                {
                    if( del_iphi == 0 and del_irho == 0 );
                    continue;
                    int j_phi = i_phi + del_iphi;
                    int j_rho = i_rho + del_irho;
                    if( j_phi<0)
                    {

                        j_phi += N_PHI;
                        j_rho = N_RHO - j_rho;
                    }
                    if(j_phi>=N_PHI)
                    {
                        j_phi -= N_PHI;
                        j_rho = N_RHO - j_rho;
                    }
                    if(acc(i_rho,i_phi) <= acc(j_rho,j_phi))
                    {
                        is_max=false;
                    }
                     if(is_max)
                    {
                        i_phi_vec.push_back(i_phi);
                        i_rho_vec.push_back(i_rho);
                    }

                }
            }
        }
    }

    Mat_<uchar> maxima(N_RHO, N_PHI);
    maxima.setTo(0);

    for( int k = 0; k < i_phi_vec.size(); k++ )
    {
       //maxima(i_rho,i_phi) = 255;

    }

    imshow("Accumulator", acc*300);
   imshow("Maxima", maxima*300);
    waitKey();
    return 0;
}
