% Draw the skeleton of an image with some Gaussian noise
function points = stroke(fname)
  a = imread(fname);
  [m n tmp] = size(a);
  b = zeros(m, n);
  for ii = 1:m
    for jj = 1:n
      b(ii, jj) = (a(ii, jj, 1) + a(ii, jj, 2) + a(ii, jj, 3))/3;
    end
  end
   
  ave = mean(mean(b));
  [x, y] = find(b < ave);
  num_black_cells = length(x);
  % Tweek these values to changes the style.
  sigma = m * .027;
  sample_rate = 4;
  num_points = num_black_cells * sample_rate;
  crop = @(val, bound) int16(max(min(val, bound), 1));

  points = zeros(num_points, 2);
  for nn = 1:num_points
    p = ceil(rand() * num_black_cells);
    p_x = x(p);
    p_y = y(p);
    d_x = p_x + randn() * sigma;
    d_y = p_y + randn() * sigma;  
    points(nn, 2) = -d_x;
    points(nn, 1) = d_y; 
  end  
endfunction
