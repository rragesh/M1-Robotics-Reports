function T = TRANSMAT(a,d,t,r)

T = [cos(t) -sin(t) 0 d;
     cos(a)*sin(t), cos(a)*cos(t), -sin(a), -r*sin(a);
    sin(a)*sin(t), sin(a)*cos(t), cos(a), r*cos(a);
    0 0 0 1];
end