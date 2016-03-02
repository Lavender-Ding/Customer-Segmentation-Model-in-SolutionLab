function p = p_single(x, mu, sigma)  
  
%返回高斯函数的值  
  
 [dim,N]=size(x);  
 p=zeros(1,N);  
 for i=1:N  
     p(i)= 1/(2*pi*abs(det(sigma)))^(length(mu)/2)*exp(-0.5*(x(:,i)-mu)'*inv(sigma)*(x(:,i)-mu));  
 end  