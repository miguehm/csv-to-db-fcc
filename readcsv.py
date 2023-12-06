import csv
import sqlite3
from datetime import datetime

conexion = sqlite3.connect('horario.db')
cursor = conexion.cursor()

with open('./p2024.csv', newline='') as f:
    # lectura del cs
    reader = csv.DictReader(f)
    for row in reader:
        # print(row)
        # break
        # # Inserta en Profesor
        nombre_profe = row['Profesor']
        apellido_paterno, resto = nombre_profe.split(" - ", 1)
        apellido_materno, nombre = resto.split(" ", 1)

        apellido_paterno = apellido_paterno.title()
        apellido_materno = apellido_materno.title()
        nombre = nombre.title()
        
        print("Apellido Paterno:", apellido_paterno)
        print("Apellido Materno:", apellido_materno)
        print("Nombre:", nombre)
        print()

        cursor.execute(f"SELECT * FROM Profesor WHERE Nombre = \"{nombre}\" AND ApellidoPaterno = \"{apellido_paterno}\" AND ApellidoMaterno = \"{apellido_materno}\"")

        if bool(cursor.fetchall()) == False:
            cursor.execute(f"INSERT INTO Profesor(ApellidoPaterno, ApellidoMaterno, Nombre) VALUES (\"{apellido_paterno}\", \"{apellido_materno}\", \"{nombre}\")")
        # cursor.execute(f'Select * from Profesor where nombre = "{row["Profesor"]}"')
        # print(cursor.fetchall())

        # bool() para saber is una lista esta vacia

        # Inserta en Materia
        nombre_materia = row['Materia']
        print("Materia:", nombre_materia)
        print()

        cursor.execute(f"SELECT * FROM Materia WHERE NombreMateria = \"{nombre_materia}\"")

        if bool(cursor.fetchall()) == False:
            cursor.execute(f"INSERT INTO Materia(NombreMateria) VALUES (\"{nombre_materia}\")")

        # Profesor imparte Materia
        cursor.execute(f"SELECT * FROM Profesor WHERE Nombre = \"{nombre}\" AND ApellidoPaterno = \"{apellido_paterno}\" AND ApellidoMaterno = \"{apellido_materno}\"")

        id_profesor = cursor.fetchone()[0]
        print("ID Profesor:", id_profesor)

        cursor.execute(f"SELECT * FROM Materia WHERE NombreMateria = \"{nombre_materia}\"")

        id_materia = cursor.fetchone()[0]
        print("ID Materia:", id_materia)
        
        cursor.execute(f"SELECT * FROM Profesor_Imparte_Materia WHERE IdProfesor = {id_profesor} AND IdMateria = {id_materia}")

        if bool(cursor.fetchall()) == False:
            cursor.execute(f"INSERT INTO Profesor_Imparte_Materia(IdProfesor, IdMateria) VALUES ({id_profesor}, {id_materia})")

        # Inserta en Clase

        nrc = row['NRC']

        cursor.execute(f"SELECT * FROM Clase WHERE NRC = \"{nrc}\"")

        if bool(cursor.fetchall()) == False:
            cursor.execute(f"INSERT INTO Clase(NRC, IdProfesor, IdMateria) VALUES ({nrc}, {id_profesor}, {id_materia})")

        # Inserta en Evento

        # Obtener dia
        dia_semana = row['Dia']
        dias_semana = {
            "L": "Lunes",
            "A": "Martes",
            "M": "Miercoles",
            "J": "Jueves",
            "V": "Viernes",
        }
        dia_semana = dias_semana[dia_semana]

        # Obtener duracion
        # Tu string de rango de tiempo
        time_range = row['Hora']
        # Divide el string en las horas de inicio y fin
        start_time, end_time = time_range.split("-")
        
        # Guarda la hora de inicio para usarla en el INSERT
        hora_inicio = start_time
        
        # Convierte las horas de inicio y fin en objetos datetime
        start_time = datetime.strptime(start_time, "%H%M")
        end_time = datetime.strptime(end_time, "%H%M")
        # Calcula la duración en horas
        duration = end_time - start_time
        # Imprime la duración en horas
        duracion = round(duration.total_seconds() / 3600)
        
        # Comprobar si ya existe el Evento
        cursor.execute(f"SELECT * FROM Evento WHERE NRC = \"{nrc}\" AND DiaSemana = \"{dia_semana}\" AND HoraInicio = \"{hora_inicio}\"")
        
        if bool(cursor.fetchall()) == False:
            cursor.execute(f"INSERT INTO Evento(NRC, Duracion, DiaSemana, HoraInicio) VALUES (\"{nrc}\", \"{duracion}\", \"{dia_semana}\", \"{hora_inicio}\")")

        # Inserta en Lugar
        lugar = row['Salon']
        edificio, salon = lugar.split("/", 1)
        
        print("Edificio:", edificio)
        print("Salon:", salon)

        cursor.execute(f"SELECT * FROM Lugar WHERE Edificio = \"{edificio}\" AND Salon = \"{salon}\"")

        if bool(cursor.fetchall()) == False:
            cursor.execute(f"INSERT INTO Lugar(Edificio, Salon) VALUES (\"{edificio}\", \"{salon}\")")

        # Inserta en Evento_SeRealizaEn_Lugar

        id_evento = cursor.execute(f"SELECT IdEvento FROM Evento WHERE NRC = \"{nrc}\" AND DiaSemana = \"{dia_semana}\"").fetchone()[0]

        id_lugar = cursor.execute(f"SELECT IdLugar FROM Lugar WHERE Edificio = \"{edificio}\" AND Salon = \"{salon}\"").fetchone()[0]
        
        cursor.execute(f'INSERT INTO Evento_SeRealizaEn_Lugar(IdEvento, IdLugar) VALUES ({id_evento}, {id_lugar})')

    conexion.commit()
    conexion.close()
