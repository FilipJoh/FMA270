function [ e2x ] = createCrossMatrix( y )
    e2x=[0 -y(3) y(2); y(3) 0 -y(1); -y(2) y(1) 0];
end

