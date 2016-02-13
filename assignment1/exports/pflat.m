function [ Cartesian ] = pflat( Homo )
%Tranforms Homogeneous coordinates to cartesian coordinates
    Cartesian=Homo./Homo(end);
end

