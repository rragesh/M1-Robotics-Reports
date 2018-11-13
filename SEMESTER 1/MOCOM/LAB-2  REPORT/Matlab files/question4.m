L1 = 0.5;
L2 = 0.4;
q1min=-2.6;
q1max=2.8;
q2min=-2.6;
q2max=2.8;
for q1=q1min:0.05:q1max;
 for q2=q2min:0.05:q2max;
   q=[q1,q2];
   X=DGM2R(L1,L2,q); 
   x1=[x1,X(1)];
   x2=[x2,X(2)];
 end
end


%JOINT SPACE
t=q1min:0.05:q1max;
figure(1);
jointspace = plot(t,q1min*ones(size(t)), t,q1max*ones(size(t)),q2min*ones(size(t)),t,q2max*ones(size(t)),t);
xlabel('Joint Q1');ylabel('Joint Q2')

%WORK SPACE
figure(2);
plot(x1,x2);
xlabel('X1');ylabel('X2')


