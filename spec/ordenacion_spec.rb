require 'rspec'
require './lib/matrix.rb'
require './lib/frac_main.rb'


describe Matriz do
  before :each do
    @densa1 = MatrizDensa.new(2, 2, [["1","-7/3"],["3","4"]])
    @densa2 = MatrizDensa.new(2, 2, [["2/6","3"],["4/9","5"]])
    @dispersa1 = MatrizDispersa.new(2, 2, [["0","-2/5"],["0","0"]])
    @dispersa2 = MatrizDispersa.new(2, 2, [["0","0"],["0","-7/3"]])
  end
  
  describe "Test de las matrices densas" do
    it "- La matriz se visualiza correctamente" do
      @densa1.mostrar.should eq([["1/1","-7/3"],["3/1","4/1"]])
    end
    it "- La matriz tiene la estructura correcta" do
      temp = [["1/1","-7/3"],["3/1","4/1"]]
      @densa1.mostrar.should eq(temp)
    end
  end
    
  describe "- Operaciones aritméticas de Matrices Densas" do
    it "- Las matrices se suman correctamente" do
      (@densa1 + @densa2).mostrar.should eq([["4/3", "2/3"],["31/9","9/1"]])
    end   
    it "- Las matrices se restan correctamente" do
      (@densa2 - @densa1).mostrar.should eq([["-2/3","16/3"],["-23/9","1/1"]])
    end
    it "- Las matrices se multiplican correctamente" do
      (@densa1 * @densa2).mostrar.should eq ([["-28/27", "-35/3"],["16/9", "20/1"]])
    end
  end
  
  describe "Test de las matrices dispersas" do
    it " - La matriz se visualiza correctamente " do
      @dispersa1.mostrar.should eq ([["0/1","-2/5"],["0/1","0/1"]])
    end
    
    it " - Las matrices se suman correctamente" do
      (@dispersa1+@dispersa2).mostrar.should eq ([["0/1", "-2/5"],["0/1", "-7/3"]])
    end
    it " - Las matrices se restan correctamente" do
      (@dispersa1-@dispersa2).mostrar.should eq ([["0/1","-2/5"],["0/1","7/3"]])
    end
  end
end


describe Fraccion do
  #Creamos una Fracción
  before :each do
    @Fraccion1 = Fraccion.new(10, 20)
  end
    
    #Comprobando la existencia de determinados elementos en nuestra clase fracción
    describe "Existencia de elementos de una fracción" do
      it "- Debe haber definido un numerador" do
        defined?(@Fraccion1.num())
      end
      it "- Debe haber definido un denominador" do
	defined?(@Fraccion1.denom())
      end
      it "- La fracción se almacena reducida" do
	@Fraccion1.should eq(Fraccion.new(1,2))
      end
    end
    
    #Comprobando la obtención de los atributos de la clase
    describe "Obtención de elementos de una fracción" do
      it "- Obtenido elnumerador a través del método num()" do
	@Fraccion1.numerador.should eq(1)
      end
      it "- Obtenido el denominador a través del método denom()" do
	@Fraccion1.denominador.should eq(2)
      end
      it "- Obtenido el valor a través del método val()" do
	@Fraccion1.val.should eq(0.5)
      end
    end 

    
    #Comprobando operaciones diversas referente al uso de fracciones
    describe "Comprobaciones diversas" do
      it "- El formato de visualización es de la forma: a/b" do
	 @Fraccion1.to_s.should eq("1/2")
      end
      it "- El recíproco de calcula correctamente" do
	 @Fraccion2 = Fraccion.new(20,10)  
	 @Fraccion1.reciprocal.should eq (@Fraccion2)
      end
      it "- Fracción en formato flotante correctamente calculada" do
	@Fraccion1 = @Fraccion1.to_float
	numerador = @Fraccion1.num()
	denominador = @Fraccion1.denom()
	numerador.class == Float && denominador.class == Float
      end
      it "- Valor absoluto calculado correctamente" do
	@Fraccion2 = Fraccion.new(-10,20)
	fracc_aux = @Fraccion2.absoluto
	fracc_aux.should eq (@Fraccion1)
      end
      it "- Opuesto calculado correctamente" do
	@Fraccion1.opuesto.should eq(Fraccion.new(-10,20))
      end
    end
      
    
    #Comprobando operaciones aritméticas con fracciones
    describe "Operaciones aritméticas" do
      it "- Las fracciones se suman correctamente" do
	@Fraccion2 = Fraccion.new(8,20)
	@Fraccion3 = @Fraccion1 +@Fraccion2
	@Fraccion3.should eq(Fraccion.new(9,10))
      end
      it "- Las fracciones se restan correctamente" do
	@Fraccion2 = Fraccion.new(8,20)
	@Fraccion3 = @Fraccion1 -@Fraccion2
	@Fraccion3.should eq(Fraccion.new(1,10))
      end
      it "- Las fracciones se multiplican correctamente" do
	@Fraccion2 = Fraccion.new(8,20)
	@Fraccion3 = @Fraccion1 *@Fraccion2
	@Fraccion3.should eq(Fraccion.new(1,5))
      end
      it "- Las fracciones se dividan correctamente" do
	@Fraccion2 = Fraccion.new(8,20)
	@Fraccion3 = @Fraccion1 /@Fraccion2
	@Fraccion3.should eq(Fraccion.new(5,4))
      end
      it "- El resto al dividir dos fracciones es correcto" do
	@Fraccion2 = Fraccion.new(8,20)
	@Fraccion3 = @Fraccion1 %@Fraccion2
	@Fraccion3.should eq(Fraccion.new(1,4))
      end  
    end
    
    
    #Comprobando operaciones comparacionales con fracciones
    describe "Operaciones Comparacionales" do
      it "- Mayor que calculado correctamente" do
	@Fraccion2 = Fraccion.new(8,20)
	(@Fraccion1>@Fraccion2).should eq(true)
      end
      it "- Menor que calculado correctamente" do
	@Fraccion2 = Fraccion.new(10,20)
	(@Fraccion1<=@Fraccion2).should eq(true)
	@Fraccion3 = Fraccion.new(11,20)
	(@Fraccion1<=@Fraccion3).should eq(true)
      end
      it "- Menor o igual calculado correctamente" do
	@Fraccion2 = Fraccion.new(10,20)
	(@Fraccion1<=@Fraccion2).should eq(true)
	@Fraccion3 = Fraccion.new(11,20)
	(@Fraccion1<=@Fraccion3).should eq(true)
      end
      it "- Mayor o igual calculado correctamente" do
	@Fraccion2 = Fraccion.new(10,20)
	(@Fraccion1>=@Fraccion2).should eq(true)
	@Fraccion3 = Fraccion.new(9,20)
	(@Fraccion1>=@Fraccion3).should eq(true)
      end
      it "- Equivalencia calculada correctamente" do
	 @Fraccion2 = Fraccion.new(10,20)
         (@Fraccion1 ==@Fraccion2).should eq(true)
      end
    end

    
    #Comprobación pedida durante la hora de entrega de la práctica 6
    describe "Espectativa de la hora de prácticas" do
      it "|f1 * f2| calculado correctamente" do
	@Fraccion2 = Fraccion.new(10,-7)
	(@Fraccion1 * @Fraccion2).absoluto.should eq(Fraccion.new(5,7))
      end
    end
end