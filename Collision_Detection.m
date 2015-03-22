function [collisions] = Collision_Detection(particleArray,systemWidth,systemHeight)

% number of particles
n_particles = length(particleArray);

%number of cells (arbitrary)
n_cells = 25;
n_columns = sqrt(n_cells);
n_rows = sqrt(n_cells);
%dimension of one cell
dx = systemWidth / n_columns;
dy = systemHeight / n_rows;

AABB_array = CreateAABBArray(particleArray);
AABB_size = length(AABB_array);

cell_id = zeros(n_particles,5);
index = 1;
for ii = 1:4:AABB_size
    cell_id(index,1) = AABB_array(ii,3);
    %UPPER LEFT
    x_cur = AABB_array(ii,1);
    y_cur = AABB_array(ii,2);
    if x_cur <= 0 || x_cur >= systemWidth || y_cur <=0 || y_cur >= systemHeight

    else
        column_num = ceil(x_cur / dx);
        row_num = n_rows - floor(y_cur / dy);

        cell_num = (column_num - 1) * n_rows + row_num;
        cell_id(index,2) = cell_num;
        %BOTTOM LEFT
        x_cur = AABB_array(ii+1,1);
        y_cur = AABB_array(ii+1,2);

        column_num = ceil(x_cur / dx);
        row_num = n_rows - floor(y_cur / dy);

        cell_num = (column_num - 1) * n_rows + row_num;
        cell_id(index,3) = cell_num;
        %UPPER RIGHT
        x_cur = AABB_array(ii+2,1);
        y_cur = AABB_array(ii+2,2);

        column_num = ceil(x_cur / dx);
        row_num = n_rows - floor(y_cur / dy);

        cell_num = (column_num - 1) * n_rows + row_num;
        cell_id(index,4) = cell_num;
        %BOTTOM RIGHT
        x_cur = AABB_array(ii+3,1);
        y_cur = AABB_array(ii+3,2);

        column_num = ceil(x_cur / dx);
        row_num = n_rows - floor(y_cur / dy);

        cell_num = (column_num - 1) * n_rows + row_num;
        cell_id(index,5) = cell_num;
    end
    index = index + 1;

end

ss = size(cell_id);
ll = ss(1);
broad_phase_collisions = cell(n_cells,1);
for jj = 1:ll
    search_array = cell_id(:,2:end);
    search_row = search_array(jj,:);
    for iii = search_row
        if iii > 0 && iii <= n_cells
            x = broad_phase_collisions{iii};
            if any(x == jj) == 0
                a = horzcat(x,jj);
                broad_phase_collisions{iii} = a;
            end
        end
    end
end

collisions = [];
%NOW AT THIS POINT, BROAD_PHASE_COLLISIONs HOLDs ALL BROAD PHASE COLLISIONS
for kk = 1:length(broad_phase_collisions)
    cur_test = broad_phase_collisions{kk};
    if length(cur_test) > 1
        %test for exact collision
        for aa = 1:length(cur_test)
            for bb = aa+1:length(cur_test)
                first_pos = [particleArray(cur_test(aa)).x particleArray(cur_test(aa)).y];
                second_pos = [particleArray(cur_test(bb)).x particleArray(cur_test(bb)).y];
                d = sqrt((first_pos(1) - second_pos(1))^2 + (first_pos(2) - second_pos(2))^2);
                if d < particleArray(cur_test(aa)).r + particleArray(cur_test(bb)).r
                    collisions = [collisions; particleArray(cur_test(aa)) particleArray(cur_test(bb))];
                end
            end
        end
    end
end
