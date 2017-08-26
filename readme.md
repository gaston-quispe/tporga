# 66:20 Organización de Computadoras
Trabajo práctico #0: Infraestructura básica
1 er cuatrimestre de 2017
$Date: 2017/08/22 09:15:02 $


Se trata de escribir, en lenguaje C, un programa para procesar archivos
de texto por lı́nea de comando: el programa recibirá los archivos o streams de
entrada y salida, y deberá imprimir aquellas palabras del archivo de entrada
(componentes léxicos) que sean palı́ndromos.
A fin de facilitar el proceso de desarrollo y corrección del TP, definiremos
como palabra a aquellos componentes léxicos del stream de entrada computestos
exclusivamente por combinaciones de caracteres a-z, 0-9, “-” (signo menos) y
“ ” (guión bajo). El juego de caracteres utilizado en un stream de entrada válido
es ASCII.
A los efectos de la salida, el comportamiento del programa deberá ser ca-
se insensitive; es decir, la salida permanece alterada ante permutaciones de
mayúsculas y minúsculas.
De no recibir los nombres de los archivos (o en caso de recibir - como nombre
de archivo) usaremos los streams estándar, stdin y stdout, según corresponda.
A continuación, el programa deberá ir leyendo los datos de la entrada, gene-
rando la salida correspondiente. De ocurrir errores usaremos stderr. Una vez
agotados los datos de entrada, el programa debe finalizar adecuadamente, re-
tornando al sistema operativo con un código de finalización adecuado (de tal
forma de retornar 0 siempre y cuando el programa finalice normalmente y no
hayan ocurrido errores).

