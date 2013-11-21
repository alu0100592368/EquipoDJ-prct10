require './lib/frac_main.rb'

class Matriz
  
  attr_reader :n_filas, :n_columnas, :datos
  
  def initialize(n_filas, n_columnas, datos)
    @n_filas = n_filas
    @n_columnas = n_columnas
    num = 0
    dem = 0
    temp = []
    for i in 0...n_filas
      for j in 0...n_filas
	if (/\//.match(datos[i][j]))
	  temp = datos[i][j].split(%r{\/})
	  temp[0] = temp[0].to_i
	  temp[1] = temp[1].to_i
	  datos[i][j] = Fraccion.new(temp[0], temp[1])
	  temp = []
	else
	  datos[i][j] = Fraccion.new(datos[i][j].to_i, 1)
	end
      end
    end
  end
  
  def mostrar
  end
  
  def +(other)
  end
  
  def -(other)
  end
  
  def *(other)
  end
end



class MatrizDensa < Matriz
  
  def initialize (n_filas, n_columnas, datos)
    @datos = Array.new(datos)
    super
      @n_filas = n_filas
      @n_columnas = n_columnas 
  end
  
  def +(other)
    
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...n_filas
      for j in 0...n_columnas
	m[i][j] = self.datos[i][j]+ other.datos[i][j]
	m[i][j] = m[i][j].to_s
      end
    end
    MatrizDensa.new(other.n_filas,other.n_columnas,m) 
 end
 
  def -(other)
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...n_filas
      for j in 0...n_columnas
	m[i][j] = self.datos[i][j]- other.datos[i][j]
	m[i][j] = m[i][j].to_s
      end
    end
    MatrizDensa.new(other.n_filas,other.n_columnas,m) 
 end
 
  def *(other)
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...n_filas do
      for j in 0...other.n_columnas do  
        for k in 0...n_columnas do
	  m[i][j] = self.datos[i][k] * other.datos[k][j]
	  m[i][j] = m[i][j].to_s
         end
      end
    end
    MatrizDensa.new(self.n_filas,other.n_columnas,m)
  end
  
  def mostrar
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...n_filas
      for j in 0...n_columnas
	m[i][j] = @datos[i][j].to_s
      end
    end
    m
  end
  
=begin
  
  def coerce(other)
    puts "ME LLAMAN"
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    if self.class == MatrizDispersa
      puts "AQUI"
      for i in 0...@d[:fila].length
        m[self.fila(i)][self.columna(i)] = self.valor(i)
	m[i] = m[i].to_s
      end
      return [MatrizDensa.new(@n_filas, @n_columnas,m), other]
    else      
      puts "AQUI 2"
      for i in 0...@d[:fila].length
        m[other.fila(i)][other.columna(i)] = other.valor(i)
	m[i] = m[i].to_s
      end
      return [self, MatrizDensa.new(@n_filas, @n_columnas,m)]
    end
  end
  
=end
  
end



class MatrizDispersa < Matriz
  
  def initialize (n_filas, n_columnas, datos)
    
    super
      @n_filas = n_filas
      @n_columnas = n_columnas 
    @d = {:fila=>[], :columna=>[], :valor=>[]}
    @tam = 0
    for i in 0...n_filas 
      for j in 0...n_columnas
	if datos[i][j] != 0
	  @d[:fila].push(i)
	  @d[:columna].push(j)
	  @d[:valor].push(datos[i][j])
	  @tam += 1
	end
      end
    end
  end
  
  def fila(n)
    @d[:fila][n].to_i
  end
  
  def columna(n)
    @d[:columna][n].to_i
  end
  
  def tam
    @tam
  end
  
  def valor(n)
    @d[:valor][n]
  end
  
  def mostrar
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...@d[:fila].length
      m[@d[:fila][i].to_i][@d[:columna][i].to_i] = @d[:valor][i].to_s
    end
    m
  end
  
  
  def +(other)
    @resultado = {:fila=>[], :columna=>[], :valor=>[] }
    test = true
    for i in 0...self.tam
      for j in 0...other.tam
	if (self.fila(i) == other.fila(j)) && (self.columna(i) == other.columna(j))
	  @resultado[:fila].push(self.fila(i))
	  @resultado[:columna].push(self.columna(i))
	  @resultado[:valor].push(self.valor(i) + other.valor(j))  
	end
      end
    end
    for i in 0...self.tam
      test = true
      for j in 0...other.tam
	if self.fila(i) == @resultado[:fila][j] && self.columna(i) == @resultado[:columna][j]
	  test = false
	end
      end
      if test
	@resultado[:fila].push(self.fila(i))
	@resultado[:columna].push(self.columna(i))
	@resultado[:valor].push(self.valor(i))
      end
    end
    for i in 0...other.tam
      test = true
      for j in 0...other.tam
	if other.fila(i) == @resultado[:fila][j] && other.columna(i) == @resultado[:columna][j]
	  test = false
	end
      end
      if test
	@resultado[:fila].push(other.fila(i))
	@resultado[:columna].push(other.columna(i))
	@resultado[:valor].push(other.valor(i))
      end
    end
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...@resultado[:fila].length
      m[@resultado[:fila][i].to_i][@resultado[:columna][i].to_i] = @resultado[:valor][i].to_s
    end
    MatrizDispersa.new(@n_filas, @n_columnas,m)
  end
  
  def -(other)
    @resultado = {:fila=>[], :columna=>[], :valor=>[] }
    test = true
    for i in 0...self.tam
      for j in 0...other.tam
	if (self.fila(i) == other.fila(j)) && (self.columna(i) == other.columna(j))
	  @resultado[:fila].push(self.fila(i))
	  @resultado[:columna].push(self.columna(i))
	  @resultado[:valor].push(self.valor(i) - other.valor(j))  
	end
      end
    end
    for i in 0...self.tam
      test = true
      for j in 0...other.tam
	if self.fila(i) == @resultado[:fila][j] && self.columna(i) == @resultado[:columna][j]
	  test = false
	end
      end
      if test
	@resultado[:fila].push(self.fila(i))
	@resultado[:columna].push(self.columna(i))
	@resultado[:valor].push(self.valor(i))
      end
    end
    for i in 0...other.tam
      test = true
      for j in 0...other.tam
	if other.fila(i) == @resultado[:fila][j] && other.columna(i) == @resultado[:columna][j]
	  test = false
	end
      end
      if test
	@resultado[:fila].push(other.fila(i))
	@resultado[:columna].push(other.columna(i))
	@resultado[:valor].push(-other.valor(i))
      end
    end
    m = Array.new(@n_filas){Array.new(@n_columnas){0}}
    for i in 0...@resultado[:fila].length
      m[@resultado[:fila][i].to_i][@resultado[:columna][i].to_i] = @resultado[:valor][i].to_s
    end
    out = MatrizDispersa.new(@n_filas, @n_columnas, m)
  end  
end

a = MatrizDensa.new(2, 2, [["2/6","3"],["4/9","5"]])
b = MatrizDispersa.new(2, 2, [["0","-2/5"],["0","0"]]) 