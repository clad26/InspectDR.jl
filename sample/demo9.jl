#Demo 9: Waveforms with NaN
#-------------------------------------------------------------------------------
using InspectDR
using Colors

#==Input
===============================================================================#

#Constants
#-------------------------------------------------------------------------------
black = RGB24(0, 0, 0)
white = RGB24(1, 1, 1)
red = RGB24(1, 0, 0)
green = RGB24(0, 1, 0)
blue = RGB24(0, 0, 1)


#Input data
#-------------------------------------------------------------------------------
npts = 1000
T=.1e-6 #Clock period
x = collect(linspace(0, 1e-6, npts))
y = sin(2pi*(x./T))

#Invalidate some data points:
#NOTE: Cannot use F1-acceleration when x has NaN values
x[200] = y[200] = NaN #Causes break
x[400] = NaN
y[500] = NaN

for i in 800:900
	y[i] = NaN
end


#==Generate plot
===============================================================================#
mplot = InspectDR.Multiplot(title="Waveforms with NaN")
mplot.ncolumns = 1

plot = add(mplot, InspectDR.Plot2D())
strip = plot.strips[1]
	plot.xscale = InspectDR.AxisScale(:lin)
	strip.yscale = InspectDR.AxisScale(:lin)

	plot.displayNaN = true
	a = plot.annotation
		a.title = "Transient Data"
		a.xlabel = "Time (s)"
		a.ylabels = ["Voltage (V)"]

	wfrm = add(plot, x, y)
	wfrm.line = line(color=blue, width=3)

gplot = display(InspectDR.GtkDisplay(), mplot)

:DONE
