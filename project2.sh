#
# for loop to process stock list
#
clear

while true
do
      counter2=1
      baseRow=1
      counter=1
	row=1
	colm=10
   for   stock   in   `cat stocks.txt` 
   do
      wget   -qO-   http://finance.yahoo.com/d/quotes.csv?s=$stock\&f=nl1c1v >data10

	cat data10 | sed s/", "/" "/g >data10new
	mv data10new data10

      tput cup $baseRow $colm;
      echo "       $stock"
      
      row=$((row + 1))
      
      while [ $counter2 -ne 5 ]
      do
            name=`cat data10 | awk -F, '{print $'$counter2'}'`
            tput cup $row $colm;
            echo "              "
            tput cup $row $colm;
            echo "$name"
            counter2=$((counter2 + 1))
            row=$((row + 1))

      done
      counter2=1
      
      if [ $counter -ge 1 ]
      then
	      colm=$((colm + 25))
            if [ $colm -ge 150 ]
            then
                  colm=10
                  baseRow=$((baseRow + 6))
            fi
            row=baseRow

      else
            counter=1

      fi

   done
done

