% Define waypoints for "E"
waypoints = [0 0 0; 50 0 0; 0 40 0; 30 40 0; 0 80 0; 50 80 0];

% Initialize an empty array to store transformation matrices
T_matrices = zeros(4, 4, size(waypoints, 1));

% Generate transformation matrices for each waypoint
for i = 1:size(waypoints, 1)
    x = waypoints(i, 1);
    y = waypoints(i, 2);
    z = waypoints(i, 3);
    T = transl(x, y, z); % Create the transformation matrix (position only)
    T_matrices(:, :, i) = T; % Store the matrix
end

% Plot the waypoints using trplot
figure;
hold on;
for i = 1:size(T_matrices, 3)
    trplot(T_matrices(:, :, i), 'frame', num2str(i), 'color', 'b', 'length', 10); % Plot each matrix
end
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Waypoints for Writing EEE');
grid on;
hold off;