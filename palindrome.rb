#palindromo
#solucion, sin mucho que decir
#Solo en dada la palabra si es igual al contrario y al reverse, retorna palindromo
def palindromo(text)
  if text.downcase == text.downcase.reverse
    "palindrome"
  else
    "no palindrome"
  end
end


#Dado un numero, retornar el valor de la posicion en un archivo de excel.

#solucion
#En esta solucion com te comente ruby tiene para hacer el recorrido sin problemas, lo que hice fue iterar hasta el numero
#que necesitaba y al final solo obtener el valor necesitado, teniendo la constante de hash guarda al ejecutar la app
#se ejecutara una vez, lo demas ya seria solo buscar la solucion rapida y sencilla
h = {}
('a'..'zzz').each_with_index{|w, i| h[i+1] = w }

def excel(number)
  h[number]
end



#.- Crear un algoritmo al cual se le deba ingresar un array de n números enteros, más un numero de resultado, ejemplo: Input: numbers={2, 7, 11, 15}, target=9 Este algoritmo debe ser capaz de encontrar dos números dentro del array que sumados sean igual al numero target,obviamente el algoritmo no puede ser un for que vaya sumando todos los números de uno en uno, debe tener mayor inteligencia.El resultado debe indicar la posición del array de los números que sumados dan el resultado esperado, ejemplo: Output: index1=1, index2=2


#solucion
#en ruby existe combination par aun numero de valores, entonces recorro todas las posibles opciones y 
#alli lo que hago es iterar por cada una de ella y obtener lo que necesito al final

 #numbers( [2, 7, 11, 15], 9)
 def numbers(array = [], sum = 0)
   value = array.combination(2).find_all { |x, y| x + y == sum } || []

   if value.count > 0
     puts "index1=#{array.index(value.first[0])}, index2=#{array.index(value.first[1])}"
   else
     puts "index1=-1, index2=-1, sin solucion"
   end
 end
