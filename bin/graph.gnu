#!/usr/bin/gnuplot
set key outside
set yrange [4:]
set style line 1 lw 14 ps 4
set style line 2 lw 14 ps 4
#plot for [col=1:2] 'power-history' using 0:col with lines
set logscale y 8
plot  '/tmp/signal-history' using 1:2 title "connectivity" with lines,\
      '/tmp/signal-history' using 1:3 title "SNR downstream" with lines,\
      '/tmp/signal-history' using 1:4 title "SNR upstream" with lines,\
      '/tmp/signal-history' using 1:5 title "db downstream" with lines,\
      '/tmp/signal-history' using 1:6 title "db upstream" with lines
pause 1
reread
