FOR %%A IN ("%~dp0.") DO SET folder=%%~dpA
FOR %%A IN ("%~dp0.") DO CD %%~dpA
echo 'First running is started...'
pabot --outputdir Results --include FRONTEND .\tests\Frontend\*.robot
rebot --outputdir Results --output output.xml --merge .\Results\pabot_results\*\output.xml
rmdir .\Results\pabot_results /S /Q
del .\Results\*.png /S /Q
echo 'First running is completed...'
echo 'Re-running is started...'
pabot --rerunfailed .\Results\output.xml --outputdir run2 .\tests\Frontend\*.robot
rebot --outputdir run2 --output output.xml --merge .\run2\pabot_results\*\output.xml
rmdir .\run2\pabot_results /S /Q
rebot --outputdir Results --output output.xml --merge .\Results\output.xml  .\run2\output.xml
move .\run2\*.png .\Results\
rmdir run2 /S /Q
echo 'Re-running is completed... You can find the results in the Result file.'
