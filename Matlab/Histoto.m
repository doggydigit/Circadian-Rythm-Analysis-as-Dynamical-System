function Histoto
%%HISTOTO Display a GUI permitting the user to change the parameters of the model and see
%these effects on the histogram of the model
%% Constants
slider_thickness = 20;
slider_spacing = 10;
tag_width = 20;
paramval_width = 50;


%% Functions and parameters

t0=0;
ntheta=300;
edges=0:0.015:1;
init_params = [0 27];
dieu{1}={1,'ε',-5 0};
dieu{2}={2,'T',0 50};

% - Check Param List -
n_params2man = numel(dieu);
params2man = zeros(1,n_params2man);
tags = cell(1,n_params2man);
lowers = ones(1,n_params2man).*0.01;
uppers = ones(1,n_params2man);

for i = 1:n_params2man
    this_param = dieu{i};
    n_this_param = numel(this_param);
    
    params2man(i) = this_param{1};
    tags{i} = this_param{2};
    lowers(i) = this_param{3};
    uppers(i) = this_param{4};
end


%% Calculate the initial function value

init_y(1)=t0;
for j=2:ntheta
    init_y(j)=init_y(j-1)+2*pi*init_params(2)/24.5+init_params(1)*sin(init_y(j-1));
end


%% Prepare the figure and axes

monitor_pos = get(0, 'MonitorPositions');

fig_h = figure('CloseRequestFcn',@figureCloseReq_Callback);

% A little trick to make sure the axes is not expanded as the figure
% resizes
axes_h = axes('Parent',fig_h,'Units','pixels');

axes_pos_p = get(axes_h,'Position');

figure_pos = get(fig_h,'Position');

figure_pos(4) =  figure_pos(4) + (n_params2man+1)* (slider_thickness + slider_spacing);

if figure_pos(4) + figure_pos(2) > monitor_pos(4) - 100
    % Make sure that the figure header is always visible
    figure_pos(2) = monitor_pos(4) - figure_pos(4) - 100;
end

set(fig_h, 'Position', figure_pos);


%% Start plotting!!

plot_h = histogram(mod(init_y,2*pi)/(2*pi),edges,'Normalization','pdf');
xlabel('[2π·rad]');
set(axes_h,'XLim', [0 1], 'XLimMode', 'Manual','YLimMode', 'Auto');
set(plot_h,'UserData', init_params);

slider_h = zeros(1,n_params2man);

for i = 1:n_params2man
    % Nicely arrange the sliders and texts
    start_pos = [axes_pos_p(1), axes_pos_p(2) + axes_pos_p(4) + ...
        (n_params2man + 1 - i).*(slider_spacing + slider_thickness)];
    tag_h(i) = uicontrol('style','text','Units','pixels', ...
        'Position',[start_pos, tag_width, slider_thickness], ...
        'String', tags{i});
    slider_h(i) = uicontrol('Style','Slider', ...
        'Position', [start_pos+[tag_width 0] axes_pos_p(3)-(tag_width+paramval_width), slider_thickness], ...
        'Min', lowers(i), ...
        'Max', uppers(i), ...
        'Value', init_params(i));
    paramval_h(i) = uicontrol('style','text','Units','pixels',...
        'Position',[start_pos+[axes_pos_p(3)-paramval_width,0],paramval_width, slider_thickness], ...
        'String', num2str(init_params(i)));
    cur_slider = slider_h(i);
    slider_timer(i) = timer('TimerFcn', {@slider_updater,slider_h(i), i},...
        'ExecutionMode','fixedRate',...
        'Period', 1./20, 'BusyMode', 'queue','UserData',params2man(i));
    
end
start(slider_timer);
set(axes_h, 'Units', 'normalized');

    function slider_updater(obj, event, cur_slider_h, iParam)
        % SLIDER_UPDATER
        % This persistent variable is a relic from the time when
        % slider_updater was still a stand alone function.
        persistent last_slider_value
        if isempty(last_slider_value)
            last_slider_value = zeros(2,1);
        end
        %% Step 1: Get the current value
        cur_slider_value = get(cur_slider_h, 'Value');
        
        %% Step 2: If the slider value is not changed, then do nothing
        if abs(cur_slider_value- last_slider_value(iParam))<10e-10
            return;
        end
        
        last_slider_value(iParam) = cur_slider_value % Store the last slider value
        
        %% Step 3: Do the mathematics
        params = get(plot_h(round(end/2)),'UserData');
        params(iParam) = last_slider_value(iParam);
        y(1)=t0;
        for j=2:ntheta
            y(j)=mod(y(j-1)+2*pi*params(2)/24.5+params(1)*sin(y(j-1)),2*pi);
        end
        
        %% Step 4: Update the graphics
        plot_h = histogram(y/(2*pi),edges,'Normalization','pdf');
        xlabel('[2π·rad]');
        set(axes_h,'XLim', [0 1], 'XLimMode', 'Manual','YLimMode', 'Auto');
        set(plot_h, 'UserData', params);
        set(paramval_h(iParam), 'String', num2str(params(iParam)));
        drawnow;
        
    end


%% Delete the timers when the window is closed
    function figureCloseReq_Callback(obj, event)
        for i = 1:n_params2man
            stop(slider_timer(i));
            delete(slider_timer(i));
        end
        closereq;
    end

end
