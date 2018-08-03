# Prueba Ruby. hecho por Ricardo Suárez
# El archivo notas_alumnos.csv fue modificado para realizar pruebas.
opcion = 0

txt_menu = <<MENU
  Seleccionar una opción
  1. Generar archivo con promedio de nota por alumno
  2. Mostrar inasistencias por alumno
  3. Mostrar alumnos aprobados.(Nota mínima 5.0)
  4. Salir

MENU

# Metodo para la creación de un archivo nuevo con los promedios de los alumnos
def opcion_1
  file = File.open('notas_alumnos.csv', 'r')
  alumnos = file.readlines.map { |e| e.tr('A', '1').chomp.split(', ') }
  file.close

  crear = File.new('promedio.txt', 'w')
  alumnos.each do |e|
    suma = e.inject(0) { |c, v| c + v.to_f }
    prom = suma / (e.length - 1)
    crear.write "#{e[0]}: #{prom}\n"
  end
  crear.close
  print "Se ha creado el archivo 'promedio.txt' en la carpeta local \n\n"
end

# Metodo para mostrar cantidad de inasistencias de alumnos
def opcion_2
  file = File.open('notas_alumnos.csv', 'r')
  alumnos = file.readlines.map { |e| e.chomp.split(', ') }
  file.close
  print "Cantidad de inasistencias por alumno\n\n"
  alumnos.each do |e|
    c = 0
    if e.include?('A')
      c = e.select { |r| r == 'A' }.count
    else
      c = 0
    end

    puts "#{e[0]}: #{c}\n"
  end
  print "\n"
end

# Metodo para comprobar que alumno aprueba el semestre. Se realiza en base al
# archivo de promedios creados con la opción 1
def opcion_3(nota)
  file = File.open('promedio.txt', 'r')
  alumnos = file.readlines.map { |e| e.chomp.split(': ') }
  file.close
  alumnos.each do |e|
    print "#{e[0]}: #{e[1]}\n" if e[1].to_f >= nota
  end
rescue StandardError
  print "Favor crear archivo de promedios en selecionando opción 1\n\n"
end

while opcion != 4
  print txt_menu
  opcion = gets.to_i
  case opcion
  when 1
    opcion_1
  when 2
    opcion_2
  when 3
    print "Favor ingresar nota mínima para aprobar semestre\n\n"
    opcion_3 gets.to_f
  when 4
    print "Elegiste salir\n\n"
  else
    print "Opción no válida\n"
    print "Vuelva a ingresar su opción\n\n"
  end
end
