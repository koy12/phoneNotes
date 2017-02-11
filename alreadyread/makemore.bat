@echo off
for %%A in (*.vnt) do echo %%A & for %%B in (1 2 3 4 5 6 7 8 9 0) do copy %%A %%B%%A

Pause