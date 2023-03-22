create database gimnasio;
use gimnasio;

create table Sedes(
    id int AUTO_INCREMENT primary key,
    nombre varchar(20),
    direccion varchar(30)
);

create table Tipos_clases(
    id int AUTO_INCREMENT primary key,
    nombre varchar(20)
);

create table Clases(
    id int AUTO_INCREMENT primary key,
    nombre varchar(20),
    horario time,
    cupo_max int,
    cupo_actual int,
    id_sede int,
    id_tipo int,
    constraint foreign key (id_sede) references Sedes(id),
    constraint foreign key (id_tipo) references Tipos_clases(id)
);

create table Coordinadores(
    dni int primary key,
    nombre varchar(20),
    apellido varchar(20),
    telefono varchar(20),
    id_sede int,
    constraint foreign key (id_sede) references Sedes(id)
);

create table Socios(
    dni int primary key,
    nombre varchar(20),
    apellido varchar(20),
    telefono varchar(20),
    edad int
);

create table Sedes_socios(
    id int AUTO_INCREMENT primary key,
    id_sede int,
    id_socio int,
    constraint foreign key (id_sede) references Sedes(id),
    constraint foreign key (id_socio) references Socios(dni)
);

create table Tipos_planes(
    id int AUTO_INCREMENT primary key,
    nombre varchar(20)
);

create table Sesiones(
    id int AUTO_INCREMENT primary key,
    nombre varchar(20)
);

create table Ejercicios(
    id int primary key,
    descripcion varchar(100),
    repeticiones int,
    series int,
    notas varchar(100),
    id_sesion int,
    constraint foreign key (id_sesion) references Sesiones(id)
);

create table Planes(
    id int AUTO_INCREMENT primary key,
    nombre varchar(20),
    fecha datetime,
    duracion int,
    estado bool,
    dni_socio int,
    id_tipo_plan int,
    id_sesiones int,
    constraint foreign key (dni_socio) references Socios(dni),
    constraint foreign key (id_tipo_plan) references Tipos_planes(id),
    constraint foreign key (id_sesiones) references Sesiones(id)
);

create table Registros(
    id int AUTO_INCREMENT primary key,
    fecha_registro datetime,
    notas varchar(100),
    id_planes int,
    constraint foreign key (id_planes) references Planes(id)
);

