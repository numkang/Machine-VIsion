function plot_HW2_3c(XY, xy, TITLE)
    % For plotting a graph for hw 2 problem 3c
    
    offset = 0.1; % shift the overlaying text

    for i = 1:size(XY,2) % plot them
        j = i+1;
        if j == size(XY,2)+1
            j = 1;
        end
        
        if strcmp(TITLE,'Original')
            plot([XY(1,i) XY(1,j)],[XY(2,i) XY(2,j)],'--c.');
            txt = sprintf('%d', i);
            text(XY(1,i)+offset, XY(2,i)+offset, txt);
        else
            plot([XY(1,i) XY(1,j)],[XY(2,i) XY(2,j)],'-b.');
        end
        hold on
    end
    
    for i = 1:size(xy,2) % plot them
        j = i+1;
        if j == size(xy,2)+1
            j = 1;
        end
     
    if strcmp(TITLE,'Original')
        plot([xy(1,i) xy(1,j)],[xy(2,i) xy(2,j)],'-m.');
        txt = sprintf('%d', i);
        text(xy(1,i)+offset, xy(2,i)+offset, txt);
    else
        plot([xy(1,i) xy(1,j)],[xy(2,i) xy(2,j)],'-r.');
    end
        hold on
    end
    
    axis square
    xlabel('X')
    ylabel('Y')
    title(TITLE);
end