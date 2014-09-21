load ref.mat;
close all;
clc;

vid = videoinput('winvideo',1);
display('Video object created \m/');
triggerconfig(vid,'manual');
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat', Inf);
vid.ReturnedColorSpace='rgb';


ref_g=rgb2gray(ref);
start(vid);
% figure(1), imshow(ref_g);
COM='COM9';
s = serial(COM,'BaudRate',9600);
fopen(s);

[m n z]=size(ref);
thresh=30;
thresh_bot=0.45;

ball_f=zeros(m,n);      %unfiltered ball
rbot=zeros(m,n);        %unfiltered robot
a=0;
b_f=1;
z=0;
t=0;
for i=1:50
    trigger(vid);
    r=getdata(vid,1);
end
t=tic;

while(a<60)
trigger(vid);
c=getdata(vid,1);
a=a+1;
ball_f=zeros(m,n);
ball=zeros(m,n);
rbot=zeros(m,n);

if (b_f==1)
cs=0;
cb=0;
ct=0;
cp=0;

c_g=rgb2gray(c);
d_image = c_g - ref_g;
    % figure(1), imshow(d_image);
    %sub present image - ref image
i=1;j=1;    
    for i=1:m-1
        for j=1:n-1
             if(d_image(i,j)>thresh)
                if((c(i,j,1)-c(i,j,3))>60 && (c(i,j,1)-c(i,j,2))>60)        %detecting red color
                    ball_f(i,j)=1;
                end
            end
        end
    end
    rbot=im2bw(c_g,thresh_bot);
ball=medfilt2(ball_f,[4 4]);  
[x_b y_b]=find(ball);
[x_r y_r]=find(rbot); 
s_x_b=size(x_b);
if(s_x_b(1) ~= 0)
x_ball=round(mean(x_b));
y_ball=round(mean(y_b));

cb=[y_ball x_ball];
x_bot=round(mean(x_r));
y_bot=round(mean(y_r));

% 
%  figure(1);
% %  imshow(ball_f);
% figure(2);
% imshow(rbot);
rbot_f=medfilt2(rbot,[3 3]);
cc=bwconncomp(rbot_f);
r1=[1 1];
r2=[1 480];
rp=[40 40];
prop=regionprops(cc,'all');
for xx=1:cc.NumObjects
    if (prop(xx).Area>1200)
        cs=round(prop(xx).Centroid);
        flag=xx;
    end
    if(prop(xx).Area>300 && prop(xx).Area<1200)
        ct=round(prop(xx).Centroid);
        flag=xx;
    end
    
end
% if (flag==1)
%     ct=round(prop(2).Centroid);
% else
%     ct=round(prop(1).Centroid);
% end
% distance=cs-cb;
% disp('distance');disp(distance);
disp(cs);
 disp(ct);
 disp(cb);
flag=0;
st=cs-ct;
r=r2-r1;
y=dot(r,st);
stm=sqrt(st(1,1)^2+st(1,2)^2);
rm=sqrt(r(1,1)^2+r(1,2)^2);
sr=stm*rm;
angb=round(acos(y/sr)*180/pi);
if (st(1,1)<0)
    angb=360-angb;
end
disp('angle(in degree) for bot'), disp(angb);
% figure, imshow(bot);
bt=cb-ct;
r=r2-r1;
yb=dot(r,bt);
btm=sqrt(bt(1,1)^2+bt(1,2)^2);
rm=sqrt(r(1,1)^2+r(1,2)^2);
br=btm*rm;
ang_ball=round(acos(yb/br)*180/pi);
if (bt(1,1)<0)
    ang_ball=360-ang_ball;
end
disp('angle(in degree) for ball'), disp(ang_ball);
%figure, imshow(image);
% command=0;
ang_sub=angb-ang_ball;
disp('final_angle');disp(ang_sub);

if(angb<270)
    if(ang_sub<10 && ang_sub>(-10))
        command=1;
elseif(ang_sub>10)
        command=4;
elseif(ang_sub<(-10))
        command=8;
else 
    command=40;
end

else
    
if(ang_sub>350)
        command=1;
    else
    command=8;
    end
end
fwrite(s,command);
disp('command:');disp(command);
else
      z=1;
      b_f=0;
      command=10;
      fwrite(s,command);
      disp('b_f:');disp(b_f);
      disp('command:');disp(command);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(z==1)
f_1=0;
f_2=0;
f_3=0;
f_4=1;
while(z==1)
trigger(vid);
c=getdata(vid,1);
rbot=zeros(m,n);
cs=0;
ct=0;
cp=0;
c_g=rgb2gray(c);
d_image = c_g - ref_g;

[x_r y_r]=find(rbot); 
x_bot=round(mean(x_r));
y_bot=round(mean(y_r));
rbot=im2bw(c_g,thresh_bot);
rbot_f=medfilt2(rbot,[3 3]);
figure(1);
imshow(rbot_f);
cc=bwconncomp(rbot_f);
r1=[1 1];
r2=[1 480];
rp=[40 40];
prop=regionprops(cc,'all');
for xx=1:cc.NumObjects
    if (prop(xx).Area>900)
        cs=round(prop(xx).Centroid);
        flag=xx;
    end
    if(prop(xx).Area>300 && prop(xx).Area<900)
        ct=round(prop(xx).Centroid);
        flag=xx;
    end
    
end
disp(cs);
disp(ct);
flag=0;
st=cs-ct;
r=r2-r1;
y=dot(r,st);
stm=sqrt(st(1,1)^2+st(1,2)^2);
rm=sqrt(r(1,1)^2+r(1,2)^2);
sr=stm*rm;
angb=round(acos(y/sr)*180/pi);
if (st(1,1)<0)
    angb=360-angb;
end
disp('angle(in degree) for bot'), disp(angb);
if(f_4==1)  
if(~(angb>175 && angb<185))
              command=8;    
   else
       f_1=1;
   end
  if(f_1==1)
  if(cs(2)>100)
      if(angb < 175)
               command=8;
           elseif (angb>185)
               command=4;
           else
               command=1;
      end   
  else
       f_2=1;
       f_1=0;
  end
  end
  end
  if(f_2==1)
      f_4=0;
   if(~(angb >(268)) && (angb <(272) ))    
               command=8;
   else
       f_3=1;
       f_2=0;
   end
  end
  if(f_3==1)
      if(cs(1)>100)
           if(angb < 260 )
               command=4;
           elseif (angb>280)
               command=8;
           else
               command=1;
           end
      else
          command=11;
          z=0;
      end
  end
  fwrite(s,command);
end
end
end
fclose(s);
stop(vid);
