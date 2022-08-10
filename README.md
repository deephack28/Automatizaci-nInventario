# Explicación del programa para comprobar el número de serie de los equipos informáticos
Este programa puede sacar el número de serie de los monitores y de los equipos que estén
conectados en la red y estén encendidos.
Para usarlo hay que realizar lo siguiente:
Ejecutar el ejecutable “inventario.exe”

![imagen](https://user-images.githubusercontent.com/101093078/183937798-f09af88d-5252-45ea-a567-00b9bd5bb879.png)

Una vez ejecutado hay que escribir las credenciales del usuario administrador para que no haya ningún tipo de problema a la hora de pedir la información a los equipos.

![imagen](https://user-images.githubusercontent.com/101093078/183938101-e49e02cf-2251-4f65-aeb4-993f75919314.png)

Si el usuario y contraseña el programa os dará la bienvenida, en caso contrario se volverá a pedir las credenciales.

![imagen](https://user-images.githubusercontent.com/101093078/183938308-542d99c9-0560-4404-b002-23a9759789d3.png)
![imagen](https://user-images.githubusercontent.com/101093078/183938378-f4dcc011-5c30-4a71-9ba3-803ec94a323d.png)
Para poder cerrar el programa antes de poner las credenciales, hay que darle a cancelar y a continuación pulsar la combinación de teclas Ctrl + C.

# Una vez iniciado el programa
Se despliega un pequeño menú

![imagen](https://user-images.githubusercontent.com/101093078/183938634-bc073400-3bde-4692-92eb-aa636878e4b1.png)

# 1- Utilizar lista
Consiste enr ealizar un inventario de los números de serie pasándole previamente una lista en Excel (CVS) de los nombres de equipo que se desean inventariar.
Las listas se deben de guardar en la carpeta BasesDeDatos.
El uso es sencillo, se selecciona la opción y saldrá por pantalla las listas que esten disponibles, el nombre de los archivos los puedes copiar y pegar en la respuesta a la pregunta del programa, una vez escrito que lista se desea usar, pulsar ENTER y el programa empezara a recopilar los datos de los equipos especificados en la lista.

# 2- Consultar un equipo
Esta opción se utiliza para consultar equipos en el momento, antes de escribir el nombre de equipo, el programa preguntará cuantos equipos se van a consultar, escribes el número y a continuación tendrás que ir escribiendo uno a uno el nombre de equipo.

![imagen](https://user-images.githubusercontent.com/101093078/183940455-d8de0d33-58e8-492e-90ff-46967e45e2e3.png)

En esta ocasión el programa te da un poco más de información al decir que el usuario esta teletrabajando, y también esta programado para una empresa donde la mayoría de los usuarios utilizan dos pantallas. //Todos esos parametros se pueden modificar a gusto de consumidor.

# 3- Buscador
Y por último, el programa trae incorporado un buscador para poder encontrar en las listas generadas previamente con la primera opción,
# IMPORTANTE para ello se tiene que exportar antes el resultado de los excels en TXT y guardarlo en la carpeta InventarioTXT
El uso es simple, escribe alguna características del equipo a buscar (Nombre, número de serie...) y el programa lo buscara en esa carpeta.
Si no se encuentra nada, el programa te lo reporta.
![imagen](https://user-images.githubusercontent.com/101093078/183941325-913e37a1-ab92-4b82-98de-d10f2997a66b.png)
