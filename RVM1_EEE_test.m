
% Define the workspace and writing surface
z_plane = 210; % Writing surface Z-coordinate (in mm)
pen_up = z_plane + 50; % Pen lift height for transitions
pen_down = z_plane; % Pen-down position for writing

% Rectangle corners as inputs
cornerA = [0, 0];   % Upper-left corner (x, y)
cornerB = [140, 0]; % Upper-right corner (x, y)

% Define letter "E" writing coordinates in 3D
spacing = 10; % Spacing between letters
letter_width = (cornerB(1) - cornerA(1) - 2 * spacing) / 3; % Fit 3 letters
letter_height = 50; % Height of the letter "E"
bar_width = letter_height / 3; % Width of each bar in "E"

% Helper functions for MJ and OG commands
MJ = @(x, y, z) [x, y, z]; % Move and Jump (pen up)
OG = @(x, y, z) [x, y, z]; % Operate and Go (pen down)

% Generate waypoints for each "E" in 3D
waypoints = [];
for i = 0:2 % Three "E" letters
    start_x = cornerA(1) + spacing + i * (letter_width + spacing);
    waypoints = [
        waypoints;
        MJ(start_x, cornerA(2), pen_up); % Move to start position above the surface
        OG(start_x, cornerA(2), pen_down); % Lower pen to start
        OG(start_x, cornerA(2), pen_down); % Vertical line
        OG(start_x, cornerA(2) + letter_height, pen_down);
        MJ(start_x, cornerA(2) + letter_height, pen_up); % Lift pen
        OG(start_x, cornerA(2) + letter_height, pen_down); % Top horizontal line
        OG(start_x + letter_width, cornerA(2) + letter_height, pen_down);
        MJ(start_x + letter_width, cornerA(2) + letter_height, pen_up); % Lift pen
        OG(start_x, cornerA(2) + letter_height / 2, pen_down); % Middle horizontal line
        OG(start_x + letter_width, cornerA(2) + letter_height / 2, pen_down);
        MJ(start_x + letter_width, cornerA(2) + letter_height / 2, pen_up); % Lift pen
        OG(start_x, cornerA(2), pen_down); % Bottom horizontal line
        OG(start_x + letter_width, cornerA(2), pen_down);
        MJ(start_x + letter_width, cornerA(2), pen_up); % Lift pen
    ];
end

% Simulate the motion in 3D
figure;
plot3(waypoints(:, 1), waypoints(:, 2), waypoints(:, 3), '-o', 'LineWidth', 1.5);
grid on;
xlabel('X-axis (mm)');
ylabel('Y-axis (mm)');
zlabel('Z-axis (mm)');
title('3D Simulation of Three "E" Letters with MJ and OG Commands');
axis equal;
view(3); % Set 3D view angle
