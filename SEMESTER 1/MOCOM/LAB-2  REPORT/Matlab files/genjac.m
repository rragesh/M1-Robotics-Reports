function J = genjac (sigma, alpha, d, theta, r,q)
n=length(sigma);
P=zeros(3,n);
a=zeros(3,n);
T=eye(4); 
J = zeros(6,n);
for k=1:n
     T = T*TRANSMAT(alpha(k),d(k),theta(k),r(k));   
     P(1:3,k)=T(1:3,4);
     a(1:3,k)=T(1:3,3);
end


for k=1:n
     J(:,k) = [sigma(k).*a(:,k) + ~sigma(k).*cross(a(:,k),(P(:,6)-(P(:,k))));
         ~sigma(k).*a(:,k)];

end

end
