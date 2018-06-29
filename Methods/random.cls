//Retorna um número aleatório em um range
// Onde _x_ número inicial e _y_ número Final

public Integer random(Integer x, Integer y){
    return Integer.valueof(Math.floor(Math.random() * ((y-x)+1) + x));
}