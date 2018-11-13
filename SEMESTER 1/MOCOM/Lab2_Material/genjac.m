function J = genjac (sigma, alpha, d, theta, r, q)
n=length(sigma);
P=zeros(3,n);
a=zeros(3,n);
T=eye(4); % this is important. Don't write zeros(4)
J = zeros(6,n);
for k=1:n
    if sigma == 1
     T = T*TRANSMAT(alpha(k),d(k),theta(k),q(k));   
    else
     T = T*TRANSMAT(alpha(k),d(k),q(k),r(k));
      
    end
    
     P(1:3,k)=T(1:3,4);
     a(1:3,k)=T(1:3,3);
     
end
for k=1:n
    J(:,k) = [sigma(k).*a(1:3,k) + ~sigma(k).*cross(a(1:3,k),(P(1:3,6)-(P(1:3,k))));
         ~sigma(k).*a(1:3,k)];
   
    
end

end
