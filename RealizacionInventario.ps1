#Peticion de datos
$correcto = $false
while ($correcto -ne $true) 
{ 
    $cred = Get-Credential #Read credentials 
    $username = $cred.username 
    $password = $cred.GetNetworkCredential().password
    $CurrentDomain = "LDAP://" + ([ADSI]"").distinguishedName 
    $domain = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain,$UserName,$Password) 

    if (!$domain.name) 
        { 
            Write-Output " "
            write-host "Autenticación fallida, compruebe usuario o contraseña."
            Write-Output " " 
  
        }
    else 
        {
            Write-Output " " 
            write-host "Has iniciado sesión con $username" 
            Write-Output " "
            Read-Host -Prompt "Pulsa cualquier tecla para continuar"
            $correcto = $true
        }
}
Function menu2 
{
    Clear-Host
    Write-Host "Elige"
    Write-Host "1. Utilizar lista"
    Write-Host "2. Consultar un equipo"
    Write-Host "3. Buscador"
    Write-Host "4. Salir"


}
function operacionInventario
{
    $Excel = New-Object -ComObject Excel.Application


    #Abrir archivo
    $WorkBook = $Excel.Workbooks.add()
    $Excel.Application.Visible = $true

    #Nombrar Hoja
    $WorkSheet = $WorkBook.Worksheets.Item(1)
    $WorkSheet.Name = 'Inventario Activo'

    #Crea los titulos de las columnas en Excel

    $WorkSheet.Cells.Item(1,1) = 'NombreEquipo'
    $WorkSheet.Cells.Item(1,2) = 'Monitor1'
    $WorkSheet.Cells.Item(1,3) = 'Monitor2'
    $WorkSheet.Cells.Item(1,4) = 'NumeroSerieEquipo'
    #$WorkBook.SaveAs("C:\ProgramaInventario\NúmerosDeSerie\Inventario_ActiveDirectory$lista$fecha.xlsx")


    #Lista para reconocer el hostname de los equipos
    $equiposUsuarios = Import-Csv $lista -UseCulture | Select-Object -ExpandProperty nombre 

    $contador = 2

    #Conexión remota a los equipos del dominio
    ForEach ($equipo in $equiposUsuarios) 
        {
            $datos = @(Invoke-Command -ComputerName $equipo -FilePath C:\ProgramaInventario\GetMonitors.ps1 -Credential $Cred 2>$null) 
            #Write-Host $datos # <- Comprobación de los datos dentro de la ARRAY  
        
            if ($datos[0] -eq "CTX")
            {
                $SerieEequipo = $datos[5]
                $WorkSheet.Cells.Item($contador,4) = $SerieEequipo

            }
            else 
            {
                if($datos[6] -eq "CTX")
                {
                    $SerieMonitorUno = $datos[2]
                    $WorkSheet.Cells.Item($contador,2) = $SerieMonitorUno

                    $SerieMnitorDos = $datos[5]
                    $WorkSheet.Cells.Item($contador,3) = $SerieMnitorDos

                    $SerieEequipo = $datos[11]
                    $WorkSheet.Cells.Item($contador,4) = $SerieEequipo
                }
                else 
                {
                    if(!$datos[4]){
                        #Inserta datos en las filas y en su columna correspondiente
                        $WorkSheet.Cells.Item($contador,1) = $equipo
                        
                        $SerieMonitorUno = $datos[2]
                        $WorkSheet.Cells.Item($contador,2) = $SerieMonitorUno
                        
                        $SerieEequipo = $datos[5]
                        $WorkSheet.Cells.Item($contador,4) = $SerieEequipo
                    } else {
                        #Inserta datos en las filas y en su columna correspondiente
                        $WorkSheet.Cells.Item($contador,1) = $equipo
                        
                        $SerieMonitorUno = $datos[2]
                        $WorkSheet.Cells.Item($contador,2) = $SerieMonitorUno
                        
                        $SerieMnitorDos = $datos[5]
                        $WorkSheet.Cells.Item($contador,3) = $SerieMnitorDos
                        
                        $SerieEequipo = $datos[8]
                        $WorkSheet.Cells.Item($contador,4) = $SerieEequipo
                    }

                }
            }
                
            $contador += 1
        }  
    $WorkBook.SaveAs("C:\ProgramaInventario\NumerosDeSerie\Inventario_ActiveDirectory$lista.xlsx")
    #$Excel.Quit()
    Clear-Host
    menu2

}

menu2
while(($Ubicacion = Read-Host -Prompt "Elige una opcion") -ne "4"){

switch($Ubicacion)
{
    1 {
        $comprobacion = $false
        while ($comprobacion -ne $true ) 
            {
                $rutaLista = Get-ChildItem C:\ProgramaInventario\BasesDeDatos
                if (-not (Test-Path $rutaLista))
                    {

                    Write-Output "Debes de tener la carpeta en el disco C: de esta forma -> C:\ProgramaInventario\BasesDeDatos"

                    } else {
                
                    write-Host "Los ficheros existentes son los siguientes: "

                    Write-Output " "

                    $rutaLista

                    Write-Output " "

                    $ruta = Read-Host "Escribe que lista vas a usar: " 

                    if (!$ruta) 
                        { 
                            Write-Host " "
                            Write-Host "No has introducido ningún dato."
                            Write-Host " "
                
                        } else { 

                            $lista = "C:\ProgramaInventario\BasesDeDatos\$ruta"
                            operacionInventario
                        
                            $comprobacion = $true
                        }
        
                    }
            }
    }                  
    2 {
        Write-Output " "
        $reproduccion = Read-Host "Cuantos equipos vas a consultar "  

        #Vucle
        $contador = 1
        for ($i = 0; $i -lt $reproduccion;$i ++) 
        {
            $EquipoUno = Read-Host "Dime el nombre del equipo: " $contador
            $UnEquipo = @(Invoke-Command -ComputerName $EquipoUno -FilePath C:\programaInventario\GetMonitors.ps1 -Credential $Cred 2>$null)
            
            
            if ($UnEquipo[0] -eq "CTX") {
                Write-Host "El usuario esta teletrabajando"
                Write-Host "Equipo: " $UnEquipo[5]
    

            } else {
                if($UnEquipo[6] -eq "CTX"){
                    Write-Host "El usuario esta teletrabajando"
                    Write-Host "Monitor 1: " $UnEquipo[2]
                    Write-Host "Monitor 2: " $UnEquipo[5]
                    Write-Host "Equipo: " $UnEquipo[11]
                } else {
                    if(!$UnEquipo[4]){
                        Write-Output " "
                        Write-Host "Monitor uno: " $UnEquipo[2]
                        Write-Host "Monitor dos: -" 
                        Write-Host "Equipo: " $UnEquipo[5]
                        Write-Host "-----------------------------------------------------"   
                    } else {
                        Write-Output " "
                        Write-Host "Monitor uno: " $UnEquipo[2]
                        Write-Host "Monitor dos: " $UnEquipo[5]
                        Write-Host "Equipo: " $UnEquipo[8]
                        Write-Host "-----------------------------------------------------" 
                    }
                } 
            }
        }
        Write-Output " "
        Read-Host -Prompt "Pulsa cualquier tecla para volver al menu."
        Write-Output " "

        menu2
    }
    3{
        Write-Output " "
        $Buscador = Read-Host "Buscar: " 
        $Encontrado = Get-ChildItem -Path 'C:\ProgramaInventario\NumerosDeSerie\InventarioTXT\*.txt' | Select-String $Buscador 

        if(!$Encontrado)
        {
            Write-Output " "
            Write-Host "No se ha encontrado ningún resultado"
            Write-Output " "
        }
        else 
        {
            Write-Output " "
            Write-Host $Encontrado
            Write-Output " "
        }
        Read-Host -Prompt "Pulsa cualquier tecla para volver al menu"
        menu2
    }
    

    }
                 
}