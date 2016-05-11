% Draw the skeletons of the words
ml = stroke("t200/ml.png");
algo = stroke("t200/algo.png");

% Align two images
left_ml = min(ml(:, 1));
right_ml = max(ml(:, 1));
central_x = (left_ml + right_ml)/2;
left_algo = min(algo(:, 1));
right_algo = max(algo(:, 1));
x_shift = central_x - (left_algo + right_algo)/2;
algo(:, 1) = algo(:, 1) + x_shift;

floor_ml = min(ml(:, 2));
ceil_ml = max(ml(:, 2));
height = ceil_ml - floor_ml;
algo(:, 2) = algo(:, 2) - height * 1.2;

% Add some uniform noise
[final_ml final_algo] = noise(ml, algo);

% The coefficients learned from a logistic regression engine
% Generate a line for the decision boundary
theta = [ 8.3257e+000
  8.3312e-004
  6.0178e-002];
line_x = [-100; 1000];
line_y = [-(theta(1) - 100 * theta(2))/theta(3); -(theta(1) + 1000 * theta(2)  )/theta(3)];
radius = 8;
plot(final_ml(:, 1), final_ml(:, 2), 'o', "linewidth", 0, "markersize", radius, final_algo(:, 1), final_algo(:, 2), 'd', "markersize", radius, "linewidth", 0, line_x, line_y, '-', "linewidth", 4);
h = legend("Positive", "Negative", "Decision boundary");
set(h, "fontsize", 20);
mkdir out;
print -deps out/mla.eps;

% Native octave plotting sucks. Write CSV files for better plotting.
line_mat = [line_x line_y];
save("-ascii", "out/final_ml.dat", "final_ml");
save("-ascii", "out/final_algo.dat", "final_algo");
save("-ascii", "out/boundary.dat", "line_mat");
