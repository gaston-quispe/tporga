cantidad_archivos_entrada=$(ls -1q Tests/Entrada*.txt | wc -l)
test_fallidos=0
test_pasados=0

for i in `seq 1 $cantidad_archivos_entrada`
do
        path_entrada='Tests/Entrada'$i'.txt'
        path_salida='Tests/SalidaEsperada'$i'.txt'

        if [ $(./a.out -i $path_entrada | diff $path_salida -) ];
        then
                echo "Test $i: ERROR"
                ./a.out -i $path_entrada | diff $path_salida -
                test_fallidos=$((test_fallidos+1))
        else
                echo "Test $i:OK"
                test_pasados=$((test_pasados+1))
        fi
done

echo 'Pasados' $test_pasados 'tests de' $cantidad_archivos_entrada
echo 'Fallidos' $test_fallidos 'tests de' $cantidad_archivos_entrada
