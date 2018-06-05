function Ex10_to_15
%%Display a GUI permitting the user to change the parameters of the model and see
%%these effects on the phase portrait of the model
%
% Stellari Studio, 2012
% Mingjing Zhang, Vision and Media Lab @ Simon Fraser University
% Modified by Nathalie Meyer and Matthias Tsai @ EPFL

%% Constants
slider_thickness = 20;
slider_spacing = 10;
tag_width = 100;
paramval_width = 50;


%% Functions and parameters
    function [a]=mathfunc(y,p)
        a(1,:)=(-1*p(2)+sqrt(p(2)^2 +4*y.*(-1*y.^3+p(1)*y+p(3))))./(2*y);
        a(2,:)=(p(3)+ p(2) - sqrt(p(2).^2 +4.*y.* (-y.^3 + p(1).*y))-p(3))./(2.*y);
        a(3,:)=(p(3) +p(2) + sqrt(p(2).^2 +4.*y.* (-y.^3 + p(1).*y))-p(3))./(2.*y);
        a(4,:)=(-1*p(2)-sqrt(p(2)^2 +4*y.*(-1*y.^3+p(1)*y+p(3))))./(2*y);
    end

x = linspace(-2,2,101);
init_params = [1 0.6 0.5];
dieu{1}={1,'μ',-5 50};
dieu{2}={2,'∆',-0.8 0.8};
dieu{3}={3,'F',0 1};

XLim = [-2 2];
YLim = [-2 2];
LimMode = 'Manual';

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

init_y = CheckImagine(mathfunc(x, init_params));


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

plot_h = plot(x, init_y(1,:),x, init_y(4,:),init_y(3,:),x,init_y(2,:),x);


set(axes_h,'XLim', XLim, 'XLimMode', LimMode, 'YLim', YLim, 'YLimMode', LimMode);

set(plot_h,'UserData', init_params);
hold on;
Vf(init_params);
hold on;
Pf(init_params(1),init_params(2),init_params(3));

hold off;
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
            last_slider_value = zeros(3,1);
        end
        %% Step 1: Get the current value
        cur_slider_value = get(cur_slider_h, 'Value');
        
        %% Step 2: If the slider value is not changed, then do nothing
        if abs(cur_slider_value- last_slider_value(iParam))<10e-10
            return;
        end
        
        last_slider_value(iParam) = cur_slider_value % Store the last slider value
        
        %% Step 3: Do the mathematics
        x=linspace(-2,2,101);
        params = get(plot_h(end/2),'UserData');
        params(iParam) = last_slider_value(iParam);
        y = CheckImagine(mathfunc(x, params));
        
        %% Step 4: Update the graphics
        
        
        plot_h = plot(x, y(1,:),'r',x, y(4,:),'r',y(3,:),x,'r',y(2,:),x,'r');
        set(plot_h, 'UserData', params);
        hold on;
                Vf(params);
                hold on
        Pf(params(1),params(2),params(3));

        set(axes_h,'XLim', XLim, 'XLimMode', LimMode, 'YLim', YLim, 'YLimMode', LimMode);
        set(paramval_h(iParam), 'String', num2str(params(iParam)));
        drawnow;
        hold off;
        
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


