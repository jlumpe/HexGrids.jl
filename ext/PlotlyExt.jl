# The extension only adds methods for functions defined in HexGrids.Plotly

module PlotlyExt

using HexGrids
using PlotlyJS
import HexGrids.Plotly: hex_scatter, hex_plot

export hex_scatter, hex_plot


print("PlotlyExt loaded")


function hex_scatter(a::HexArray, extra=(;); kw...)
	xy = HexGrids.cartesian_array(a.shape)
	trace = scatter(
		mode=:markers,
		x=xy[:, 1],
		y=xy[:, 2],
		marker_color=collect(a),
		text=[string("(", join(CubeIndex(ix), ","), ")") for ix in a.shape],
		hovertemplate="%{text}: %{marker.color}",
	)
	merge!(trace, attr(extra))
	merge!(trace, attr(kw...))
end


function hex_plot(a::HexArray, trace_kw=(;), layout_kw=(;))
	scatter = hex_scatter(a, trace_kw)
	layout = Layout(yaxis=attr(scaleanchor=:x, scaleratio=1))
	merge!(layout, attr(layout_kw))
	return plot([scatter], layout)
end


end  # Module PlotlyExt
