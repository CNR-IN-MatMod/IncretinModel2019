function [secmod_IE,irp,r] = secsim_IE(varargin)
% secmod_IE = secsim_IE(p,ca,glu,Kincr) calculates insulin secrection  with the incretin effect,
% given the parameter p, calcium, glucose and the time-dependent values of Kincr.

% secmod_IE = secsim_IE(p1,ca1,glu1,Kincr1,p2,ca2,glu2,Kincr2,...) calculates insulin 
% secrection (secmod_IE) with the model for multiple time series.

% [secmod, irp, r]=secsim(p,ca,glu) calculates insulin secrection (secmod),
% immediately releasable pool (irp) and refilling (r) with the model,
% given the parameter p, calcium and glucose.

% [secmod, irp, r]=secsim(p1,ca1,glu1,p2,ca2,glu2,...) calculates insulin 
% secrection (secmod), immediately releasable pool (irp) and refilling (r)
% with the model for multiple time series.

if rem(nargin,4)~=0
    error('The number of arguments must be a multiple of 4')
end
nsim=nargin/4;


  

    

    for k=1:nsim
      base=4*(k-1);
    
      % time, calcium, glucose and kincr for the k-th time series
      paux.t=varargin{base+2}.t';
      paux.c=varargin{base+2}.v';
      paux.g=varargin{base+3}.v';
      paux.k=varargin{base+4}.v';
    
      % simulates on the calcium/glucose time grid
      simvar=betasim_IE(varargin{base+1},paux.t,paux);
    
      % assign secretion to output
      secmod_IE(k).t=paux.t';
      secmod_IE(k).v=simvar(3,:); % secretion is the 3rd variable
    
      % assign irp to output
      irp(k).t=paux.t';
      irp(k).v=simvar(4,:); % immediately releasable pool (irp) is the 4th variable
    
      % assign refilling to output
      r(k).t=paux.t';
      r(k).v=simvar(5,:); % refilling is the 5th variable
    end

