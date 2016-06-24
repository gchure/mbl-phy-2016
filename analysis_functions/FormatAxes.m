function ax = FormatAxes(F)
% FORMATAXES formats the axes in the style of PBoC.
% ax = FORMATAXES(F) formats the axes of figure F with the appropriate font,
% color, and white inward-facing ticks.
ax = gca;
ax.FontName = 'Lucida Sans Unicode';
ax.Color = [224/255, 217/255, 201/255];
axcop = copyobj(ax, F);
set(axcop, 'Xcolor', [1 1 1], 'Ycolor', [1 1 1],'XTickLabel',[],'YTickLabel',[], 'TickLength', [0.01 0.8]); 
end
