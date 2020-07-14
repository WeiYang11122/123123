function processImage( readpath, writepath, params)

I = imread( readpath);
W = params.W;

s = size(I);
[V i j] = unique( 255-reshape( I, [s(1)*s(2) s(3)]), 'rows');
V = unique(V,'rows');


H = findH( V, W);



imwrite( H, writepath, 'comment', readpath);


return
