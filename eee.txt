% Define waypoints for "E"
waypoints = [0 0 0; 50 0 0; 0 40 0; 30 40 0; 0 80 0; 50 80 0];

% Initialize transformation matrices
T_matrices = zeros(4, 4, size(waypoints, 1)); % Store 4x4 matrices

% Manually create transformation matrices (translation only)
for i = 1:size(waypoints, 1)
    x = waypoints(i, 1);
    y = waypoints(i, 2);
    z = waypoints(i, 3);

    % Construct the homogeneous transformation matrix
    T = eye(4); % Start with an identity matrix
    T(1:3, 4) = [x; y; z]; % Add translation part
    T_matrices(:, :, i) = T; % Store matrix
end

% Plot the waypoints in 3D
figure;
hold on;

% Plot waypoints as points
for i = 1:size(waypoints, 1)
    % Extract translation from the transformation matrix
    x = T_matrices(1, 4, i);
    y = T_matrices(2, 4, i);
    z = T_matrices(3, 4, i);

    % Plot the waypoint
    plot3(x, y, z, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    text(x, y, z, ['P' num2str(i)], 'VerticalAlignment', 'bottom'); % Label point
end

% Connect waypoints to form lines
for i = 1:(size(waypoints, 1) - 1)
    % Extract translations of consecutive waypoints
    x1 = T_matrices(1, 4, i); x2 = T_matrices(1, 4, i+1);
    y1 = T_matrices(2, 4, i); y2 = T_matrices(2, 4, i+1);
    z1 = T_matrices(3, 4, i); z2 = T_matrices(3, 4, i+1);

    % Plot a line between the consecutive waypoints
    plot3([x1 x2], [y1 y2], [z1 z2], 'b-', 'LineWidth', 1.5);
end

% Add labels and grid for better visualization
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
grid on;
title('Waypoints for Writing EEE');
hold off;
