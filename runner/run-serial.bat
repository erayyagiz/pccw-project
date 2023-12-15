FOR %%A IN ("%~dp0.") DO SET folder=%%~dpA
FOR %%A IN ("%~dp0.") DO CD %%~dpA
echo 'First running is started...'
robot --outputdir Results --include FRONTENDANDLOGIN .\tests\
del .\Results\*.png /S /Q
echo 'First running is completed...'
echo 'Re-running is started...'
robot --rerunfailed .\Results\output.xml --outputdir run2 .\tests\
echo 'Re-running is completed...'
echo 'Result file is being generated...'
rebot --output output.xml --outputdir Results --merge .\Results\output.xml .\run2\output.xml
move .\run2\*.png .\Results\
rmdir run2 /S /Q
echo 'Results file is ready...'