% Add uniform random noise
function [m a] = noise(ml, algo)
  noise_ratio = .05;
  west = min(min(ml(:,1)), min(algo(:,1)));
  east = max(max(ml(:,1)), max(algo(:,1)));
  north = max(max(ml(:,2)), max(algo(:,2)));
  south = min(min(ml(:,2)), min(algo(:,2)));
  height = north - south;
  width = east - west;
  south = south - height * .1;
  north = north + height * .1;
  east = east + width * .1;
  west = west - width * .1;
  ext = int32(length(ml(:, 1)) * noise_ratio);
  m = [ml; zeros(ext, 2)];
  for ii = length(ml(:,1)) + 1:length(m(:,1))
    nx = west + (east - west) * rand();
    ny = south + (north - south) * rand();
    m(ii, 1) = nx;
    m(ii, 2) = ny;
  end
  ext = int32(length(algo(:, 1)) * noise_ratio);
  a = [algo; zeros(ext, 2)];
  for jj = length(algo(:,1)) + 1:length(a(:,1))
    nx = west + (east - west) * rand();
    ny = south + (north - south) * rand();
    a(jj, 1) = nx;
    a(jj, 2) = ny;
  end
endfunction
