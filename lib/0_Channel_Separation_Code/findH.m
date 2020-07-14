function H = findH( V, W)
%W = W.W;
H = single(V)*pinv(single(W));
H = H - min(H(:));
H = H / max(H(:))*255;
H = uint8(round(H));
