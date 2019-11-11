% improvement one, epsilon
function sig = sigma(u_xi,u_xj, N)
epsilon=(sqrt(6/7))*(u_xi-(sum(u_xj)/6));
sig=sum(epsilon.^2)/(N);
end;
