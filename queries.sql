CREATE TABLE IF NOT EXISTS Profesor(
  IdProfesor INTEGER PRIMARY KEY AUTOINCREMENT,
  ApellidoPaterno VARCHAR(50) NOT NULL,
  ApellidoMaterno VARCHAR(50) NOT NULL,
  Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Materia (
  IdMateria INTEGER PRIMARY KEY AUTOINCREMENT,
  NombreMateria VARCHAR(50) NOT NULL
  -- Creditos INTEGER NOT NULL,
  -- que materias desbloquea?
);

-- CREATE TABLE IF NOT EXISTS Profesor_Imparte_Materia (
--   IdProfesor INTEGER NOT NULL,
--   IdMateria INTEGER NOT NULL,
--   -- PRIMARY KEY (IdProfesor, IdMateria),
--   FOREIGN KEY (IdProfesor) REFERENCES Profesor(IdProfesor),
--   FOREIGN KEY (IdMateria) REFERENCES Materia(IdMateria)
-- );

CREATE TABLE IF NOT EXISTS Clase (
  NRC INTEGER PRIMARY KEY,
  IdProfesor INTEGER NOT NULL,
  IdMateria INTEGER NOT NULL,
  FOREIGN KEY (IdProfesor) REFERENCES Profesor(IdProfesor),
  FOREIGN KEY (IdMateria) REFERENCES Materia(IdMateria)
);

CREATE TABLE IF NOT EXISTS Evento (
  IdEvento INTEGER PRIMARY KEY AUTOINCREMENT,
  NRC INTEGER NOT NULL,
  Duracion INTEGER NOT NULL, -- horas
  DiaSemana VARCHAR(50) NOT NULL, -- Lunes, Martes, Miercoles, Jueves, Viernes
  HoraInicio VARCHAR(10) NOT NULL, -- i.e 10:00 en 24 horas
  FOREIGN KEY (NRC) REFERENCES Clase(NRC)
);

CREATE TABLE IF NOT EXISTS Lugar (
  IdLugar INTEGER PRIMARY KEY AUTOINCREMENT,
  Edificio VARCHAR(20) NOT NULL,
  Salon VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Evento_SeRealizaEn_Lugar (
  IdEvento INTEGER NOT NULL,
  IdLugar INTEGER NOT NULL,
  FOREIGN KEY (IdEvento) REFERENCES Evento(IdEvento),
  FOREIGN KEY (IdLugar) REFERENCES Lugar(IdLugar)
);

-- INSERT INTO Profesor(ApellidoPaterno, ApellidoMaterno, Nombre) VALUES ('Mendez', 'Sanchez', 'Luis Yael');
-- INSERT INTO Profesor(ApellidoPaterno, ApellidoMaterno, Nombre) VALUES ('Torres', 'Acuitlapa', 'Omar');
-- INSERT INTO Profesor(ApellidoPaterno, ApellidoMaterno, Nombre) VALUES ('Bello', 'Lopez', 'Pedro');
--
-- INSERT INTO Materia(NombreMateria) VALUES ('Aplicaciones Web');
--
-- -- en programacion obtener los ids: el ultimo id de profesor insertado y el id de la materia
-- INSERT INTO Profesor_Imparte_Materia(IdProfesor, IdMateria) VALUES (1, 1); 
-- INSERT INTO Profesor_Imparte_Materia(IdProfesor, IdMateria) VALUES (2, 1);
-- INSERT INTO Profesor_Imparte_Materia(IdProfesor, IdMateria) VALUES (3, 1);
--
-- -- en programacion hacer query que obtenga el id de la materia y el id del profesor
-- INSERT INTO Clase(NRC, IdProfesor, IdMateria) VALUES (51786, 1, 1); 
-- INSERT INTO Clase(NRC, IdProfesor, IdMateria) VALUES (51771, 2, 1); 
-- INSERT INTO Clase(NRC, IdProfesor, IdMateria) VALUES (51726, 3, 1); 
--
-- -- en programacion hacer query que obtenga el id de la clase
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51786, 1, 'Lunes', '17:00', 'CCO4-308'); 
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51786, 2, 'Miercoles', '17:00', 'CCO4-308');
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51786, 2, 'Viernes', '17:00', 'CCO1-001');
--
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51771, 1, 'Lunes', '12:00', 'CCO4-307'); 
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51771, 2, 'Martes', '11:00', 'CCO3-109');
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51771, 2, 'Jueves', '11:00', 'CCO4-307');
--
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51726, 1, 'Lunes', '09:00', 'CCO3-114'); 
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51726, 2, 'Miercoles', '09:00', 'CCO1-002');
-- INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio, Lugar) VALUES (51726, 2, 'Viernes', '09:00', 'CCO3-114');
