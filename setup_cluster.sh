#Autor: Jonattan Infante V.
#Uso: Configuración de IP, Pruebas de Red, Instalación de dependencias

#Parametros
TIPO_NODO = $0

#1. Creción de carpeta para almacenar el alias de cada host

echo "Iniciaciando configuración del nodo"
echo "[Etapa 1] -  Creación de host alias"

# Creación del alias host
echo "127.0.0.1 host local" > /etc/hosts
# Creación del alias maestro
echo "192.168.1.6 maestro" >> /etc/hosts
# Creación del alias nodo 1
echo "192.168.1.7 nodo1" >> /etc/hosts
# Creación del alias nodo 2
echo "192.168.1.8 nodo2" >> /etc/hosts
# Creación del alias nodo 3
echo "192.168.1.9 nodo3" >> /etc/hosts

#Usuario
echo "[Etapa 2] -  Creación de Usuarios"
adduser mpiuser - - uid 999

#Usuario
echo "[Etapa 3] -  Instalar y configurar el sistema de archivos de red"
apt - get install nfs - kernel - server
apt - get install nfs -common
 ls - l / home / | grep mpiuser
echo "/home/mpiuser *(rw,sync,no_subtree_check)" >> /etc/exports
service nfs-kernel-server restart
exportfs -a

if [[ "$TIPO_NODO" == "master" ]]; then
ufw allow from 192.168.1.0/24 # SOLO EN EL NODO MAESTRO
else
mount master:/home/mpiuser /home/mpiuser #SOLO NODO EXCLAVOS
fi

echo "master:/home/mpiuser /home/mpiuser nfs" >> /etc/fstab


#Seguridad
echo "[Etapa 3] -  Instalar y configurar el sistema de archivos de red"
apt-get install ssh
su mpiuser
ssh-keygen
ssh-copy-id localhost
ssh node1
echo $HOSTNAME
apt-get install mpich2