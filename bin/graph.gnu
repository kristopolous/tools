#!/usr/bin/gnuplot
set xlabel "X" textcolor rgb "white"
set ylabel "Y" textcolor rgb "white"
set xtics textcolor rgb "white"
set ytics textcolor rgb "white"
set key textcolor rgb "white"
set border lw 1 lc rgb "white"
set key outside
set yrange [2.8:]
#plot for [col=1:2] 'power-history' using 0:col with lines
set logscale y 2 

plot  '/tmp/signal-history' using 1:2 title "ping" with lines ,\
      '/tmp/signal-history' using 1:3 title "SNR down" with lines lw 2,\
      '/tmp/signal-history' using 1:4 title "SNR up" with lines,\
      '/tmp/signal-history' using 1:5 title "db down" with lines,\
      '/tmp/signal-history' using 1:6 title "db up" with lines
pause 1
reread
