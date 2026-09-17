param([string]$TomcatHome = 'C:\apache-tomcat-10.1.59', [switch]$Deploy)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$javaBin = 'C:\Program Files\Java\jdk-11\bin'
$stage = Join-Path $projectRoot 'target\TallerS6s12'
$libs = Join-Path $projectRoot '.dependencies'
New-Item -ItemType Directory -Force -Path $stage,$libs,(Join-Path $stage 'WEB-INF\classes'),(Join-Path $stage 'WEB-INF\lib') | Out-Null
$dependencies = @{
  'jakarta.servlet.jsp.jstl-api-3.0.0.jar' = 'https://repo.maven.apache.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar'
  'jakarta.servlet.jsp.jstl-3.0.1.jar' = 'https://repo.maven.apache.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.1/jakarta.servlet.jsp.jstl-3.0.1.jar'
}
foreach ($entry in $dependencies.GetEnumerator()) {
  $destination = Join-Path $libs $entry.Key
  if (!(Test-Path $destination)) { Invoke-WebRequest -UseBasicParsing $entry.Value -OutFile $destination }
  Copy-Item -LiteralPath $destination -Destination (Join-Path $stage 'WEB-INF\lib') -Force
}
$bootstrap = Join-Path $projectRoot 'src\main\webapp\assets\bootstrap.min.css'
if (!(Test-Path $bootstrap)) { Invoke-WebRequest -UseBasicParsing 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' -OutFile $bootstrap }
Copy-Item -Path (Join-Path $projectRoot 'src\main\webapp\*') -Destination $stage -Recurse -Force
$sources = @(Get-ChildItem (Join-Path $projectRoot 'src\main\java') -Recurse -Filter '*.java' | ForEach-Object FullName)
& (Join-Path $javaBin 'javac.exe') --release 11 -encoding UTF-8 -cp (Join-Path $TomcatHome 'lib\servlet-api.jar') -d (Join-Path $stage 'WEB-INF\classes') $sources
if ($LASTEXITCODE -ne 0) { throw 'Falló la compilación de Java.' }
$war = Join-Path $projectRoot 'target\TallerS6s12.war'
& (Join-Path $javaBin 'jar.exe') --create --file $war -C $stage .
if ($LASTEXITCODE -ne 0) { throw 'Falló la creación del WAR.' }
if ($Deploy) { Copy-Item -LiteralPath $war -Destination (Join-Path $TomcatHome 'webapps\TallerS6s12.war') -Force }
Write-Output "WAR generado: $war"
if ($Deploy) { Write-Output 'Desplegado: http://localhost:8081/TallerS6s12/' }
