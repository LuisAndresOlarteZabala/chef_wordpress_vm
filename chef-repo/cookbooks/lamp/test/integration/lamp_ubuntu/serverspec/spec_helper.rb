
# Script de apoyo hecho en Ruby que se encargue de cargar Serverspec y de establecer las opciones de configuración generales que vamos a necesitar, tales como la ruta utilizada para buscar los binarios durante la ejecución de las pruebas.
require 'serverspec'
require 'pathname' 

set :backend, :exec
set :path, '/bin:/usr/local/bin:$PATH'
