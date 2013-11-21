#require './gcd.rb' Usar esta línea y no la de abajo cuando se quieran probar funcionalidades de este fichero en concreto
require  './lib/gcd.rb'

#Creación de la clase Fracción
class Fraccion
  
  #Inclusión del módulo Comparable
  include Comparable
  
  #Declaración de atributos de lectura.
  attr_reader :numerador, :denominador
  
  #Definición del método <=> usado por el módulo Comparable, especificando que se comparen valores.
  def <=> fraccion2
    @valor <=> fraccion2.val
  end
  
  #Inicialización de las variables de la clase.
  def initialize (numerador, denominador)
    @numerador = numerador                                                
    @denominador = denominador
    #Calculamos el máximo común divisor para trabajar todo el rato con la fracción minimizada.
    temp = gcd(@numerador, @denominador)
    @numerador = @numerador/temp
    @denominador = @denominador/temp
    #Valor de la fracción de tipo float.
    @valor = (@numerador.to_f/@denominador.to_f)
  end
  
  #Método que devuelve el numerador de la fracción
  def num
    @numerador
  end
  
  #Método que devuelve el denominador de la fracción
  def denom
    @denominador
  end
  
  #Método que devuelve el valor de la fracción
  def val
    @valor
  end
  
  #Método que devuelve gráficamente la fracción en forma de string
  def to_s 
    "#{@numerador}/#{@denominador}"
  end
  
  #Método que devuelve que recíproco de una fracción
  def reciprocal
    Fraccion.new(@denominador,@numerador)
  end
  
  #Método que crea y devuelve una fracción en formato flotante.
  def to_float
    @numerador = @numerador.to_f
    @denominador = @denominador.to_f
    Fraccion.new(@numerador,@denominador)
  end
  
  #Método que calcula el valor absoluto de una fracción.
  def absoluto
    @numerador = @numerador.abs
    @denominador = @denominador.abs
    Fraccion.new(@numerador,@denominador)
  end
  
  #Método que calcula el opuesto de una fracción
  def opuesto
    Fraccion.new(-@numerador,@denominador)
  end
  
  #Método que calcula la suma de dos fracciones.
  def + fraccion2
    mcm = (@denominador*fraccion2.denominador)/gcd(@denominador, fraccion2.denominador)
    primero = (mcm/@denominador)*@numerador
    segundo = (mcm/fraccion2.denominador)*fraccion2.numerador
    Fraccion.new(primero + segundo, mcm)
  end
  
  #Método que calcula la resta de dos fracciones.
  def - fraccion2
    mcm = (@denominador*fraccion2.denominador)/gcd(@denominador, fraccion2.denominador)
    primero = (mcm/@denominador)*@numerador
    segundo = (mcm/fraccion2.denominador)*fraccion2.numerador
    Fraccion.new(primero - segundo, mcm)
  end
  
  #Método que calcula la multiplicación de dos fracciones.
  def * fraccion2  
    Fraccion.new(@numerador * fraccion2.numerador, @denominador * fraccion2.denominador)
  end
  
  #Método que calcula el resto de la división de dos fracciones.
  def % fraccion2
    a = self / fraccion2
    b = Fraccion.new(1,1)
    return c=a-b
  end
  
  #Método que calcula la división de dos fracciones.
  def / fraccion2  
    Fraccion.new(@numerador * fraccion2.denominador, @denominador * fraccion2.numerador)
  end
end