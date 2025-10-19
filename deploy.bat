@echo off
set SRC=src\FrontServlet.java
set JAR=framework.jar
set LOCAL_LIB=..\Test\Webapp\WEB-INF\lib
set TOMCAT_WEBAPPS=C:\xampp\tomcat\webapps
set APP_NAME=Sprint

rem Crée le dossier lib local si il n'existe pas
if not exist %LOCAL_LIB% mkdir %LOCAL_LIB%

rem Compilation avec la bibliothèque Jakarta
javac -cp "%LOCAL_LIB%\jakarta.servlet-api-6.0.0.jar" %SRC%

rem Crée la structure de package pour le JAR
if not exist framework mkdir framework
copy src\FrontServlet.class framework\
jar cvf %LOCAL_LIB%\%JAR% framework\FrontServlet.class

rem Crée la structure de l'application dans Tomcat
if not exist "%TOMCAT_WEBAPPS%\%APP_NAME%" mkdir "%TOMCAT_WEBAPPS%\%APP_NAME%"
if not exist "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF" mkdir "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF"
if not exist "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\lib" mkdir "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\lib"

rem Copie le web.xml
copy "..\Test\Webapp\WEB-INF\web.xml" "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\"

rem Copie le JAR de l'application
copy "%LOCAL_LIB%\%JAR%" "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\lib\"

rem Copie la bibliothèque Jakarta
copy "%LOCAL_LIB%\jakarta.servlet-api-6.0.0.jar" "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\lib\"

rem Copie tous les fichiers JSP
echo Copie des fichiers JSP...
for %%f in ("..\Test\Webapp\*.jsp") do (
    echo Copie de %%f
    copy "%%f" "%TOMCAT_WEBAPPS%\%APP_NAME%\"
)

rem Copie tous les fichiers HTML
echo Copie des fichiers HTML...
for %%f in ("..\Test\Webapp\*.html") do (
    echo Copie de %%f
    copy "%%f" "%TOMCAT_WEBAPPS%\%APP_NAME%\"
)

rem Nettoyage
del src\FrontServlet.class
rmdir /s /q framework

echo.
echo Déploiement terminé !
echo.
