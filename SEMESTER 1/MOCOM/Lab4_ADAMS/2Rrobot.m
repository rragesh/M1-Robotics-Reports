function[x,y]=2Rrobot(q1,q2)
l1=0.5;
l2=0.3;
x=l1*cos(q1)+l2*cos(q1+q2);
y=l1*sin(q1)+l2*sin(q1+q2);
end