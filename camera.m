vid = videoinput('winvideo', 1, 'MJPG_640x480')
set(vid,'TriggerRepeat',Inf);
   vid.FrameGrabInterval = 1;
   pause(1);
   start(vid);
   data = getdata(vid,1);
   img = data(:,:,:,1);
   image(img);
   stop(vid);
   
imwrite(img,'previous.png');
